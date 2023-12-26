# BootLoader
This is a simple bootloader written using NASM x86 assembler to load a kernel written in C from disk to memory. 
This kernel is not a full-fledged one instead it just prints the "Hello, World!" message on the screen when loaded. 
1. GCC compiler to compile the kernel written in C
	
2. x86 NASM(Netwide Assembler) to assemble .asm instructions
	
3. QEMU to run the kernel and where we'll see the message on screen
	
4. Linker ID to link all separately written files whether .asm or .c
	
5. GNU make to convert all the linked files into .exe file so that it can be run on QEMU machine virtualizer. 
