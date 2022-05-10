global  @next_pow2@4

[section .bss]


[section .data]

 
[section .text]

%ifdef COMMENT
0x000000002            2
0x000000004            4
0x000000008            8
0x000000010           16
0x000000020           32
0x000000040           64
0x000000080          128
0x000000100          256
0x000000200          512
0x000000400         1024
0x000000800         2048
0x000001000         4096
0x000002000         8192
0x000004000        16384
0x000008000        32768
0x000010000        65536
0x000020000       131072
0x000040000       262144
0x000080000       524288
0x000100000      1048576    1Mb
0x000200000      2097152    2Mb
0x000400000      4194304    4Mb
0x000800000      8388608    8Mb
0x001000000     16777216   16Mb
0x002000000     33554432   32Mb
0x004000000     64108864   64Mb
0x008000000    134217728  128Mb
0x010000000    268435456  256Mb
0x020000000    536870912  512Mb
0x040000000   1073741824    1Gb
0x080000000   2147483648    2Gb
0x100000000   4294967296    4Gb
0x200000000   8589934592    8Gb
0x400000000  17179869184   16Gb
%endif


@next_pow2@4:
    mov    eax, ecx       ; fastcall, get first param
    mov    ecx, 31
    lzcnt  edx, eax       ; count leading zeros and
    sub    cl,  dl        ; subtract from 31 to get first bit set
    mov    edx, 1
    shl    edx, cl        ; shift 1 to next pow2 position
    mov    ecx, edx
    sub    edx, 1
    shl    ecx, 1
    test   eax, edx
    cmovnz eax, ecx
    ret
    ;add    esp, 4
    ;jmp    [esp-4]


@next_pow2_@4:
    mov    eax, ecx
    sub    ecx, 1 
    lzcnt  edx, ecx   ;31
    mov    ecx, 31
    ;sub    ecx, reg  
    mov    ecx, 1
    ;shl    reg, cl
    ;cmp    reg, ecx
    ;cmove  reg, ecx


    ;call   _NtAllocateVirtualMemory@24


POOL_STRUCT_SIZE   equ 32
pool_numBlocks     equ pool_blockSize - 4
pool_blockSize     equ pool_numFreeBlocks - 4
pool_numFreeBlocks equ pool_numInit - 4
pool_numInit       equ pool_memBase - 4
pool_memBase       equ pool_next - 4
pool_next          equ pool_padding - 4
pool_padding       equ POOL_STRUCT_SIZE - 8


; Based on the paper 'Fast Efficient Fixed-Sized Memory Pool' by Ben Kenwright

; allocate memory of an unaligned size
; eax - base address of allocated memory
; ebx - blockSize / nextBlock
; ecx - allocation size / index multiplier
; edx - numFreeBlocks
; esi - base address of pool
; edi - index
; reg - numInit
; reg - 
@mem_allocu@4:
    sub    esp, 16
    mov    [esp],    ebp
    mov    [esp+4],  ebx
    mov    [esp+8],  esi
    mov    [esp+12], edi

    mov    esi, [ecx+pool_memBase]

    call   @next_pow2@4    ; align the size on power of 2
    lzcnt  ecx, eax
    ;lea    edx, array
    mov    eax, 31
    sub    eax, ecx
    ; if pointers
    ;mov   edx, [edx+eax*4]

    xor    eax, eax       ; eax = 0

    ; if structs
    ;mov   ecx, sizeof(struct pool)
    ;imul  eax, ecx
    ;lea   edx, [edx+eax]

    mov   ebx, [esi+pool_blockSize]      ; reg2 = blockSize
    ;mov   reg3, [esi+pool_numInit]        ; reg3 = numInit
    ;mov   reg5, [esi+pool_numBlocks]      ; reg5 = numBlocks

    ;mov   regIndex, dword [next]
    ;xor   next, next
; AddrFromIndex
    tzcnt ecx, ebx
    shl   edi, cl 
    lea   edi, [esi+edi*ebx]       ; base + (index * blocksize)

    ;test   numfree, numfree
    ;cmovnz [next], reg
    ;add    reg3, 1
    ;cmp    reg3, reg5                  ;if(pool->numInit < pool->numBlocks)
    ;cmovl  reg2, reg3                  ; *p = numInit + 1
    ;mov   [base+numInit], 

    ;mov    reg, [base+nextFreeBlocks]
    mov    edx, [esi+pool_numFreeBlocks]
    cmp    edx, eax 
    cmovz  eax, nextFreeBlocks
    ;mov    reg2, reg1                  ; copy numFreeBlocks
    ;sub    reg2, 1
    ;mov    reg3, dword [next]
    ;cmovnz reg1, reg2

    mov    ebp, [esp]
    mov    ebx, [esp+4]
    mov    esi, [esp+8]
    mov    edi, [esp+12]
    add    esp, 20 
    jmp    [esp-20]


; allocate memory of an aligned size
; void *mem_alloca(int size);
@mem_alloca@4:
    lzcnt  ecx, ecx
    ;lea    edx, array
    mov    ecx, 32
    ;mov    eax, [edx+ecx+sizeof()]


; free memory  of unaligned size
@mem_freeu@8:
    call   @next_pow2@4
    lzcnt  ecx, eax
    mov    eax, [ebp+ecx*4]


; free memory of aligned size
; void mem_freea(int size, void *ptr);
@mem_freea@8:
    lzcnt  ecx, ecx
    mov    eax, [ebp+ecx*4]

