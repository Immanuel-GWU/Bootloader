; Sets the Global Descriptor Table
; To compute size we use gdt_alpha and gdt_omega label

; null segment descriptor
gdt_alpha:
	dq 0x0
	
; code segment descriptor
gdt_csg:
	dw 0xffff   ; segment length, bits 0-15
	dw 0x0      ; segment base, bits 0-15
	db 0x0		; segment base, bits 16-23
	db 10011010b ; flags (8 bits)
	db 11001111b ; flags (4 bits) + segment length, bits 16-19
	db 0x0       ; segment base, bits 24-31
	
; data segment descriptor
gdt_dsg:
	dw 0xffff ;segment length, bits 0-15
	dw 0x0    ; segment base, bits 0-15
	db 0x0    ; segment base, bits 16-23
	db 10011010b ; flags (8 bits)
	db 11001111b ; flags (4 bits) + segment length, bits 16-19
	db 0x0       ; segment base, bits 24-31
	
gdt_omega:

; GDT descriptor
gdt_desc:
	dw gdt_omega - gdt_alpha - 1 ; size(16 bits)
	dd gdt_alpha ;address (32 bits)
	
CODE_SEG equ gdt_csg - gdt_alpha
DATA_SEG equ gdt_dsg - gdt_alpha