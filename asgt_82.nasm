%include "macro.nasm"
global _main
_main:

extern buffer,actual_buf_len
global procedure_1

display : 	mov rsi,disp_array+3
			mov rcx,4
loop:	mov rdx,0h
		mov rbx,10h

		div rbx
		cmp dl,09h
		jbe l1
		add dl,07h
l1:		add dl,30h
		mov [rsi],dl
		dec rsi
		dec rcx
		jnz loop
		mov rax,1
		mov rdi,1
		mov rsi,disp_array
		mov rdx,4
		syscall
		ret

procedure_1:
	disp buffer,[actual_buf_len]
	disp new_line,len_new_line
	disp msg,len_msg
	accept character,2
	disp new_line,len_new_line
	mov bl,[character]
	mov rsi,buffer
	
loop_cnt:
	mov al,[rsi]
	
	cmp al,0Ah
	je enter_1
	
	cmp al,20h
	je space_1
	
	cmp al,bl
	je char_1
	
	jmp next
	
	enter_1:
		inc word[enter_count]
		jmp next
		
	space_1:
		inc word[space_count]
		jmp next
		
	char_1:
		inc word[char_count]
		jmp next
		
	next:
		inc rsi
		dec qword[actual_buf_len]
		jnz loop_cnt
		
	disp enter_msg,len_enter	
	mov rax,[enter_count]
	call display
	
	disp new_line,len_new_line
	
	disp space_msg,len_space	
	mov rax,[space_count]
	call display
	
	disp new_line,len_new_line
	
	disp char_msg,len_char	
	mov rax,[char_count]
	call display
	
	disp new_line,len_new_line
	
	ret		
;---------------------------------------------------------------
section .bss

disp_array resb 16
character resb 4
enter_count resw 4
space_count resw 4
char_count resw 4

;---------------------------------------------------------------
section .data

enter_msg : db "The enter count is : "
len_enter  : equ $-enter_msg

new_line : db "",10
len_new_line : equ $-new_line

space_msg : db "The space count is : "
len_space : equ $-space_msg

char_msg : db "The character count is : "
len_char : equ $-char_msg

msg : db "Enter the character whose occurence is to be counted : "
len_msg :	equ $-msg
 


		
