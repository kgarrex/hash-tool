
global _NtCurrentProcess@0
global _NtCurrentTeb@0
global _NtCurrentPeb@0
global _NtClose@4
global _NtCreateFile@44
global _NtReadFile@36
global _NtWriteFile@36
global _NtDeleteFile@4
global _NtAllocateVirtualMemory@24
global _NtFreeVirtualMemory@16
global _NtCreateSection@28
global _NtMapViewOfSection@20
global _NtCreateUserProcess@44
global _NtCreateKey@28
global _NtOpenKey@12
global _NtSetValueKey@28
global _NtQueryValueKey@24
global _NtCreateNamedPipeFile@56
global _NtDelayExecution@8

global @doc_new@4



OSMAJORVERSION  equ 164
OSMINORVERSION  equ 168
OSBUILDNUMBER   equ 172
OSCSDVERSION    equ 174
OSPLATFORMID    equ 176


[section .bss]

array: resd 32


[section .data]
SyscallId: dw \
0x001, 0x002, 0x003, 0x004, 0x005, 0x006, 0x007, 0x008, 0x009, 0x00A, 0x00B, 0x00C, 0x00D, 0x00E, 0x00F, 0x010,\
0x011, 0x012, 0x013, 0x014, 0x015, 0x016, 0x017, 0x018, 0x019, 0x01A, 0x01B, 0x01C, 0x01D, 0x01E, 0x01F, 0x020,\
0x021, 0x022, 0x023, 0x024, 0x025, 0x026, 0x027, 0x028, 0x029, 0x02A, 0x02B, 0x02C, 0x02D, 0x02E, 0x02F, 0x030,\
0x031, 0x032, 0x033, 0x034, 0x035, 0x036, 0x037, 0x038, 0x039, 0x03A, 0x03B, 0x03C, 0x03D, 0x03E, 0x03F, 0x040,\
0x041, 0x042, 0x043, 0x044, 0x045, 0x046, 0x047, 0x048, 0x049, 0x04A, 0x04B, 0x04C, 0x04D, 0x04E, 0x04F, 0x050,\
0x051, 0x052, 0x053, 0x054, 0x055, 0x056, 0x057, 0x058, 0x059, 0x05A, 0x05B, 0x05C, 0x05D, 0x05E, 0x05F, 0x060,\
0x061, 0x062, 0x063, 0x064, 0x065, 0x066, 0x067, 0x068, 0x069, 0x06A, 0x06B, 0x06C, 0x06D, 0x06E, 0x06F, 0x070,\
0x071, 0x072, 0x073, 0x074, 0x075, 0x076, 0x077, 0x078, 0x079, 0x07A, 0x07B, 0x07C, 0x07D, 0x07E, 0x07F, 0x080,\
0x081, 0x082, 0x083, 0x084, 0x085, 0x086, 0x087, 0x088, 0x089, 0x08A, 0x08B, 0x08C, 0x08D, 0x08E, 0x08F, 0x090,\
0x091, 0x092, 0x093, 0x094, 0x095, 0x096, 0x097, 0x098, 0x099, 0x09A, 0x09B, 0x09C, 0x09D, 0x09E, 0x09F, 0x0A0,\
0x0A1, 0x0A2, 0x0A3, 0x0A4, 0x0A5, 0x0A6, 0x0A7, 0x0A8, 0x0A9, 0x0AA, 0x0AB, 0x0AC, 0x0AD, 0x0AE, 0x0AF, 0x0B0,\
0x0B1, 0x0B2, 0x0B3, 0x0B4, 0x0B5, 0x0B6, 0x0B7, 0x0B8, 0x0B9, 0x0BA, 0x0BB, 0x0BC, 0x0BD, 0x0BE, 0x0BF, 0x0C0,\
0x0C1, 0x0C2, 0x0C3, 0x0C4, 0x0C5, 0x0C6, 0x0C7, 0x0C8, 0x0C9, 0x0CA, 0x0CB, 0x0CC, 0x0CD, 0x0CE, 0x0CF, 0x0D0,\
0x0D1, 0x0D2, 0x0D3, 0x0D4, 0x0D5, 0x0D6, 0x0D7, 0x0D8, 0x0D9, 0x0DA, 0x0DB, 0x0DC, 0x0DD, 0x0DE, 0x0DF, 0x0E0,\
0x0E1, 0x0E2, 0x0E3, 0x0E4, 0x0E5, 0x0E6, 0x0E7, 0x0E8, 0x0E9, 0x0EA, 0x0EB, 0x0EC, 0x0ED, 0x0EE, 0x0EF, 0x0F0,\
0x0F1, 0x0F2, 0x0F3, 0x0F4, 0x0F5, 0x0F6, 0x0F7, 0x0F8, 0x0F9, 0x0FA, 0x0FB, 0x0FC, 0x0FD, 0x0FE, 0x0FF, 0x100,\
0x101, 0x102, 0x103, 0x104, 0x105, 0x106, 0x107, 0x108, 0x109, 0x10A, 0x10B, 0x10C, 0x10D, 0x10E, 0x10F, 0x110,\
0x111, 0x112, 0x113, 0x114, 0x115, 0x116, 0x117, 0x118, 0x119, 0x11A, 0x11B, 0x11C, 0x11D, 0x11E, 0x11F, 0x120,\
0x121, 0x122, 0x123, 0x124, 0x125, 0x126, 0x127, 0x128, 0x129, 0x12A, 0x12B, 0x12C, 0x12D, 0x12E, 0x12F, 0x130,\
0x131, 0x132, 0x133, 0x134, 0x135, 0x136, 0x137, 0x138, 0x139, 0x13A, 0x13B, 0x13C, 0x13D, 0x13E, 0x13F, 0x140,\
0x141, 0x142, 0x143, 0x144, 0x145, 0x146, 0x147, 0x148, 0x149, 0x14A, 0x14B, 0x14C, 0x14D, 0x14E, 0x14F, 0x150,\
0x151, 0x152, 0x153, 0x154, 0x155, 0x156, 0x157, 0x158, 0x159, 0x15A, 0x15B, 0x15C, 0x15D, 0x15E, 0x15F, 0x160,\
0x161, 0x162, 0x163, 0x164, 0x165, 0x166, 0x167, 0x168, 0x169, 0x16A, 0x16B, 0x16C, 0x16D, 0x16E, 0x16F, 0x170,\
0x171, 0x172, 0x173, 0x174, 0x175, 0x176, 0x177, 0x178, 0x179, 0x17A, 0x17B, 0x17C, 0x17D, 0x17E, 0x17F, 0x180,\
0x181, 0x182, 0x183, 0x184, 0x185, 0x186, 0x187, 0x188, 0x189, 0x18A, 0x18B, 0x18C, 0x18D, 0x18E, 0x18F, 0x190,\
0x191, 0x192, 0x193, 0x194, 0x195, 0x196, 0x197, 0x198, 0x199, 0x19A, 0x19B, 0x19C, 0x19D, 0x19E, 0x19F, 0x1A0,\
0x1A1, 0x1A2, 0x1A3, 0x1A4, 0x1A5, 0x1A6, 0x1A7, 0x1A8, 0x1A9, 0x1AA, 0x1AB, 0x1AC, 0x1AD, 0x1AE, 0x1AF, 0x1B0,\
0x1B1, 0x1B2, 0x1B3, 0x1B4, 0x1B5, 0x1B6, 0x1B7, 0x1B8, 0x1B9, 0x1BA, 0x1BB, 0x1BC, 0x1BD, 0x1BE, 0x1BF, 0x1C0,\
0x1C1, 0x1C2, 0x1C3, 0x1C4, 0x1C5, 0x1C6, 0x1C7, 0x1C8, 0x1C9, 0x1CA, 0x1CB, 0x1CC, 0x1CD, 0x1CE, 0x1CF, 0x1D0,\
0x1D1, 0x1D2, 0x1D3, 0x1D4, 0x1D5, 0x1D6, 0x1D7, 0x1D8, 0x1D9, 0x1DA, 0x1DB, 0x1DC, 0x1DD, 0x1DE, 0x1DF, 0x1E0,\
0x1E1, 0x1E2, 0x1E3, 0x1E4, 0x1E5, 0x1E6, 0x1E7, 0x1E8, 0x1E9, 0x1EA, 0x1EB, 0x1EC, 0x1ED, 0x1EE, 0x1EF, 0x1F0,\
0x1F1, 0x1F2, 0x1F3, 0x1F4, 0x1F5, 0x1F6, 0x1F7, 0x1F8, 0x1F9, 0x1FA, 0x1FB, 0x1FC, 0x1FD, 0x1FE, 0x1FF, 0x200,


