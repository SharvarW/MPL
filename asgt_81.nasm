;
;PROGRAM :  Write 64 bit ALP to find, a) Number of Blank spaces
;								       b) Number of lines
;								       c) Occurrence of a particular character using FAR procedure and file 
;NAME : SHARVARI S. WAGH
;SE(A)-73
;---------------------------------------------
%include "macro.nasm"
global _start
_start:
;------------------------------------------------

extern procedure_1
global buffer,actual_buf_len

;------------------------------------------------
section .text

	pop rcx
	pop rcx
	pop rcx
	
	mov [filename],rcx
	fopen [filename]
	cmp rax,-1h
	je error
	
	mov [filehandle],rax
	fread [filehandle],buffer,buf_len
	
	dec rax
	mov [actual_buf_len],rax
	
	call procedure_1
	fclose [filehandle]
	jmp exit
	error:	
		disp error_msg,len_error
exit :
	mov rax,60
	mov rdi,0
	syscall

;-------------------------------------------------
section .bss

buffer resb 1024
buf_len resb 50
actual_buf_len resb 50
filename resb 20
filehandle resb 20

;-------------------------------------------------
section .data

error_msg: db "Error in openning file"
len_error	: equ $-error_msg

;------------------------------------------------------------------------------------------------
;OUTPUT : 
;hello
;how are you
;all the best
;
;Enter the character whose occurence is to be counted : a
;
;The enter count is : 0003
;The space count is : 0004
;The character count is : 0002
;
