;PROGRAM :  Write menu drive 64 bit ALP to convert 4-digit Hex number into its equivalent BCD number
; 			 and 5-digit BCD to Hex
;NAME : SHARVARI S. WAGH
;SE(A)-73
;---------------------------------------------
global  _start
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

	disp menu,lenmenu
	accept choice,2
	
	mov al,byte[choice]
	cmp al,31h
	je hextobcd

	cmp al,32h
	je bcdtohex

	cmp al,33h
	jmp exit

hextobcd:
	disp msg1, len1
	accept num1, 2

	disp msg2, len2
	call convert
	mov [no1], al

	accept num1,3
	call convert
	mov [no2], al
	
	mov rsi, arr
	mov ah, [no1]
	mov al, [no2]
	
l1:	mov dx,0
	mov bx,[rsi]
	div bx
	mov [rem], dx
	
	push rsi
	call display
	pop rsi
	inc rsi
	inc rsi
	
	mov ax,[rem]			;ALWAYS GIVE BRACKET TO THE VARIABLES  DEFINED IN .BSS
	dec byte[cnt]
	jnz l1
	jmp exit

bcdtohex:
	disp msg3, len3
	mov rsi, arr
m1:	push rsi
		accept num3,1
		pop rsi
		mov al, byte[num3]
		sub al,30h
		
		mov bx,[rsi]
		mul bx
		add [result2], ax
		inc rsi
		inc rsi
		dec byte[cnt3]
		;add rsi, 2
		jnz m1

		mov ax,[result2]
		call disp_proc
		mov rax,60
		mov rdi,0
		syscall			;exit
	
	exit : 
		mov rax,60
		mov rdi,0
		syscall

convert:	
		mov rsi,num1
		mov al,[rsi]
		cmp al,39h
		jbe l2
		sub al,07h
l2:		sub al,30h
		rol al,04h
		mov bl,al
		inc rsi
		
		mov al,[rsi]
		cmp al,39h
		jbe l3
		sub al,07h
l3:		sub al,30h
		add al,bl
		ret
	
disp_proc:
		mov rsi,disparr+3
		mov rcx, 4

n2:		mov rdx, 0
		mov rbx, 10h
		div rbx	
		cmp dl, 09h
		jbe n3
		add dl, 07h	

n3:		add dl, 30h
		mov [rsi], dl	
		dec rsi
		dec rcx
		jnz n2
		disp msg,len		
		mov ah, 00h
		mov al, byte[cnt1]
		disp disparr,4	
		ret

display:
		cmp al,09h
		jbe l4
		add al,07h
l4:		add al,30h
		mov [z1],al
		disp z1,1
		ret

section .data
		cnt db 5
		cnt1 db 10
		cnt3 db 5
		cnt4 db 10
		arr dw 2710h, 03E8h, 0064h, 000Ah, 0001h
	
		msg db 10,"	",10
		len: equ $-msg

		msg1 db 10,"Enter the Hexadecimal number :",10
		len1: equ $-msg1
	
		msg2 db 10,"The BCD equivalent is :",10
		len2: equ $-msg2

		msg3 db 10,"Enter the BCD number :",10
		len3: equ $-msg3
	
		msg4 db 10,"The Hexadecimal equivalent is :",10
		len4: equ $-msg4

		menu :db "---------------------------------------------",10
			    db  "                   MENU",10
			    db  "---------------------------------------------",10
			    db  "		1.HEX to BCD",10
			   db  "		2.BCD to HEX",10
			   db  "		3.Exit",10
			   db  "---------------------------------------------",10
			   db  "         Enter your choice : ",10
		lenmenu: equ $-menu

section .bss
		num1 resb 10
		disparr resb 50
		no1 resb 10
		no2 resb 10
		z1 resb 10
		rem resb 10
		num3 resb 10
		result2 resb 10
		choice resb 10
	
;--------------------------------------------------------------------------------
;---------------------------------------------
;                   MENU
;---------------------------------------------
;		1.HEX to BCD
;		2.BCD to HEX
;		3.Exit
;---------------------------------------------
;         Enter your choice : 
;2
;Enter the BCD number :
;10000	
;2710
;
;---------------------------------------------
;                   MENU
;---------------------------------------------
;		1.HEX to BCD
;		2.BCD to HEX
;		3.Exit
;---------------------------------------------
;         Enter your choice : 
;1
;Enter the Hexadecimal number :
;2710
;The BCD equivalent is :
;10000
;
;---------------------------------------------
;                   MENU
;---------------------------------------------
;		1.HEX to BCD
;		2.BCD to HEX
;		3.Exit
;---------------------------------------------
;         Enter your choice : 
;3
;

