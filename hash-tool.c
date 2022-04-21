#include <windows.h>
#include <stdio.h>
#include "os.h"

#include "hash.h"

#include "hash.c"


#define TEST_TYPE_PASS_FAIL
#define TEST_TYPE_PERCENTAGE
#define TEST_TYPE_TIMER


typedef union testProc {
    int (*pass_fail)();
    char (*percentage)();
    int  (*timer)();
} testProc;

/* Unit tests are very low level, close to the source the application.
   They consist in testing individual methods and functions of the classes,
   components or modules used by your software. Unit tests are in general
   quite cheap to automate and can be run very quickly by a continuous
   integration server
*/
typedef struct UnitTest {
    char *name;
    int type;
    testProc proc;
} UnitTest;

/* Integrations tests verify that different modules or services used
   by the application work well together. For example, it can be
   testing the interaction with the database or making sure that
   microservices work together as expected. These types of tests are
   more expensive to run as they require multiple parts of the application
   to be up and running
*/
typedef struct IntegrationTest {
    char *name;
} IntegrationTest;

/* Functional tests focus on the business requirements of an application.
   They only verify the output of an action and do not check the
   intermediate states of the system when performing that action.
   There is sometimes a confusion between integration test may simply
   verify that you can query the database while a functional test would
   expect to get a specific value from the database as defined by the
   product requirements.
*/
typedef struct FunctionalTest {
    char *name;
} FunctionalTest;


/* Performance tests check the behaviors of the system when it is under
   significant load. These tests are non-functional and can have the
   various form to understand the reliability, stability, and
   availability of the platform. For instance, it can be observing response
   times when executing a high number of requests, or seeing how the sytem
   behaves with a significant of data.
   Performance tests are by their nature quite costly to implement and run,
   but they can help you understand if new changes are going to degrade
   the system.
*/
typedef struct PerformanceTest {
    char *name;
} PerformanceTest;


/*
struct UnitTestView {
} UnitTestView;
*/


void RunTest(UnitTest *ut)
{
    int count;
    switch(1) {
        while(count--) {
            // call test function
        }
    }
}


typedef struct Document {
    char *name;
    int type;
    char *buffer;
} Document;


Document *document_new(char *name, char *type);


document_delete(Document *doc);


//void new_header(char *text);

//test_document(

/*
SystemFile * new_file()
{
    void *FileHandle;
    long DesiredAccess;
    OBJECT_ATTRIBUTES ObjectAttributes;
    IO_STATUS_BLOCK IoStatusBlock;
    LARGE_INTEGER AllocationSize;
    uns
    NtCreateFile();
}
*/


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

/*
typedef union _LARGE_INTEGER {
    struct {
        unsigned long LowPart;
        long HighPart;
    };
    struct {
        unsigned long LowPart;
        long HighPart;
    } u;
    long long QuadPart;
} LARGE_INTEGER;
*/


void __stdcall RtlInitUnicodeString(
     UNICODE_STRING *OutString,
     wchar_t *InString)
{
    wchar_t *End = InString;
    while(*End++);
    OutString->Length = ((End - InString) - 1) << 1;
    OutString->MaximumLength = OutString->Length;
    OutString->Buffer = InString;
}

void * __stdcall NtCurrentProcess();

long __stdcall NtCreateFile(void **FileHandle, long DesiredAccess,
    OBJECT_ATTRIBUTES *ObjectAttributes, IO_STATUS_BLOCK *IoStatusBlock, 
    LARGE_INTEGER *AllocationSize, long FileAttribute,
    long ShareAccess, long CreateDisposition, long CreateOptions,
    void *EaBuffer, long EaLength);

long __stdcall NtWriteFile(void *FileHandle, void *Event,
    PIO_APC_ROUTINE ApcRoutine, void *ApcContext, IO_STATUS_BLOCK *IoStatusBlock,
    void *Buffer, unsigned long Length, LARGE_INTEGER *ByteOffset,
    unsigned long *Key);

long __stdcall NtReadFile(void *FileHandle, void *Event,
    PIO_APC_ROUTINE ApcRoutine, void *ApcContext, IO_STATUS_BLOCK *IoStatusBlock,
    void *Buffer, unsigned long Length, LARGE_INTEGER *ByteOffset,
    unsigned long *Key);

long __stdcall NtDeleteFile(OBJECT_ATTRIBUTES *ObjectAttributes);

long __stdcall NtClose(void *Handle);

long __stdcall NtAllocateVirtualMemory(void *ProcessHandle,
    void **BaseAddress, long ZeroBits, long *RegionSize,
    unsigned long AllocationType, unsigned long Protect);

