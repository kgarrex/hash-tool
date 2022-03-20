
#define HASH_FASTCALL __fastcall


typedef unsigned long (HASH_FASTCALL *hashb_proc)(
    int length, char *str, unsigned long hash
);


unsigned long HASH_FASTCALL
hashb_djb2(int length, char *str, unsigned long hash);


unsigned long HASH_FASTCALL
hashb_sdbm(int length, char *str, unsigned long hash);


unsigned long HASH_FASTCALL
hashb_wakkerbot(int length, char *str, unsigned long hash);


unsigned long HASH_FASTCALL 
jenkins_one_at_a_time(unsigned int count, char *str);


#define FNV1_32_INIT 0x811c9dc5

#define FNV1_64_INIT 0xcbf29ce484222325ULL

/*
 * FNV hashes are designed to be fast while maintaining a low
 * collision rate. The FNV speed allows one to quickly hash lots
 * of data while maintaining a reasonable collision rate. See:


 */
//unsigned long fnv132(unsigned char *str, 
