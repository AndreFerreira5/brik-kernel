bits 32

extern main
global start

ALIGN 4
section .multiboot
        dd 0x1BADB002   ; Magic number
        dd 0x0          ; Flags
        dd -(0x1BADB002 + 0x0)  ; Checksum (magic + flags)

section .text

start:
        cli
        mov  esp, stack_space
        call main
        hlt

section .bss
resb 16000
stack_space:
