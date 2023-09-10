; ***********************************************
; *  GLOBAL DESCRIPTOR TABLE SETUP AND LOADING  *
; ***********************************************

global load_gdt
global gdt64
global gdt64.data
global gdt64.code

; GDT LOAD
section .text
bits 32

    load_gdt:
        lgdt [gdt64.pointer]
        ret


; GDT SETUP
section .rodata

    ; zero entry
    gdt64:
        dq 0

    ; code segment
    .code: equ $ - gdt64
        dq (1<<44) | (1<<47) | (1<<41) | (1<<43) | (1<<53)

    ; data segment
    .data: equ $ - gdt64
        dq (1<<44) | (1<<47) | (1<<41)

    .pointer:
        dw .pointer - gdt64 - 1 ; gdt's length (2bytes)
        dq gdt64                ; gdt's address (8bytes)