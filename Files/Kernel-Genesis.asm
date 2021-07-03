; Contains code to hand over the control to the main function in kernel.c
; We need to mention that main function is an external proc which is not written in .asm files
; Linkers work to handle malloc of main function


[bits 32]
[extern main]
call main
jmp $