[section .text]


_NtCurrentProcess@0:
    add esp, 4
    mov eax, -1
    ret 4

_NtCurrentTeb@0:
    add esp, 4
    mov eax, dword [fs:0x18]
    ret 4

_NtCurrentPeb@0:
    add esp, 4
    mov eax, dword [fs:0x30]
    ret 4


; Windows 10
; 1507  10240
; 1511  10586
; 1607  14393
; 1703  15063
; 1709  16299
; 1803  17134
; 1809  17763
; 1903  18362
; 1909  18363
; 2004  19041
; 20H2  19042
; 21H1  19043
; 21H2  19044
; Windows 11
; 21H2  22000


;******************************************
; NTSTATUS STDCALL NtClose(HANDLE Handle);
; Windows 10
;   1507  10240  15
;   1511  10586  15
;   1607  14393  15
;   1703  15063  15
;   1709  16299  15
;   1803  17134  15
;   1809  17763  15
;   1903  18362  15
;   1909  18363  15
;   2004  19041  15
;   20H2  19042  15
;   21H1  19043  15
;   21H2  19044  15
; Windows 11
;   21H2  22000
;
;*******************************************
_NtClose@4:
    mov    ecx, SyscallId
    mov    eax, dword [fs:0x30]
    mov    edx, eax
    mov    eax, [edx+OSMAJORVERSION]
