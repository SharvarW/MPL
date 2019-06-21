;PROGRAM : Write menu driven 64 bit ALP to perform multiplication using successive addition and add and shift method.
;NAME : SHARVARI S. WAGH
;SE(A)-73
;---------------------------------------------

global _start
 _start:

section .text
	
	%macro dispmsg 2
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

	dispmsg msg, len
	dispmsg msg1, len1	
	accept num1, 3
	call convert
	mov[no1], al
	
	dispmsg msg2, len2
	accept num1, 3
	call convert
	mov[no2], al
	
	dispmsg msg3, len3
	
	mov ax, [no1]	
	mov bx, [no2]			
l3:	shr bx,1				;shift right
	
	jnc l1
	add [res], ax
l1:	shl ax,1					;shift left
	cmp bx, 0
	jz l2
	cmp bx, 0
	jnz l3
l2:	mov ax, [res]
	call display
	
	mov rax, 60
	mov rdi, 0
	syscall

convert:
	mov rsi, num1
	mov al, [rsi]
	cmp al, 39h
	jbe l7
	sub al,07h
l7:	sub al,30h
	rol al,04h
	mov bl,al
	inc rsi
	
	mov al,[rsi]
	cmp al,39h
	jbe l8
	sub al,07h
l8:	sub al,30h
	add al,bl
	ret
	
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
	mov rdx,4		; rdx,4 to display 4 digits
	syscall
	ret
	
section .data
	
	msg db 10,"Add and Shift Multiplication :",10
	len: equ $-msg
	
	msg1 db "Enter  number 1 :"
	len1: equ $-msg1
	
	msg2 db "Enter  number 2 :"
	len2: equ $-msg2
	
	msg3 db "Answer          :"
	len3: equ $-msg3
	
section .bss
	res resb 10
	no1 resb 10
	no2 resb 10
	num1 resb 10
	num2 resb 10
	disparr resb 50
	
;---------------------------------------------
;OUTPUT : 
;
;Add and Shift Multiplication :
;Enter  number 1 :02
;Enter  number 2 :03
;Answer          :0006
;
	
	
