#include <windows.h>
#include <stdio.h>


unsigned long djb2(unsigned char *str, int length)
{
    unsigned long hash = 5381;

    for(int i = 0; i < length; i++)
    {
        hash = ((hash << 5) + hash) + str[i]; /* hash * 33 + str[i] */
    }
    return hash;
}


unsigned long sdbm(unsigned char *str, int length)
{
    unsigned long hash = 0;
    for(int i = 0; i < length; i++)
    {
        hash = str[i] + (hash << 6) + (hash << 16) - hash;
    }
    return hash;
}



void foreach_line(
    const char *strptr,
    int length,
    void (*callback)(void*, char *str, int count),
    void *ctx)
{
    register line = (int)strptr;
    register cnt;
    register eof = (int)strptr + length;


    while(strptr != (const char *)eof)
    {
        if(*strptr == '\r') // skip two
        {
            cnt = strptr - (const char *)line;
            callback(ctx, (char*)line, cnt);
            strptr += 2;
            (const char*)line = strptr;
        }
        else if(*strptr == '\n') // skip one
        {
            cnt = strptr - (const char *)line;
            callback(ctx, (char*)line, cnt);
            strptr++;
            (const char*)line = strptr;
        }
        else
        {
            strptr++;
        }
    }
}


char spaces[256];
char linebuffer[256];



struct data
{
    unsigned int mod;
    unsigned int max;
    unsigned int count;
    unsigned long (*hash)(unsigned char *, int);
};



void first_pass(struct data *data, char *str, int count)
{

    if(count > data->max)
    {
        data->max = count;
    }
    data->count++;
}



void second_pass(struct data *data, char *str, int count)
{
    unsigned long hash;
    char *ptr = linebuffer;

    hash = data->hash(str, count);

    memcpy(ptr, str, count);
    ptr += count;
    memcpy(ptr, spaces, data->max - count);
    ptr += data->max - count;

    ptr += sprintf(ptr, " | %u | 0x%p | %u", count, hash, hash % data->mod);

    printf("%.*s\n", ptr - linebuffer, linebuffer);
}


/**
 * 1. Open the file specified on the command. The file should contain a list of strings
      to be hashed separated by new lines
   2. Create or open the file that contain the hash values as well as the table index and length
*/


int main(int argc, char **argv)
{

    char *filename;
    HANDLE hfile[2];
    HANDLE hfilemap;
    char *filedata;

    DWORD filesize;

    char buffer[512];


    struct data data;

    memset(spaces, ' ', 256);

    //char *end =;


    filename = argv[1];

    data.max = 0;
    data.mod = 71;
    data.count = 0;

    data.hash = sdbm;

    hfile[0] = CreateFileA(filename, GENERIC_READ, 0, 0, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
    if(hfile[0] == INVALID_HANDLE_VALUE)
    {
        printf("Error: File Could not be opened\n");
        return 1;
    }

    filesize = GetFileSize(hfile[0], 0);

    printf("Filename(%u): %s\n", filesize, filename);


    hfilemap = CreateFileMappingA(hfile[0], 0, PAGE_READONLY, 0, 0, 0);
    if(!hfilemap)
    {
        printf("Error(%d): File Mapping could not be created\n", GetLastError());
        return 2;
    }

    filedata = MapViewOfFile(hfilemap, FILE_MAP_READ, 0, 0, 0);
    if(!filedata)
    {
        printf("Error: Could not map view of file\n", GetLastError());
        return 3;
    }

    //printf("%s\n", filedata);

    unsigned int max = 0;
    foreach_line(filedata, filesize, first_pass, &data);

    printf("Max: %u  | Count: %u\n", data.max, data.count);

    foreach_line(filedata, filesize, second_pass, &data);


    hfile[1] = CreateFileA("hashes.txt", GENERIC_WRITE, 0, 0, OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
    if(hfile[1] == INVALID_HANDLE_VALUE)
    {
        printf("Error: Could not create new file\n");
        return 1;
    }


    DWORD numwritten;
    memcpy(buffer, filedata, 512);

    WriteFile(hfile[1], buffer, 512, &numwritten, 0);


    return 0;
}
