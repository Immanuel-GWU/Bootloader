# BootLoader
This is a simple bootloader written using NASM x86 assembler to load a simple kernel written in C from the disk into memory. 
This kernel is not a full fledged kernel rather it just when loaded will print the "Hello, World!" message in the screen. 
1. GCC compiler to compile the kernel written in C
	
2. x86 NASM assembler to assemble as .asm instructions
	
3. QEMU to run the kernel and where we will see the message in screen
	
4. Linker ID to link all separately written files whether .asm or .c
	
5. GNU make to convert all the linked files into .exe file so that it can be run in QEMU machine virtualizer. 
