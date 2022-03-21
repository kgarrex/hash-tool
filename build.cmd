@echo off

cl /O2 /c /Fahash-tool.asm hash-tool.c

nasm -fwin32 hash.asm

link hash-tool.obj hash.obj

del hash-tool.obj hash.obj

