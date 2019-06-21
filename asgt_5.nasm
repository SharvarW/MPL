;PROGRAM :  Write 64 bit ALP to switch from real  to protected mode and display the values of GDTR, LDTR, IDTR, TR and MSW
;			 Registers.
;NAME : SHARVARI S. WAGH
;SE(A)-73
;---------------------------------------------
global _start
 _start:

section .text

	%macro disp 2
	mov rax, 1
	mov rdi,1
	mov rsi,%1
	mov rdx,%2
	syscall
	%endmacro

	%macro accept 2
	mov rax, 0
	mov rdi, 0
	mov rsi,%1
	mov rdx,%2
	syscall
	%endmacro

;checking  PE

	smsw eax						;store contents of  MSW in eax
	mov [cr0_data], eax			;we have to move the contents to eax because the BT instruction ....
									;operates on eax only
	bt eax, 00h						;BT is used to check the 0th bit i.e PE (protection enable) bit  to check if we are in 										;protected or real mode
									;BT  checks  PE  and   affects the CF, if CF=1->protected mode ,ifCF=0->  real mode
	jc l1
	jmp exit						;We are already in Protected mode  but atall it shows that it is real mode then we 									;need  to exit program since GDT,LDT....... are only accessed in Protected mode	


	
l1:	disp msg, len	;display  MSW
	disp msg1, len1
	mov ax, [cr0_data+2]		;lower bits are stored at lower address hence to display from higher bits we need 
								;to increment the pointer according to no. of digits
	call display
	mov ax, [cr0_data]
	call display

	
	disp msg2,len2	;display  GDTR
	sgdt [gdt1]
	mov ax, [gdt1+4]
	call display
	mov ax, [gdt1+2]
	call display
	mov ax, [gdt1]
	call display


	disp msg3,len3	;display  IDTR
	sidt [idt1]
	mov ax, [idt1+4]
	call display
	mov ax, [idt1+2]
	call display
	mov ax, [idt1]
	call display

	
	disp msg4,len4	;display  LDTR
	sldt [ldt1]
	mov ax, [ldt1]
	call display
	

	disp msg5,len5	;display  TR
	str [task1]
	mov ax, [task1]
	call display
	
exit:
	mov rax, 60
	mov rdi, 0
	syscall

display:
	mov rsi,disparr+3	
	mov rcx, 4
l4:	mov rdx, 0
	mov rbx, 10h
	div rbx

	cmp dl, 09h
	jbe l5
	add dl, 07h
l5:	add dl, 30h
	mov [rsi], dl
	
	dec rsi
	dec rcx
	jnz l4

	mov rax,1
	mov rdi, 1
	mov rsi,disparr
	mov rdx,4			;for rdx,4  it  displays 4 digits
	syscall
	ret
	

section .data
	
	msg db 10,"We are in PROTECTED Mode",10
	len: equ $-msg
	
	msg1 db 10,"Contents of MSW  :"
	len1: equ $-msg1
	
	msg2 db 10, "Contents of GDTR :"
	len2: equ $-msg2
	
	msg3 db 10, "Contents of IDTR :"
	len3: equ $-msg3

	msg4 db 10, "Contents of LDTR :"
	len4: equ $-msg4
	
	msg5 db 10, "Contents of   TR :"
	len5: equ $-msg5
	
section .bss
	cr0_data resb 35
	gdt1 resb 30			;cannot use gdt,ldt (system defined)
	idt1 resb 30
	ldt1 resb 30
	task1 resb 30			;tr1 cannot be used as it is a test register
	disparr resb 50
	
;----------------------------------------------------
;OUTPUT : 
;
;We are in PROTECTED Mode
;
;Contents of MSW  :8005003B
;Contents of GDTR :7F20C000007F
;Contents of IDTR :FF5740000FFF
;Contents of LDTR :0000
;Contents of   TR :0040	
	