.win10:
    cmp    eax, 10
    jne    .win8
    movzx  eax, word [edx+OSBUILDNUMBER]
    cmp    eax, 19044
    cmovle ax, word [ecx+14*2]
    jmp    .fin
.win8:
    cmp    eax, 8
    jne    .win7
.win7:
    cmp    eax, 7
    ;jne   notsupported
.fin:
    call   dword [fs:0xc0]
    add    esp, 8
    jmp    [esp-8]



;***************************************
; NTSTATUS STDCALL NtCreateFile(
;   PHANDLE FileHandle,
;   ACCESS_MASK DesiredAccess,
;   POBJECT_ATTRIBUTES ObjectAttributes,
;   PIO_STATUS_BLOCK IoStatusBlock,
;   PLARGE_INTEGER AllocationSize,
;   ULONG FileAttributes,
;   ULONG ShareAccess,
;   ULONG CreateDisposition,
;   ULONG CreateOptions,
;   ULONG EaBuffer,
;   ULONG EaLength);
;
; Windows 10
;   1507  10240  85
;   1511  10586  85
;   1607  14393  85
;   1703  15063  85
;   1709  16299  85
;   1803  17134  85
;   1809  17763  85
;   1903  18362  85
;   1909  18363  85
;   2004  19041  85
;   20H2  19042  85
;   21H1  19043  85
;   21H2  19044  85
; Windows 11
;   21H2  22000
;
;***************************************
_NtCreateFile@44:
    mov    ecx, SyscallId
    mov    eax, dword [fs:0x30]
    mov    edx, eax
    mov    eax, [edx+OSMAJORVERSION]
.win10:
    cmp    eax, 10
    jne    .win8
    movzx  eax, word [edx+OSBUILDNUMBER]
    cmp    eax, 19044
    cmovle ax, word [ecx+84*2]
    jmp    .fin
.win8:
    cmp    eax, 8
    jne    .win7
.win7:
    cmp    eax, 7
    ;jne    notsupported
.fin:
    call   dword [fs:0xc0]
    add    esp, 48
    jmp    [esp-48]


;***************************************
; NTSTATUS STDCALL NtWriteFile(
;   [in] HANDLE FileHandle,
;   [in opt] void *EventHandle,
;   [in opt] PIO_APC_ROUTINE ApcRoutine,
;   [in opt] void *ApcContext,
;   [in] IO_STATUS_BLOCK *IoStatusBlock,
;   [in] void *Buffer,
;   [in] ULONG Length,
;   [in] LARGE_INTEGER *ByteOffset,
;   [in opt] ULONG *Key);
;
; Windows 10
;   1507  10240  8
;   1511  10586  8
;   1607  14393  8
;   1703  15063  8
;   1709  16299  8
;   1803  17134  8
;   1809  17763  8
;   1903  18362  8
;   1909  18363  8
;   2004  19041  8
;   20H2  19042  8
;   21H1  19043  8
;   21H2  19044  8
; Windows 11
;   21H2  22000
;
;***************************************
_NtWriteFile@36:
    mov    ecx, SyscallId
    mov    edx, dword [fs:0x30]
    ;mov    edx, eax
    ;mov    eax, [edx+OSMAJORVERSION]
