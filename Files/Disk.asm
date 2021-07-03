; This contains code to read from disk using BIOS
; Since BIOS is required to read the BOOT LOADER code from MBR which is in the disk

disk_load:
	
	pusha  ;pushes all GPR into the first unused memory address of the stack
	push dx ;pushed "dx" register into the first unused offset of the stack
	
	mov ah, 0x02 ; read mode
	mov al, dh ;read dh=2 number of sectors
	mov cl, 0x02 ;start from sector 2 as sector 1 is our boot drive
	
	mov ch, 0x00 ; cylinder 0
	mov dh, 0x00 ; head 0
	
	; dl, drive number is set as input to the disk_load
	; es:bx buffer pointer is set as input as well
	
	int 0x13 ; BIOS interrupt
	jc disk_warn ; check carry bit for any disk error
	
	pop dx ;get back original number of sectors to read
	cmp al, dh ;BIOS sets "al" to the n number of sectors actually read
				; Compare it with "dh" and throw error in our case we loop disk load again if al != dh

	jne sector_warn
	popa ; retrives all GPR
	ret
	
disk_warn:
	jmp disk_load
	
sector_warn:
	jmp disk_load ; In our case we loop disk_load procedure and not print warning message which is appropriate

disk_loop:
	jmp $