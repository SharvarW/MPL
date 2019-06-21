;PROGRAM : Write 64 bit ALP to find the factorial of a given integer number.
;NAME : SHARVARI S. WAGH
;SE(A)-73
;---------------------------------------------
global _start
_start:

;----------------------------------------------

section .text

%macro disp 2
mov rax, 1
mov rdi, 2
mov rsi, %1
mov rdx, %2
syscall
%endmacro

%macro accept 2
mov rax, 0
mov rdi, 0
mov rsi, %1
mov rdx, %2
syscall 
%endmacro

disp msg1, len1
accept num1, 3
call convert
mov [no1], al
cmp al, 01h
ja l1
disp msg2, len2
jmp exit

l1: 	mov rcx, rax
		dec rcx

l2:		push rax
		dec rax

		cmp rax, 1
		ja l2
 
l3:		pop rbx
		mul rbx
		dec rcx
		jnz l3
		call display

exit: 
		mov rax, 60		;system call for exit
		mov rdi, 0
		syscall

convert:

		mov rsi, num1
		mov al, [rsi]
		cmp al, 39h
		jbe l4
		sub al, 7h
	
	l4: sub al, 30h
		rol al, 04h
		mov bl, al
		inc rsi
		mov al, [rsi]
		cmp al, 39h
		jbe l5
		sub al, 7h
	
	l5: sub al, 30h
		add al, bl
		ret

display:

		mov rsi, disp_arr+15
		mov rcx, 16

	l6:	mov rdx, 0
		mov rbx, 10h
		div rbx
		cmp dl, 09h
		jbe l7

		add dl, 07h
	l7:	add dl, 30h

		mov [rsi], dl                      
		dec rsi
		dec rcx
		jnz l6	
		disp msg3,len3	
		disp disp_arr,16
		ret	

;----------------------------------------------
section .data

msg1 db "Enter a number (in 2 digits) :",10
len1  equ $-msg1

msg2 db 10,"The Factorial is 1",10
len2 equ $-msg2

msg3 db 10,"The Result is : "  
len3: equ $-msg3

;----------------------------------------------
section .bss

num1 resb 10
no1 resb 10
disp_arr resb 40

;----------------------------------------------------------------------
;OUTPUT : 
;
;Enter a number (in 2 digits) :
;04
;
;The Result is : 0000000000000018


