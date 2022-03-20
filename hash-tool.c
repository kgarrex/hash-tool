#include <windows.h>
#include <stdio.h>

#include "hash.h"



#define DJB2_INIT 5381

/* source: www.cse.yorku.ca/~oz/hash.html */

unsigned long HASH_FASTCALL
hash_djb2_32(int length, char *key, unsigned long hash)
{
    for(int i = 0; i < length; i++)
        hash = ((hash << 5) + hash) ^ key[i]; /* hash * 33 ^ str[i] */
    return hash;
}


/* hash can be initialize to zero */
unsigned long HASH_FASTCALL
hash_sdbm_32(int length, char *key, unsigned long hash) 
{
    for(int i = 0; i < length; i++)
        hash = key[i] + (hash << 6) + (hash << 16) - hash;
    return hash;
}



/* source: https://stackoverflow.com/a/10497882/6015482 */
/* source: https://sourceforge.net/projects/wakkerbot/files/megahal.c/download */
/* hash can be initialized to zero */
unsigned long HASH_FASTCALL
hash_mem_32(long length, char *key, unsigned long hash)
{
    for(int i = 0; i < length; i++)
        hash ^= (hash>>2) ^ (hash<<5) ^ (hash<<13) ^ key[i] ^ 0x80001801;
    return hash;
}


#define FNV_32_PRIME 0x01000193
unsigned long HASH_FASTCALL
fnv1_32(long length, char *key, unsigned long hash)
{
    return hash;
}


#define FNV_64_PRIME 0x100000001b3
unsigned long HASH_FASTCALL
fnv1_64(long length, char *key, unsigned long hash)
{
    return hash;
}


// hash - can be initialized to zero
unsigned long HASH_FASTCALL
hashb_jenkins1(long length, char *key, unsigned long hash)
{
    int i = 0;
    while(i != length) {
        hash += key[i++] + (hash << 10) ^ (hash >> 6);
        //h += key[i++];
        //h += h << 10;
        //h ^= h >> 6;
    }
    hash += (hash << 3) ^ (hash >> 11) + (hash << 15);
    //h += h << 3;
    //h ^= h >> 11;
    //h += h << 15;
    return hash;
}



/* Hashing algorith created by Robert Sedgewick */
/* https://stackoverflow.com/a/6137031/6015482 */
unsigned long HASH_FASTCALL
hash_rs_32(unsigned char *key, int length)
{
    unsigned int b = 378551;
    unsigned int a = 63689;
    unsigned int i = 0;
    unsigned long hash = 0;
    while(i < length)
    {
        hash = (hash * a) + key[i];
        a = a * b;
        i++;
    }
    return hash;
}


#define BitUnsignedInt 
unsigned long HASH_FASTCALL
hash_pjw_32(unsigned char *key, int length)
{
    unsigned long hash = 0;
    for(int i = 0; i < length; i++)
    {
        //hash = (hash << ONE_EIGTH
    }

    return hash;
}



int test_hash_value_equality
(hashb_proc c_proc, hashb_proc asm_proc, unsigned long hash)
{
// compare c implementation to the asm implementation
    unsigned long h1, h2;

    int len = 4;
    char *str = "TEST";
    
    h1 = c_proc(len, str, hash);
    h2 = asm_proc(len, str, hash);

    printf("test_hash_value_equality: %u == %u\n", h1, h2);
    return h1 == h2;
}


int test_hash_value_reentry_equality
(hashb_proc c_proc, hashb_proc asm_proc, unsigned long hash)
{
    unsigned long h1 = hash, h2 = hash;
    int len = 4;
    char *str = "TEST";

    h1 = c_proc(len>>1, str, h1);
    h1 = c_proc(len>>1, str+(len>>1), h1);

    h2 = asm_proc(len>>1, str, h2);
    h2 = asm_proc(len>>1, str+(len>>1), h2);

    printf("test_hash_value_reentry_equality: %u == %u\n", h1, h2);
    return h1 == h2;
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

    while(strptr != (const char *)eof) {
        if(*strptr == '\r') { // skip two 
            cnt = strptr - (const char *)line;
            callback(ctx, (char*)line, cnt);
            strptr += 2;
            (const char*)line = strptr;
        }
        else if(*strptr == '\n') { // skip one
            cnt = strptr - (const char *)line;
            callback(ctx, (char*)line, cnt);
            strptr++;
            (const char*)line = strptr;
        }
        else {
            strptr++;
        }
    }
}


char spaces[256];
char linebuffer[256];



struct data
{
    HANDLE writeHandle;
    unsigned int mod;
    unsigned int max;
    unsigned int count;
    hashb_proc hash;
    // average hash time
};




void first_pass(struct data *data, char *str, int count)
{
    if(count > data->max) {
        data->max = count;
    }
    data->count++;
}



void second_pass(struct data *data, char *str, int count)
{
    DWORD numwritten;
    unsigned long hash;
    char *ptr = linebuffer;

    hash = data->hash(count, str, 0);

    memcpy(ptr, str, count);
    ptr += count;
    memcpy(ptr, spaces, data->max - count);
    ptr += data->max - count;

    ptr += sprintf(ptr, " | %u | 0x%p | %u\n",
        count, (void*)hash, hash % data->mod);

    printf("%.*s", ptr - linebuffer, linebuffer);
    WriteFile(data->writeHandle, linebuffer, ptr - linebuffer, &numwritten, 0);
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


    test_hash_value_equality(hash_djb2_32, hashb_djb2, DJB2_INIT);
    test_hash_value_equality(hash_sdbm_32, hashb_sdbm, 0);

    test_hash_value_reentry_equality(hash_djb2_32, hashb_djb2, DJB2_INIT);
    test_hash_value_reentry_equality(hash_sdbm_32, hashb_sdbm, 0);

    data.hash = hashb_sdbm;
    //data.hash = hashb_wakkerbot;
    data.hash = hash_sdbm_32;

    hfile[0] = CreateFileA(filename, GENERIC_READ, 0, 0, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
    if(hfile[0] == INVALID_HANDLE_VALUE) {
        printf("Error: File Could not be opened\n");
        return 1;
    }

    filesize = GetFileSize(hfile[0], 0);

    printf("Filename(%u): %s\n", filesize, filename);


    hfilemap = CreateFileMappingA(hfile[0], 0, PAGE_READONLY, 0, 0, 0);
    if(!hfilemap) {
        printf("Error(%d): File Mapping could not be created\n", GetLastError());
        return 2;
    }

    filedata = MapViewOfFile(hfilemap, FILE_MAP_READ, 0, 0, 0);
    if(!filedata) {
        printf("Error: Could not map view of file\n", GetLastError());
        return 3;
    }

    //printf("%s\n", filedata);

    unsigned int max = 0;
    foreach_line(filedata, filesize, first_pass, &data);

    printf("Max: %u  | Count: %u\n", data.max, data.count);


    data.writeHandle = CreateFileA("hashes-output.txt", GENERIC_WRITE, 0, 0, OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
    if(data.writeHandle == INVALID_HANDLE_VALUE) {
        printf("Error: Could not create new file\n");
        return 1;
    }


    foreach_line(filedata, filesize, second_pass, &data);

    //WriteFile(hfile[1], buffer, 512, &numwritten, 0);


    return 0;
}
