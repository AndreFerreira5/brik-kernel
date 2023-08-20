ENTRY(start)
SECTIONS
{
    . = 1M;    /* Set the base memory address for the kernel */

    .text ALIGN(4K) : AT(ADDR(.text) - 1M)
    {
        *(.multiboot)
        *(.text)
    }

    .data ALIGN(4K) :
    {
        *(.data)
    }

    .bss ALIGN(4K) :
    {
        *(.bss)
    }

    /DISCARD/ : { *(.eh_frame) }
}

