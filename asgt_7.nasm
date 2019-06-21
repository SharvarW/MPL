;
;PROGRAM : Write 64 bit menu driven ALP to implement OS commands TYPE, COPY and DELETE using file. 
;NAME : SHARVARI S. WAGH
;SE(A)-73
;---------------------------------------------

global _start
 _start:

section .text

	%macro disp 2			;macro for disp
	mov rax, 1
	mov rdi,2
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
	mov rdi,%1
	syscall
	%endmacro

	pop rcx				
	pop rcx
	pop rcx
	
	mov [file_name], rcx
	fopen [file_name]
	cmp rax, -1h
	je error
	mov [file_handle], rax
	fread [file_handle], buff, buffer
	dec rax
	mov [abufflen], rax
	disp buff, [abufflen]

	pop rcx
	mov [file_name2], rcx
	fopen [file_name2]
	cmp rax, -1h
	je error
	mov [file_handle2], rax
	fwrite [file_handle2], buff, [abufflen]
	
	fclose [file_handle]
	fclose [file_handle2]
	
	mov rax, 87			;delete the file
	mov rdi, [file_name]
	syscall

error:	mov rax, 60
		mov rdi, 0
		syscall

section .bss

file_name resb 30
file_name2 resb 30
abufflen resb 30
file_handle resb 30
file_handle2 resb 30
buffer resb 30
buff resb 30

;-------------------------------------------------------------------------
;OUTPUT : 
;abcd
;