.win10:
    ;cmp    eax, 10
    ;jne    .win8
    movzx  eax, word [edx+OSBUILDNUMBER]
    cmp    eax, 19044
    cmovle ax, word [ecx+7*2]
    jmp    .fin
.win8:
    cmp    eax, 8
    jne    .win7
.win7:
    cmp    eax, 7
    ;jne    notsupported
.fin:
    call   dword [fs:0xc0]
    add    esp, 40
    jmp    [esp-40]


;****************************************
; NTSTATUS STDCALL NtReadFile(
;    [in] HANDLE FileHandle,
;    [inopt] HANDLE Event,
;    [inopt] PIO_APC_ROUTINE ApcRoutine,
;    [inopt] PVOID ApcContext,
;    [out]   PIO_STATUS_BLOCK IoStatusBlock,
;    [out]   PVOID Buffer,
;    [in]    ULONG Length,
;    [inopt] PLARGE_INTEGER ByteOffset,
;    [inopt] PULONG Key);
;
;
; Windows 10
;   1507  10240  6
;   1511  10586  6
;   1607  14393  6
;   1703  15063  6
;   1709  16299  6
;   1803  17134  6
;   1809  17763  6
;   1903  18362  6
;   1909  18363  6
;   2004  19041  6
;   20H2  19042  6
;   21H1  19043  6
;   21H2  19044  6
; Windows 11
;   21H2  22000
;
;****************************************
_NtReadFile@36:
    mov   ecx, SyscallId
    mov   eax, dword [fs:0x30]
    mov   edx, eax
    mov   eax, [edx+OSMAJORVERSION]
.win10:
    cmp   eax, 10
    jne   .win8
    movzx eax, word [edx+OSBUILDNUMBER]
    cmp   eax, 19044
    cmovle ax, word [ecx+5*2]
    jmp   .fin
.win8:
    cmp   eax, 8
    jne   .win7
.win7:
    cmp   eax, 7
    ;jne   notsupported
.fin:
    call  dword [fs:0xc0]
    add   esp, 40
    jmp   [esp-40]




;****************************************
; NTSTATUS STDCALL NtDeleteFile(
;   OBJECT_ATTRIBUTES * ObjectAttributes);
;
; Windows 10
;   1507  10240  196
;   1511  10586  197
;   1607  14393  199
;   1703  15063  202
;   1709  16299  203
;   1803  17134  204
;   1809  17763  205
;   1903  18362  206
;   1909  18363  206
;   2004  19041  210
;   20H2  19042  210
;   21H1  19043  210
;   21H2  19044  210
; Windows 11
;   21H2  22000
;
;****************************************
_NtDeleteFile@4:
    mov    ecx, SyscallId 
    mov    eax, dword [fs:0x30]
    mov    edx, eax
    mov    eax, [edx+OSMAJORVERSION]
.win10:
    cmp    eax, 10
    jne    .win8
    movzx  eax, word [edx+OSBUILDNUMBER]
    cmp    eax, 19044
    cmovle ax, word [ecx+209*2]
    jmp    .fin
.win8:
    cmp    eax, 8
    jne    .win7
.win7:
    cmp    eax, 7
    ;jne   unsupported
.fin:
    call   dword [fs:0xc0]
    ret    4




;********************************************
; NTSTATUS STDCALL NtAllocateVirtualMemory(
;   [in]    HANDLE ProcessHandle,
;   [inout] void **BaseAddress,
;   [in]    long ZeroBits,
;   [inout] long *RegionSize,
;   [in]    unsigned long AllocationType,
;   [in]    unsigned long Protect);
;   
; Windows 10
;   1507  10240  24
;   1511  10586  24
;   1607  14393  24
;   1703  15063  24
;   1709  16299  24
;   1803  17134  24
;   1809  17763  24
;   1903  18362  24
;   1909  18363  24
;   2004  19041  24
;   20H2  19042  24
;   21H1  19043  24
;   21H2  19044  24
; Windows 11
;   21H2  22000
;
;********************************************
_NtAllocateVirtualMemory@24:
    mov    ecx, SyscallId
    mov    eax, dword [fs:0x30]
    mov    edx, eax
    mov    eax, [edx+OSMAJORVERSION]
