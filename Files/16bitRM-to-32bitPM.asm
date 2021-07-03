; Contains code to switch from 16 bit real mode to 32 bit protected mode

[bits 16]

sw_to_32bit:
	cli        ; Disabling interrupts of assembly code
	lgdt [gdt_desc]	   ; moving GDT descriptor into the GDT register
	mov eax, cr0
	or eax, 0x1       ; enabling protected mode
	mov cr0, eax
	jmp CODE_SEG:initiate_32bit;   far jump to code seg to remove all the 16 bit instructions from CPU pipeline
	
[bits 32]
initiate_32bit:
	mov ax, DATA_SEG
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	
	mov ebp, 0x90000
	mov esp, ebp         ; setup 32bit pointer range which will be taken by the kernel to load
	
	
	call start_32bit	; calling the kernel 32bit entry procedure to hand over the control to the 32bit kernel
	