; This is the main file for Master Boot Record -  512 byte boot sector

[bits 16] ; directive to denote what bit instruction the following are
[org 0x7c00] ; memory address where the BIOS places the boot loader

; Memory address to load the kernel to
KERNEL_OFFSET equ 0x1000

; BIOS automatically sets the boot drive in "dl", need to store it somewhere so we can use "dl" for other purpose
mov [BOOT_DRIVE], dl

; Stack setup, call & ret statements can use it to track the memory addresses during asm instruction execution
mov bp, 0x9000  ; Stack range is from 0x1000 -----> 0x9000
mov sp, bp

call kernel
call 16bit_to_32bit ; Separate asm file containing code needed inorder to convert to 32 bit

jmp $

; Including the helper modules which will be used by the bootloader
%include "Disk.asm"
%include "GlobalDescriptorTable.asm"
%include "16bitRM-to-32bitPM.asm"

[bits 16]

kernel:  ; Procedure instructs the BIOS to load the kernel from disk into memory at KERNEL_OFFSET address
	mov bx, KERNEL_OFFSET
	mov dh, 2 ; Number of sectors to read from the drive
	mov dl, [BOOT_DRIVE] ; address of the disk from where kernel is loaded
	call disk_load
	ret

[bits 32]
32bit:
	call KERNEL_OFFSET  ; give control to the kernel
	jmp $   ; loop in case kernel returns

; boot drive variable
BOOT_DRIVE db 0

; padding -- filling up the remaining space with 0 bytes
times 510 - ($-$$) db 0

;magic number
dw 0xaa55



