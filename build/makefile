NASM = nasm
GCC = gcc
LD = ld
GRUB_MKRESCUE = grub-mkrescue

NASMFLAGS = -f elf64
GCCFLAGS = -m64
LDFLAGS = -static -m elf_x86_64 -T $(SRC_DIR)/linker.ld

SRC_DIR = ../src
BOOT_DIR = $(SRC_DIR)/boot
OUTPUT_DIR = output
INTERRUPTS_DIR = $(SRC_DIR)/interrupts

OBJECTS = 	$(OUTPUT_DIR)/multiboot_header.o \
			$(OUTPUT_DIR)/paging.o \
			$(OUTPUT_DIR)/gdt.o \
			$(OUTPUT_DIR)/idt.o \
			$(OUTPUT_DIR)/idt_asm.o \
			$(OUTPUT_DIR)/boot.o \
			$(OUTPUT_DIR)/kernel.o

all: $(OUTPUT_DIR)/brik_kernel.iso

.PHONY: all clean debug

$(OUTPUT_DIR)/%.o: $(SRC_DIR)/%.asm
	$(NASM) $(NASMFLAGS) $< -o $@

$(OUTPUT_DIR)/%.o: $(BOOT_DIR)/%.asm
	$(NASM) $(NASMFLAGS) $< -o $@

$(OUTPUT_DIR)/%.o: $(SRC_DIR)/%.c
	$(GCC) $(GCCFLAGS) -c $< -o $@

$(OUTPUT_DIR)/%.o: $(INTERRUPTS_DIR)/%.c
	$(GCC) $(GCCFLAGS) -c $< -o $@

$(OUTPUT_DIR)/%_asm.o: $(INTERRUPTS_DIR)/%.asm
	$(NASM) $(NASMFLAGS) $< -o $@

$(OUTPUT_DIR)/kernel: $(OBJECTS)
	$(LD) $(LDFLAGS) -o $@ $(OBJECTS)

$(OUTPUT_DIR)/brik_kernel.iso: $(OUTPUT_DIR)/kernel
	cp $(OUTPUT_DIR)/kernel brik_iso/boot/kernel
	$(GRUB_MKRESCUE) -o $@ brik_iso/

clean:
	rm -f $(OUTPUT_DIR)/$(OBJECTS) $(OUTPUT_DIR)/kernel $(OUTPUT_DIR)/brik_kernel.iso

debug:
	qemu-system-x86_64 -cdrom $(OUTPUT_DIR)/brik_kernel.iso