; kernel entry
extern main

;paging
extern init_page_tables
extern enable_pae_and_long_mode
extern enable_paging

;gdt
extern gdt64.data
extern gdt64.code
extern load_gdt

global start

section .data


section .text
bits 32
start:
        ; paging
        call init_page_tables
        call enable_pae_and_long_mode
        call enable_paging

        ; load the gdt
        call load_gdt


        ; update selectors
        mov ax, gdt64.data
        mov ss, ax
        mov ds, ax
        mov es, ax

        ; jump to long mode
        jmp gdt64.code:long_mode_start

        hlt


section .text
bits 64
long_mode_start:
    mov rax, 0x2f592f412f4b2f4f
    mov qword [0xb8000], rax
    hlt