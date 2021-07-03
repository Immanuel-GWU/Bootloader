# Make file which contains all linking part and the instruction to create image and run it in QEMU

# $@ = target file
# $< = first dependency
# $^ = all dependencies


# First rule is the one executed when no parameters are fed into the make file

all: run

kernel.bin: kernel-Genesis.o kernel.o
	ld -m elf_i386 -o $@ -Ttext 0x1000 $^ --oformat binary

kernel-Genesis.o: Kernel-Genesis.asm
	nasm $< -f elf -o $@

kernel.o: kernel.c
	gcc -m32 -ffreestanding -c $< -o $@

mbr.bin: MasterBootRecord.asm
	nasm $< -f bin -o $@

os-image.bin: mbr.bin kernel.bin
	cat $^ > $@

run: os-image.bin
	qemu-system-i386 -fda $<

clean: 	
	$(RM) *.bin *.o *.dis