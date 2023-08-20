NASM = nasm
GCC = gcc
LD = ld
GRUB_MKRESCUE = grub-mkrescue

NASMFLAGS = -f elf32
GCCFLAGS = -m32
LDFLAGS = -m elf_i386 -T $(SRC_DIR)/linker.ld

SRC_DIR = ../src

OBJECTS = boot.o kernel.o keyboard.o source.o

all: brik_kernel.iso

%.o: $(SRC_DIR)/%.asm
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
