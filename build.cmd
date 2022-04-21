@echo off

cl /O2 /c /Fahash-tool.asm hash-tool.c

nasm -fwin32 hash.asm
nasm -fwin32 os.asm
nasm -fwin32 mem.asm

link hash-tool.obj hash.obj os.obj mem.obj

del hash-tool.obj hash.obj os.obj mem.obj