long __stdcall NtFreeVirtualMemory(void *ProcessHandle,
    void **BaseAddress, long *RegionSize, unsigned long FreeType);

long __stdcall NtCreateKey(void **KeyHandle, long DesiredAccess,
    OBJECT_ATTRIBUTES *ObjectAttributes, long TitleIndex,
    UNICODE_STRING Class, long CreateOptions, long *Disposition);

long __stdcall NtOpenKey(void **KeyHandle, long DesiredAccess,
    OBJECT_ATTRIBUTES *ObjectAttributes);

long __stdcall NtQueryValueKey(void *KeyHandle, UNICODE_STRING *ValueName,
    long KeyValueInformationClass, void *KeyValueInformation,
    unsigned long Length, unsigned long *ResultLength);

long __stdcall NtSetValueKey(void *KeyHandle, UNICODE_STRING *ValueName,
    long TitleIndex, long Type, void *Data, long DataSize);


long __fastcall next_pow2(long n);


typedef struct ipool {
    void * (*create)(void *s);
    void (*destroy)();
    long (*num_free)();
    void * (*alloc)();
    void (*free)();
} ipool;


// The number of mebibytes to reserve in the application
#define POOL_FACTORY_RESERVE 2

#define KIBIBYTE 1024
#define MEBIBYTE 1048576

#define POOL_COUNT ((POOL_FACTORY_RESERVE * MEBIBYTE) / (KIBIBYTE * 64))



typedef struct bk_pool {
    char *name;
    void *base;
    long size;
    long block_size;
    long num_blocks;
    long num_free;
    long num_init;
    void *next;
} bk_pool;


typedef struct {
    void *base;
    long num_pools;

    bk_pool pool[POOL_COUNT];
} pool_factory;




#define WINDOWS

#define KeyValuePartialInformation 2

typedef struct KEY_VALUE_PARTIAL_INFORMATION {
    unsigned long TitleIndex;
    unsigned long Type;
    unsigned long DataLength;
    char Data[1];
} KEY_VALUE_PARTIAL_INFORMATION;


void windows_register_com_object()
{
    UNICODE_STRING string;
    OBJECT_ATTRIBUTES oa = {0};

/*
    RtlInitUnicodeString(&string,
        L"\\Registry\\Machine\\SOFTWARE\\Classes\\Outlook.Application.16");
*/
    RtlInitUnicodeString(&string,
        L"\\Registry\\Machine\\SOFTWARE\\BlueStacks\\Agent\\Cloud");

    oa.SizeOf = sizeof(oa);
    oa.RootDirectory = 0;
    oa.ObjectName = &string;
    oa.Attributes = 0;
    oa.SecurityDescriptor = 0;
    oa.SecurityQualityOfService = 0;

    void *key_handle = 0;
    long status;
    status = NtOpenKey(&key_handle, KEY_QUERY_VALUE, &oa);
    printf("Status: 0x%x\nKey Handle: 0x%x\n", status, (long)key_handle);


    char buffer[256];
    KEY_VALUE_PARTIAL_INFORMATION *key_info = (void*)buffer;
    long rl;
    RtlInitUnicodeString(&string, L"Host");
    status = NtQueryValueKey(key_handle, &string, KeyValuePartialInformation, &buffer, 256, &rl);
    printf("NtQueryValueKey: 0x%x\n", status);

    wprintf(L"Data: %.*s\n", key_info->DataLength, (wchar_t*)key_info->Data);
}


void *mem_alloc_aligned()
{
    return 0;
}


void *mem_alloc_unaligned(long size)
{
    size = next_pow2(size);
    // lzcnt
    return 0;
}


void create_pool_factory()
{
    void *base;
    long status;
    long size;
    static pool_factory factory = {0};
    //if(factory.) return factory;
    size = POOL_FACTORY_RESERVE * MEBIBYTE;
    status = NtAllocateVirtualMemory(NtCurrentProcess(),
             &base, 0, &size, MEM_RESERVE, PAGE_READWRITE);
    factory.base = base;
    factory.num_pools = POOL_COUNT;
}


/* Need to align the pool_size on an allocation granularity boundary
   and align the block_size on a 8 byte boundary then divide */