.win10:
    cmp    eax, 10
    jne    .win8
    movzx  eax, word [edx+OSBUILDNUMBER]
    cmp    eax, 19044
    cmovle ax, word [ecx+23*2]
    jmp    .fin
.win8:
    cmp    eax, 8
    jne    .win7
.win7:
    cmp    eax, 7
    ;jne   unsupported
.fin:
    call   dword [fs:0xc0]
    ret    24


;********************************************
; NTSTATUS STDCALL NtAllocateVirtualMemoryEx(
;   HANDLE ProcessHandle,
;   void **BaseAddress,
;   long *RegionSize,
;   unsigned long AllocationType,
;   unsigned long PageProtection,
;   PMEM_EXTENDED_PARAMETER,
;   unsigned long ExtendedParameterCount);
;   
; Windows 10
;   1507  10240  115
;   1511  10586  115
;   1607  14393  115
;   1703  15063  116
;   1709  16299  116
;   1803  17134  117
;   1809  17763  117
;   1903  18362  117
;   1909  18363  117
;   2004  19041  119
;   20H2  19042  119
;   21H1  19043  119
;   21H2  19044  119
; Windows 11
;   21H2  22000
;
;********************************************
_NtAllocateVirtualMemoryEx@28:
    mov    ecx, SyscallId
    mov    eax, dword [fs:0x30]
    mov    edx, eax
    mov    eax, [edx+OSMAJORVERSION]
.win10:
    cmp    eax, 10
    jne    .win8
    movzx  eax, word [edx+OSBUILDNUMBER]
    cmp    eax, 19044
    cmovle ax, word [ecx+118*2]
    jmp    .fin
.win8:
    cmp    eax, 8
    jne    .win7
.win7:
    cmp    eax, 7
    ;jne   unsupported
.fin:
    call   dword [fs:0xc0]
    ret    28


;*********************************************
; NTSTATUS STDCALL NtFreeVirtualMemory(
;   HANDLE ProcessHandle,
;   void **BaseAddress,
;   long *RegionSize,
;   unsigned long FreeType);
;
; Windows 10
;   1507  10240  30
;   1511  10586  30
;   1607  14393  30
;   1703  15063  30
;   1709  16299  30
;   1803  17134  30
;   1809  17763  30
;   1903  18362  30
;   1909  18363  30
;   2004  19041  30
;   20H2  19042  30
;   21H1  19043  30
;   21H2  19044  30
; Windows 11
;   21H2  22000
;
;*********************************************
_NtFreeVirtualMemory@16:
    mov    ecx, SyscallId
    mov    eax, dword [fs:0x30]
    mov    edx, eax
    mov    eax, [edx+OSMAJORVERSION]
.win10:
    cmp    eax, 10
    jne    .win8
    movzx  eax, word [edx+OSBUILDNUMBER]
    cmp    eax, 19044
    cmovle ax, word [ecx+29*2]
    jmp    .fin
.win8:
    cmp    eax, 8
    jne    .win7
.win7:
    cmp    eax, 7
    ;jne    unsupported
.fin:
    call   dword [fs:0xc0]
    ret    16



;*********************************************
; NTSTATUS STDCALL NtCreateSection(
;   [in]    PHANDLE SectionHandle,
;   [in]    ACCESS_MASK DesiredAccess,
;   [inopt] POBJECT_ATTRIBUTES ObjectAttributes,
;   [inopt] PLARGE_INTEGER MaximumSize,
;   [in]    ULONG SectionPageProtection,
;   [in]    ULONG AllocationAttributes,
;   [inopt] HANDLE FileHandle);
;
; Windows 10
;   1507  10240  74
;   1511  10586  74
;   1607  14393  74
;   1703  15063  74
;   1709  16299  74
;   1803  17134  74
;   1809  17763  74
;   1903  18362  74
;   1909  18363  74
;   2004  19041  74 
;   20H2  19042  74
;   21H1  19043  74
;   21H2  19044  74
; Windows 11
;   21H2  22000
;
;*********************************************
_NtCreateSection@28:
    mov    ecx, SyscallId
    mov    eax, dword [fs:0x30]
    mov    edx, eax
    mov    eax, [edx+OSMAJORVERSION]
