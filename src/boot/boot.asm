extern main
global start

section .data


section .text
bits 32
start:

        ; point 1st level 4 page table's entry to 1st level 3 page table's entry
        mov eax, p3_table
        or eax, 0b11    ; setting page metadata (present and writable bits)
        mov dword [p4_table + 0], eax

        ; point 1st level 3 page table's entry to 1st level 2 page table's entry
        mov eax, p2_table
        or eax, 0b11    ; setting page metadata (present and writable bits)
        mov dword [p3_table + 0], eax

        mov ecx, 0 ; init counter variable
    .map_p2_table:   ; loop to reference pages to the level 2 page table
        mov eax, 0x200000   ; 2MiB pages
        mul ecx             ; eax = eax * ecx
        or eax, 0b10000011  ; setting page metadata (huge page size, present and writable bits)
        mov [p2_table + ecx * 8], eax   ; assign eax value to (p2_table+ecx*8) location in p2 table
                                        ; memory address is always a multiple of 8 (0, 8, 16, 24, 32, etc)
                                        ; because each entry is eight bytes in size

        inc ecx
        cmp ecx, 512
        jne .map_p2_table

        ; move page table address to cr3
        mov eax, p4_table
        mov cr3, eax

        ; enable Physical Address Extension
        mov eax, cr4
        or eax, 1 << 5
        mov cr4, eax

        ; set the long mode bit
        mov ecx, 0xC0000080
        rdmsr
        or eax, 1 << 8
        wrmsr

        ; enable paging
        mov eax, cr0
        or eax, 1 << 31
        or eax, 1 << 16
        mov cr0, eax

        ; load the gdt
        lgdt [gdt64.pointer]

        ; update selectors
        mov ax, gdt64.data
        mov ss, ax
        mov ds, ax
        mov es, ax

        ; jump to long mode
        jmp gdt64.code:long_mode_start

        hlt

section .bss

; identity mapping
align 4096

p4_table:
    resb 4096
p3_table:
    resb 4096
p2_table:
    resb 4096

; GDT
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

section .text
bits 64
long_mode_start:
    mov rax, 0x2f592f412f4b2f4f
    mov qword [0xb8000], rax
    hlt