void * bk_pool_create(bk_pool *pool, long num_blocks, long block_size)
{
    long status;
    void *base;
    long pool_size;
    // ensure the block size is a power of two
    block_size = next_pow2(block_size);
    num_blocks = next_pow2(num_blocks);
    pool_size  = num_blocks * block_size;
    printf("pool_size: %u\n", pool_size);
    // align the pool size on
#ifdef WINDOWS
    status = NtAllocateVirtualMemory(NtCurrentProcess(), &base, 0,
        &pool_size, MEM_RESERVE|MEM_COMMIT, PAGE_READWRITE);
    printf("NtAllocateVirtualMemory: 0x%x\n", status);
#endif
    pool->next = base;
    pool->block_size = block_size;
    pool->num_blocks = num_blocks;
    pool->num_free   = num_blocks;
    pool->num_init = 0;
    pool->next = 0;
    return pool;
}


void bk_destroy_pool(bk_pool *pool)
{
    long status;
    void *base = pool->base;
    long size = pool->size;
#ifdef WINDOWS
    status = NtFreeVirtualMemory(NtCurrentProcess(), &base, &size, MEM_DECOMMIT);
    if(status){
        printf("NtFreeVirtualMemory: 0x%x\n", status);
    }
#endif
}


void *bk_alloc(bk_pool *pool)
{
    void *block = 0;
    if(pool->num_init < pool->num_blocks)
    {
    }
    return block;
}




/**
 * 1. Open the file specified on the command. The file should contain a list of strings
      to be hashed separated by new lines
   2. Create or open the file that contain the hash values as well as the table index and length
*/


#define FILE_CREATED 2
#define FILE_OPENED 1


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

    bk_pool pool;

    //bk_pool_create(&pool, 10, 43);

    printf("NUMBER: %u | %u\n", (33 * 32769), (33<<15) + 33);


    long status;
    void *FileHandle = 0;
    OBJECT_ATTRIBUTES oa;
    IO_STATUS_BLOCK iosb = {0};
    UNICODE_STRING string;
    LARGE_INTEGER offset = {0};


    //windows_register_com_object();


    RtlInitUnicodeString(&string, L"\\??\\\\H:\\Dev\\hash-tool\\newfile1.txt"); 

    //wprintf(L"Size: %u | %s\n", string.Length, string.Buffer);

    oa.SizeOf = sizeof(oa);
    oa.RootDirectory = 0;
    oa.ObjectName = &string;
    oa.Attributes = 0;
    oa.SecurityDescriptor = 0;
    oa.SecurityQualityOfService = 0;

    long AccessRights = 0;
    //AccessRights = FILE_WRITE_ACCESS | FILE_READ_ACCESS | SYNCHRONIZE;
    AccessRights = FILE_READ_DATA | FILE_WRITE_DATA | SYNCHRONIZE;

    printf("FileHandle: 0x%p\n", FileHandle);
    status = NtCreateFile(&FileHandle, AccessRights, &oa, &iosb, 0, FILE_ATTRIBUTE_NORMAL, FILE_SHARE_READ | FILE_SHARE_DELETE, FILE_OPEN_IF, FILE_NON_DIRECTORY_FILE, 0, 0);
    if(status){
        printf("NtCreateFile: 0x%x\n", status);
        return 0;
    }

    printf("FileHandle: 0x%p\n", FileHandle);
    printf("Disposition: 0x%u\n", iosb.Status);

    status = NtWriteFile(FileHandle, 0, 0, 0, &iosb, "Hello World", 11, &offset, 0);
    if(status){
        printf("NtWriteFile: 0x%x\n", status);
    }

    NtClose(FileHandle);

    status = NtDeleteFile(&oa);
    printf("NtDeleteFile: 0x%x\n", status);


    void *base_address = 0;
    long region_size = 65536;
    status = NtAllocateVirtualMemory(NtCurrentProcess(), &base_address, 0, &region_size, MEM_RESERVE, PAGE_READWRITE);
    printf("NtAllocateVirtualMemory: 0x%x\n", status);

    status = NtFreeVirtualMemory(NtCurrentProcess(), &base_address, &region_size, MEM_DECOMMIT);
    printf("NtFreeVirtualMemory: 0x%x\n", status);

    //NtCreateKey();




    test_hash_value_equality(hash_djb2_32, hashb_djb2, DJB2_INIT);
    test_hash_value_equality(hash_sdbm_32, hashb_sdbm, 0);
    test_hash_value_equality(hash_wakkerbot_32, hashb_wakkerbot, 0);
    test_hash_value_equality(hashb_jenkins1_1, hashb_jenkins1_2, 0);

    //test_hash_value_reentry_equality(hash_djb2_32, hashb_djb2, DJB2_INIT);
    //test_hash_value_reentry_equality(hash_sdbm_32, hashb_sdbm, 0);
    //test_hash_value_reentry_equality(hash_wakkerbot_32, hashb_wakkerbot, 0);



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