.win10:
    cmp    eax, 10
    jne    .win8
    movzx  eax, word [edx+OSBUILDNUMBER]
    cmp    eax, 19044
    cmovle ax, word [ecx+73*2]
    jmp    .fin
.win8:
    cmp    eax, 8
    jne    .win7
    ret    28
.win7:
    cmp    eax, 7
    ;jne   unsupported
    ret    28
.fin:
    call   dword [fs:0xc0]
    ret    28




;*********************************************
; NTSATUS STDCALL NtMapViewOfSection(
;   [in]     HANDLE SectionHandle,
;   [in]     HANDLE ProcessHandle,
;   [in out] PVOID *BaseAddress,
;   [in]     ULONG ZeroBits,
;   [in]     ULONG CommitSize,
;   [in out] PLARGE_INTEGER SectionOffset,
;   [in]     PULONG ViewSize,
;   [in]     SECTION_INHERIT InheritDisposition,
;   [in]     ULONG AllocationType,
;   [in]     ULONG Protect);
;
; Windows 10
;   1507  10240  40
;   1511  10586  40
;   1607  14393  40
;   1703  15063  40
;   1709  16299  40
;   1803  17134  40
;   1809  17763  40
;   1903  18362  40
;   1909  18363  40
;   2004  19041  40
;   20H2  19042  40
;   21H1  19043  40
;   21H2  19044  40
; Windows 11
;   21H2  22000
;
;***********************************************   
_NtMapViewOfSection@20:
    mov    ecx, SyscallId
    mov    eax, dword [fs:0x30]
    mov    edx, eax
    mov    eax, [edx+OSMAJORVERSION]
.win10:
    cmp    eax, 10
    jne    .win8
    movzx  eax, word [edx+OSBUILDNUMBER]
    cmp    eax, 19044
    cmovle ax,  word [ecx+39+2]
    call   dword [fs:0xc0]
    ret    20
.win8:
    cmp    eax, 8
    jne    .win7
    ret    20
.win7:
    cmp    eax, 7
    ;jne   unsupported
    ret    20

;*********************************************
; NTSTATUS STDCALL NtCreateUserProcess(
;   void **ProcessHandle,
;   void **ThreadHandle,
;   long  ProcessDesiredAccess,
;   long  ThreadDesiredAccess,
;   OBJECT_ATTRIBUTES *ProcessObjectAttributes,
;   OBJECT_ATTRIBUTES *ThreadObjectAttributes,
;   unsigned long ProcessFlags,
;   unsigned long ThreadFlags,
;   RTL_USER_PROCESS_PARAMETERS *ProcessParameters,
;   PS_CREATE_INFO *CreateInfo,
;   PS_ATTRIBUTE_LIST *AttributeList);
;
; Windows 10
;   1507  10240  186
;   1511  10586  187
;   1607  14393  189
;   1703  15063  192
;   1709  16299  193
;   1803  17134  194
;   1809  17763  195
;   1903  18362  196
;   1909  18363  196
;   2004  19041  200
;   20H2  19042  200
;   21H1  19043  200
;   21H2  19044  200
; Windows 11
;   21H2  22000
;
;*********************************************
_NtCreateUserProcess@44:
    mov    ecx, SyscallId
    mov    eax, dword [fs:0x30]
    mov    edx, eax
    mov    eax, [edx+OSMAJORVERSION]
.win10:
    cmp    eax, 10
    jne    .win8
    movzx  eax, word [edx+OSBUILDNUMBER]
    cmp    eax, 10240
    cmovle ax, word [ecx+185*2]
    cmp    eax, 10586
    cmovle ax, word [ecx+186*2]
    cmp    eax, 14393
    cmovle ax, word [ecx+188*2]
    cmp    eax, 15063
    cmovle ax, word [ecx+191*2]
    cmp    eax, 16299
    cmovle ax, word [ecx+192*2]
    cmp    eax, 17134
    cmovle ax, word [ecx+193*2]
    cmp    eax, 17763
    cmovle ax, word [ecx+194*2]
    cmp    eax, 18363
    cmovle ax, word [ecx+195*2]
    cmp    eax, 19044
    cmovle ax, word [ecx+199*2]
    call   dword [fs:0xc0]
    ret    44
