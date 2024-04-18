extern idtr ; idtr struct

global load_idt
global enable_interrupts

section .text

load_idt:
    lidt [idtr] ; load IDT pointed to by idtr
    ret

enable_interrupts:
    sti ; set interrupt flag
    ret