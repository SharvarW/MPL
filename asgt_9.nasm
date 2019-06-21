;PROGRAM : Write 64 bit program to sort the list of integers using bubble sort and file 
;NAME : SHARVARI S. WAGH
;SE(A)-73
;---------------------------------------------

global _start
 _start:

section .text

	%macro disp 2			;macro for disp
	mov rax, 1
	mov rdi,1
	mov rsi,%1
	mov rdx,%2
	syscall
	%endmacro

	%macro fopen 1			;macro for  file open
	mov rax, 2
	mov rdi,%1
	mov rsi,2
	mov rdx,0777o
	syscall
	%endmacro

	
	%macro fread 3			;macro for file read
	mov rax, 0
	mov rdi,%1
	mov rsi, %2
	mov rdx, %3
	syscall
	%endmacro

	%macro fwrite 3			;macro for file write
	mov rax, 1
	mov rdi,%1
	mov rsi, %2
	mov rdx, %3
	syscall
	%endmacro

	%macro fclose 1			;macro for file close
	mov rax, 3
	mov rdi, %1
	syscall
	%endmacro

	pop rcx				
	pop rcx
	pop rcx
	
	mov [file_name], rcx
	fopen[file_name]
	cmp rax, -1h
	je error
	mov [file_handle], rax
	fread [file_handle], buff, buffer
	dec rax
	mov [abufflen], rax
	disp buff, [abufflen]

	call lengthoffile
	call removeenter
	call bsort
	
	
	fwrite [file_handle], buff1, [lbuff1]
	disp buff1, lbuff1
	fclose [file_name]
	
error:mov rax, 60				
	mov rdi, 0
	syscall


;PROCEDURES

lengthoffile:
	mov rsi, buff
	mov dl, 50h			;any number
	mov cl, 00h				;cl counts the length of the buff
c1:	mov al, [rsi]
	cmp al, 0Ah
	
	jne c2
	inc cl
	inc cl
c2:	inc rsi
	dec dl
	jnz c1
	
	mov [lbuff], cl			;length of the buffer
	ret
	
removeenter:
	mov rsi, buff
	mov rdi, buff1
	mov cl, 00h
	mov dl, [lbuff]
	
l1:	mov al, [rsi]
	mov [rdi], al
	inc rsi
	inc rsi
	inc rdi
	inc cl
	dec dl
	dec dl
	jnz l1
	mov [lbuff1], cl
	ret

bsort:
	mov cl, [lbuff]
	mov [cnt1], cl
j1:	mov rsi, buff1
	mov rdi, buff1
	inc rdi
	mov cl, [lbuff1]
	dec cl
	mov [cnt2], cl

j2:	mov cl, [rsi]
	mov dl, [rdi]
	cmp cl, dl
	jbe j3
	call swap

j3:	mov [rsi], cl
	mov [rdi], dl
	inc rsi
	inc rdi
	dec byte[cnt2]
	jnz j2
	dec byte[cnt1]
	jnz j1
	ret

swap:
	mov al, cl
	mov cl, dl
	mov dl, al
	ret
	
section .bss

cnt1 resb 50
cnt2 resb 50	
file_name resb 30
abufflen resb 30
file_handle resb 30
buffer resb 30
buff resb 30
buff1 resb 30
lbuff resb 30
lbuff1 resb 30

;---------------------------------------------
;OUTPUT : 
;6
;9
;2
;3
;Sorted array:
;2369
;--------------------------------------------