.win8:
    cmp    eax, 8
    jne    .win7
    ret    44
.win7:
    cmp    eax, 7
    ;jne   unsupoorted
    ret    44


;*********************************************
; NTSTATUS STDCALL NtCreateKey(
;   [out]    PHANDLE            KeyHandle,
;   [in]     ACCESS_MASK        DesiredAccess
;   [in]     POBJECT_ATTRIBUTES ObjectAttributes,
;   [in]     ULONG              TitleIndex,
;   [inopt]  PUNICODE_STRING    Class,
;   [in]     ULONG              CreateOptions
;   [outopt] PULONG             Disposition);
;
; Windows 10
;   1507  10240  29 
;   1511  10586  29
;   1607  14393  29
;   1703  15063  29
;   1709  16299  29
;   1803  17134  29
;   1809  17763  29
;   1903  18362  29
;   1909  18363  29 
;   2004  19041  29
;   20H2  19042  29
;   21H1  19043  29
;   21H2  19044  29
; Windows 11
;   21H2  22000
;
;*********************************************
_NtCreateKey@28:
    mov    ecx, SyscallId
    mov    eax, dword [fs:0x30]
    mov    edx, eax
    mov    eax, [edx+OSMAJORVERSION]
.win10:
    cmp    eax, 10
    jne    .win8
    movzx  eax, word [edx+OSBUILDNUMBER]
    cmp    eax, 19044
    cmovle ax, word [ecx+28*2]
    call   dword [fs:0xc0]
    ret    28
.win8:
    cmp    eax, 8
    jne    .win7
    ret    28
.win7:
    cmp    eax, 7
    ;jne   unsupported
    ret    28


;*********************************************
; NTSTATUS STDCALL NtOpenKey(
;   [out]    PHANDLE            KeyHandle,
;   [in]     ACCESS_MASK        DesiredAccess
;   [in]     POBJECT_ATTRIBUTES ObjectAttributes);
;
; Windows 10
;   1507  10240  18
;   1511  10586  18
;   1607  14393  18
;   1703  15063  18
;   1709  16299  18
;   1803  17134  18
;   1809  17763  18
;   1903  18362  18
;   1909  18363  18
;   2004  19041  18
;   20H2  19042  18
;   21H1  19043  18
;   21H2  19044  18
; Windows 11
;   21H2  22000
;
;*********************************************
_NtOpenKey@12:
    mov    ecx, SyscallId
    mov    eax, dword [fs:0x30]
    mov    edx, eax
    mov    eax, [edx+OSMAJORVERSION]
.win10:
    cmp    eax, 10
    jne    .win8
    movzx  eax, word [edx+OSBUILDNUMBER]
    cmp    eax, 19044
    cmovle ax, word [ecx+17*2]
    call   dword [fs:0xc0]
    ret    12
.win8:
    cmp    eax, 8
    jne    .win7
    ret    12
.win7:
    cmp    eax, 7
    ;jne   unsupported
    ret    12


;*********************************************
; NTSTATUS STDCALL NtSetValueKey(
;   [out]    HANDLE           KeyHandle,
;   [in]     PUNICODE_STRING  ValueName, 
;   [inopt]  ULONG            TitleIndex,
;   [in]     ULONG            Type,
;   [inopt]  PVOID            Data,
;   [in]     ULONG            DataSize);
;   
;
; Windows 10
;   1507  10240  96
;   1511  10586  96
;   1607  14393  96
;   1703  15063  96
;   1709  16299  96
;   1803  17134  96
;   1809  17763  96
;   1903  18362  96
;   1909  18363  96
;   2004  19041  96
;   20H2  19042  96
;   21H1  19043  96
;   21H2  19044  96
; Windows 11
;   21H2  22000
;
;*********************************************
_NtSetValueKey@24:
    mov    ecx, SyscallId
    mov    eax, dword [fs:0x30]
    mov    edx, eax
    mov    eax, [edx+OSMAJORVERSION]
.win10:
    cmp    eax, 10
    jne    .win8
    movzx  eax, word [edx+OSBUILDNUMBER]
    cmp    eax, 19044
    cmovle ax, word [ecx+95*2]
    call   dword [fs:0xc0]
    ret    24
.win8:
    cmp    eax, 8
    jne    .win7
    ret    24
.win7:
    cmp    eax, 7
    ;jne   unsupported
    ret    24


;*********************************************
; NTSTATUS STDCALL NtQueryValueKey(
;   [in]     HANDLE           KeyHandle,
;   [in]     PUNICODE_STRING  ValueName, 
;   [in]     LONG             KeyValueInformationClass,
;   [outopt] PVOID            KeyValueInformation,
;   [in]     ULONG            Length,
;   [out]    PULONG           ResultLength);
;   
;
; Windows 10
;   1507  10240  23
;   1511  10586  23
;   1607  14393  23
;   1703  15063  23
;   1709  16299  23
;   1803  17134  23
;   1809  17763  23
;   1903  18362  23
;   1909  18363  23
;   2004  19041  23
;   20H2  19042  23
;   21H1  19043  23
;   21H2  19044  23
; Windows 11
;   21H2  22000
;
;*********************************************
_NtQueryValueKey@24:
    mov    ecx, SyscallId
    mov    eax, dword [fs:0x30]       ;NtCurrentPeb
    mov    edx, eax
    mov    eax, [edx+OSMAJORVERSION]
.win10:
    cmp    eax, 10
    jne    .win8
    movzx  eax, word [edx+OSBUILDNUMBER]
    cmp    eax, 19044
    cmovle ax, word [ecx+22*2]
    call   dword [fs:0xc0]
    ret    24
.win8:
    cmp    eax, 8
    jne    .win7
    ret    24
.win7:
    cmp    eax, 7
    ;jne   unsuported
    ret    24



;*******************************************************
; NTSTATUS STDCALL NtCreatedNamedPipeFile(
;   [out]  PHANDLE NamedPipeFileHandle,
;   [in]   DESIRED_ACCESS DesiredAccess,
;   [in]   POBJECT_ATTRIBUTES ObjectAttributes,
;   [out]  PIO_STATUS_BLOCK IoStatusBlock,
;   [in]   ULONG ShareAccess,
;   [in]   ULONG CreateDisposition,
;   [in]   ULONG CreateOptions,
;   [in]   BOOLEAN WriteModeMessage,
;   [in]   BOOLEAN ReadModeMessage,
;   [in]   BOOLEAN NonBlocking,
;   [in]   ULONG MaxInstances,
;   [in]   ULONG InBufferSize,
;   [in]   ULONG OutBufferSize,
;   [in]   PLARGE_INTEGER DefaultTimeout);
;
; Windows 10
;   1507  10240  168
;   1511  10586  168
;   1607  14393  170
;   1703  15063  173
;   1709  16299  174
;   1803  17134  175
;   1809  17763  175
;   1903  18362  176
;   1909  18363  176
;   2004  19041  180
;   20H2  19042  180
;   21H1  19043  180
;   21H2  19044  180
; Windows 11
;   21H2  22000
;
;********************************************************
_NtCreateNamedPipeFile@44:
    mov    ecx, SyscallId
    mov    eax, dword [fs:0x30]
    mov    edx, eax
    mov    eax, [edx+OSMAJORVERSION]
.win10:
    cmp    eax, 10
    jne    .win8
    movzx  eax, word [edx+OSBUILDNUMBER]
    cmp    eax, 19044
    cmovle ax, word [ecx+179*2]
    call   dword [fs:0xc0]
    ret    44
.win8:
    cmp    eax, 8
    jne    .win7
    ret    44
.win7:
    cmp    eax, 7
    ;jne   unsupported
    ret    44

;*******************************************************
; NTSTATUS STDCALL NtCreatedNamedPipeFile(
;   [in]    BOOLEAN Alertable,
;   [inopt] PLARGE_INTEGER DelayInterval);
;
; Windows 10
;   1507  10240  168
;   1511  10586  168
;   1607  14393  170
;   1703  15063  173
;   1709  16299  174
;   1803  17134  175
;   1809  17763  175
;   1903  18362  176
;   1909  18363  176
;   2004  19041  180
;   20H2  19042  180
;   21H1  19043  180
;   21H2  19044  180
; Windows 11
;   21H2  22000
;
;********************************************************
_NtDelayExecution@8:
