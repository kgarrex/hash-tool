
[section .text]

global @hashb_djb2@12
global @hashb_sdbm@12
global @hashb_wakkerbot@12



DJB2_INITIAL_HASH  equ 5381
;********************************************************
; djb2 xor variation
;
; fastcall
;
; ecx - string length
; edx - string pointer
; ebx - hash shift left register 
; return: eax - hash value
;
; source: www.cse.yorku.ca/~oz/hash.html
;
;********************************************************
@hashb_djb2@12:
    mov eax, [esp+4]      ;set the initial hash value
    sub esp, 8            ;create space on the stack
    mov [esp+4], edi
    mov [esp], esi
    xor esi, esi
    mov edi, ecx
.loop:
    imul eax, eax, 33
    movsx ecx, byte [esi+edx]
    xor eax, ecx
    add esi, 1
    cmp esi, edi
    jl .loop
    mov edi, [esp+4]
    mov esi, [esp]
    add esp, 16
    jmp [esp-8]


;********************************************************
; hashb_sdbm
;
; ecx - string length
; edx - string pointer
; ebx - hash shift left register 
; return: eax - hash value
;
; source: www.cse.yorku.ca/~oz/hash.html
;
;********************************************************
@hashb_sdbm@12:
    mov eax, [esp+4]     ;set the initial hash value
    sub esp, 8           ;create space on the stack
    mov [esp+4], edi
    mov [esp], esi
    xor esi, esi
    mov edi, ecx
    ; need to test edi = 0 here for zero-terminated string
.loop:
    imul eax, eax, 65599
    movsx ecx, byte [esi+edx]
    add eax, ecx
    add esi, 1
    cmp esi, edi
    jl .loop
    mov esi, [esp]
    mov edi, [esp+4]
    add esp, 16
    jmp [esp-8]


;********************************************************
; hashb_wakkerbot
;
; ecx - string length
; edx - string pointer
; ebx - hash shift left register 
; edi - hash shift right register
; return: eax - hash value
;
; source: https://stackoverflow.com/a/10497882/6015482
;
;********************************************************
@hashb_wakkerbot@12:
    mov eax, [esp+4]      ;set the initial hash value
    sub esp, 12            ;create space on the stack
    mov [esp+8], ebx
    mov [esp+4], edi
    mov [esp], esi
    mov edi, ecx
    xor esi, esi
.loop:
    movsx ecx, byte [esi+edx]
    mov ebx, eax
    shl ebx, 8
    add esi, 1
    xor ebx, eax
    shl ebx, 5
    xor ebx, ecx
    mov ecx, eax
    shr ecx, 2
    xor ebx, ecx 
    xor eax, ebx
    xor eax, -2147477503   ;0x80001801
    cmp esi, edi
    jl .loop
    mov ebx, [esp+8]
    mov edi, [esp+4]
    mov esi, [esp]
    add esp, 20 
    jmp [esp-8]



FNV_32_PRIME equ 0x01000193
_hash_fnv1_32:
mov eax, [esp]
.loop:
mov edx, eax
shl edx, 1
add eax, edx 
shl edx, 3
add eax, edx
shl edx, 3
add eax, edx
shl edx, 1
add eax, edx
shl edx, 16
add eax, edx
xor al, byte [esi]
add esi, 1
sub ecx, 1
jnz .loop
jmp [esp]


FNV_64_PRIME equ 0x100000001b3
_hash_fnv1_64:
.loop:
shl edx, 1
add eax, edx
shl edx, 3
add eax, edx
shl edx, 1
add eax, edx
shl edx, 2
add eax, edx
shl edx, 1
add eax, edx
shl edx, 32
add eax, edx
xor al, byte [esi]
add esi, 1
sub ecx, 1
jnz .loop
add esp, 8
jmp [esp]


;********************************************************
; Bob Jenkins one_at_a_time hash from his Dr. Dobbs's article
;
; eax - hash value
; ecx - string length
; edx - string pointer
; ebx - hash shift right register
; edi - hash shift left register 
;
;********************************************************
@hashb_jenkins_1@12:
    mov eax, [esp+4]     ; set the initial hash value
    sub esp, 8           ; create space on the stack
    mov [esp+4], ebx     ; save the shift right register
    mov [esp], edi       ; save the shift left register
.loop:
    mov edi, eax         ; copy hash to shift left register
    mov ebx, eax         ; copy hash to shift right register
    shl edi, 10
    add eax, edi
    shr ebx, 6
    add eax, ebx
    add al, byte [edx]
    add esi, 1
    sub ecx, 1
    jnz .loop
    mov edi, eax
    mov ebx, eax
    shl edi, 3
    add eax, edi
    shl edi, 12
    add eax, edi
    shr ebx, 11
    xor eax, ebx
    mov ebx, [esp+4]
    mov edi, [esp]
    add esp, 16
    jmp [esp-4]



BitUnsignedInt equ 4*8
ThreeQuarters  equ (32*3)/4
OneEigth       equ 32/8
_hash_pjw_32:
