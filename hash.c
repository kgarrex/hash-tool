
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



/* hash can be initialized to zero */
hash_loseLose(int length, char *key, unsigned long hash)
{
    char *end = key + length;
    while(key != end) {
        hash += *key++;
    }
}



/* source: https://stackoverflow.com/a/10497882/6015482 */
/* source: https://sourceforge.net/projects/wakkerbot/files/megahal.c/download */
/* hash can be initialized to zero */
unsigned long HASH_FASTCALL
hash_wakkerbot_32(int length, char *key, unsigned long hash)
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
hashb_jenkins1_1(long length, char *key, unsigned long hash)
{
    int i = 0;
    while(i != length) {
        hash += key[i++] + (hash << 10) ^ (hash >> 6);
    }
    hash += (hash << 3) ^ (hash >> 11) + (hash << 15);
    return hash;
}


// hash - can be initialized to zero
unsigned long HASH_FASTCALL
hashb_jenkins1_2(long length, char *key, unsigned long hash)
{
    int i = 0;
    while(i != length) {
        hash += key[i++];
        hash += hash << 10; //hash = (hash<<10) + hash; hash  * 1025
        hash ^= hash >> 6;
    }
    hash += hash << 3;      // hash = (hash<<3) + hash;  hash * 9 
    hash ^= hash >> 11;
    hash += hash << 15;     // hash = (hash<<15) + hash; hash * 32769
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


