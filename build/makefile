NASM = nasm
GCC = gcc
LD = ld
GRUB_MKRESCUE = grub-mkrescue

NASMFLAGS = -f elf64
GCCFLAGS = -m64
LDFLAGS = -static -m elf_x86_64 -T $(SRC_DIR)/linker.ld

SRC_DIR = ../src
BOOT_DIR = $(SRC_DIR)/boot

OBJECTS = multiboot_header.o boot.o kernel.o

all: brik_kernel.iso

.PHONY: all clean debug

%.o: $(SRC_DIR)/%.asm
	$(NASM) $(NASMFLAGS) $< -o $@

%.o: $(BOOT_DIR)/%.asm
	$(NASM) $(NASMFLAGS) $< -o $@

%.o: $(SRC_DIR)/%.c
	$(GCC) $(GCCFLAGS) -c $< -o $@

kernel: $(OBJECTS)
	$(LD) $(LDFLAGS) -o $@ $(OBJECTS)

brik_kernel.iso: kernel
	cp kernel brik_iso/boot/kernel
	$(GRUB_MKRESCUE) -o $@ brik_iso/

clean:
	rm -f $(OBJECTS) kernel brik_kernel.iso

debug:
	qemu-system-x86_64 -cdrom brik_kernel.iso