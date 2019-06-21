;PROGRAM :  Write 64 bit ALP to perform non-overlapped and overlapped block transfer. 
;NAME : SHARVARI S. WAGH
;SE(A)-73
;---------------------------------------------
global _start
_start:

section .text
mainmenu:
	mov rax,1
	mov rdi,1
	mov rsi, menu
	mov rdx, lenm
	syscall
	
;accepting the choice
	mov rax, 0
	mov rdi, 0
	mov rsi, choice
	mov rdx, 2
	syscall
	
	mov al, byte[choice]
	
	cmp al,31h
	je choice1
	
	cmp al,32h
	je choice2

	cmp al,33h
	je choice3

	cmp al,34h
	je choice4

	cmp al,35h
	je choice5


choice1:
	mov rax, 1
	mov rdi, 1
	mov rsi, m1
	mov rdx, len1
	syscall
	
	mov ah, 00h
	mov al, byte[cnt]
	
	mov rsi, sarr
l1:	mov al, [rsi]
	push rsi
	call disp_proc
	pop rsi
	
	inc rsi
	dec byte[cnt2]
	jnz l1


	mov rsi, sarr
	mov rdi, darr				;copying the elements
l2:	mov al, [rsi]
	mov [rdi], al
	
	inc rsi
	inc rdi
	dec byte[cnt]		;looping
	jnz l2

;display array
;displaying message
	mov rax, 1
	mov rdi, 1
	mov rsi, m2
	mov rdx, len2
	syscall
	
	mov ah, 00h
	mov al, byte[cnt]
	
	mov rsi, darr
l3:	mov al, [rsi]
	push rsi
	call disp_proc
	pop rsi
	
	inc rsi
	dec byte[cnt1]
	jnz l3
	jmp mainmenu
	
choice2:
	mov rax, 1
	mov rdi, 1
	mov rsi, m3
	mov rdx, len3
	syscall
	
	mov ah, 00h
	mov al, byte[cntc1]
	
	mov rsi, oarr
l4:	mov al, [rsi]
	push rsi
	call disp_proc
	pop rsi
	
	inc rsi
	dec byte[cntc2]
	jnz l4


	mov rsi, oarr					;overlapping block transfer
	mov rdi, oarr
	add rsi, 9
	add rdi, 13

l5:	mov al,[rsi]
	mov [rdi],al
	dec rsi
	dec rdi
	dec byte[cntc3]
	jnz l5


;display array
;displaying message
	mov rax, 1
	mov rdi, 1
	mov rsi, m4
	mov rdx, len4
	syscall
	
	mov ah, 00h
	mov al, byte[cntc1]
	
	mov rsi, oarr
l6:	mov al, [rsi]
	push rsi
	call disp_proc
	pop rsi
	
	inc rsi
	dec byte[cntc4]
	jnz l6
	jmp mainmenu

choice3:
	mov rax, 1
	mov rdi, 1
	mov rsi, m1
	mov rdx, len1
	syscall
	
	mov ah, 00h
	mov al, byte[cntc31]
	
	mov rsi, sarr
l7:	mov al, [rsi]
	push rsi
	call disp_proc
	pop rsi
	
	inc rsi
	dec byte[cntc32]
	jnz l7


	mov rsi, sarr
	mov rdi, darr				;copying the elements
	mov rcx, 7
	cld							;clear direction flag for auto increment of the rsi and rdi
	rep movsb					;string  instruction

;display array
;displaying message
	mov rax, 1
	mov rdi, 1
	mov rsi, m2
	mov rdx, len2
	syscall
	
	mov ah, 00h
	mov al, byte[cntc31]
	
	mov rsi, darr
l8:	mov al, [rsi]
	push rsi
	call disp_proc
	pop rsi
	
	inc rsi
	dec byte[cntc33]
	jnz l8
	jmp mainmenu

choice4:
	mov rax, 1
	mov rdi, 1
	mov rsi, m5
	mov rdx, len5
	syscall
	
	mov ah, 00h
	mov al, byte[cntc41]
	
	mov rsi, oarr1
l9:	mov al, [rsi]
	push rsi
	call disp_proc
	pop rsi
	
	inc rsi
	dec byte[cntc42]
	jnz l9


	mov rsi, oarr1					;overlapping block transfer
	mov rdi, oarr1
	add rsi, 9
	add rdi, 13

	std
	mov rcx, 0Ah
	rep movsb

;display array
;displaying message
	mov rax, 1
	mov rdi, 1
	mov rsi, m6
	mov rdx, len6
	syscall
	
;	mov ah, 00h
;	mov al, byte[cntc41]
	
	mov rsi, oarr1
l10:	mov al, [rsi]
	push rsi
	call disp_proc
	pop rsi
	
	inc rsi
	dec byte[cntc43]
	jnz l10
	jmp mainmenu
	
	
choice5:
	mov rax,60				;exit
	mov rdi,0
	syscall

;display procedure

disp_proc:
	mov rsi,disparr+1
	mov rcx, 2
l30:	mov rdx, 0
	mov rbx, 10h
	div rbx

	cmp dl, 09h
	jbe l40
	add dl, 07h
l40:	add dl, 30h
	mov [rsi], dl
	
	dec rsi
	dec rcx
	jnz l30
;spacing
	mov rax, 1
	mov rdi, 1
	mov rsi, m
	mov rdx, len
	syscall
	
	mov ah, 00h
	mov al, byte[cntc41]
	
	mov rax,1
	mov rdi, 1
	mov rsi,disparr
	mov rdx,2
	syscall
	
	ret
	
section .data
	menu db 10,"-----------------------------------------------------------------------",10
		    db      "                                   MENU",10
			db "-----------------------------------------------------------------------",10
		     db"1.	Non-overlapping  without string instructions",10
		     db"2.	Overlapping  without string instructions",10
		     db"3.	Non-overlapping  with string instructions",10
		     db"4.	Overlapping  with string instructions",10
		     db"5.	Exit",10
		db "-----------------------------------------------------------------------",10
		     db"		Enter your choice :"
	lenm: equ $-menu
	sarr db 12h,13h,34h,56h,67h,35h,45h,23h,23h,56h
	darr db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
	darr1 db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
	oarr db 01h,02h,03h,04h,05h,06h,07h,08h,09h,0Ah,0Bh,0Ch,0Dh,0Eh,0Fh
	oarr1 db 01h,02h,03h,04h,05h,06h,07h,08h,09h,0Ah,0Bh,0Ch,0Dh,0Eh,0Fh
	
	cnt db 10
	
	cnt1 db 10
	cnt2 db 10
	cnt3 db 15
	cntc4 db 15
	cntc2 db 15	
	cntc3 db 10
	cntc1 db 15
	cntc31 db 10
	cntc32 db 10
	cntc33 db 10
	cntc41 db 15
	cntc42 db 15
	cntc43 db 15
	m:db "   "
	len:equ $-m

	

	m1:db 10,"Source array: ",10
	len1:equ $-m1
	m2:db 10,"Destination array: ",10
	len2:equ $-m2
	
	m3:db 10,"Given array: ",10
	len3:equ $-m3
	m4:db 10,"Overlapped array: ",10
	len4:equ $-m4

	m5:db 10,"Given array: ",10
	len5:equ $-m5
	m6:db 10,"Overlapped array: ",10
	len6:equ $-m6
	
section .bss
	disparr resb 50
	choice resb 5
	
;-------------------------------------------------------------------------------------------------------------------
;-----------------------------------------------------------------------
;                                  MENU
;-----------------------------------------------------------------------
;1.	Non-overlapping  without string instructions
;2.	Overlapping  without string instructions
;3.	Non-overlapping  with string instructions
;4.	Overlapping  with string instructions
;5.	Exit
;-----------------------------------------------------------------------
;		Enter your choice :1
;
;Source array: 
;   12   13   34   56   67   35   45   23   23   56
;Destination array: 
;   12   13   34   56   67   35   45   23   23   56
;-----------------------------------------------------------------------
;                                   MENU
;-----------------------------------------------------------------------
;1.	Non-overlapping  without string instructions
;2.	Overlapping  without string instructions
;3.	Non-overlapping  with string instructions
;4.	Overlapping  with string instructions
;5.	Exit
;-----------------------------------------------------------------------
;		Enter your choice :2
;
;Given array: 
;   01   02   03   04   05   06   07   08   09   0A   0B   0C   0D   0E   0F
;Overlapped array: 
;   01   02   03   04   01   02   03   04   05   06   07   08   09   0A   0F
;-----------------------------------------------------------------------
;                                   MENU
;-----------------------------------------------------------------------
;1.	Non-overlapping  without string instructions
;2.	Overlapping  without string instructions
;3.	Non-overlapping  with string instructions
;4.	Overlapping  with string instructions
;5.	Exit
;-----------------------------------------------------------------------
;		Enter your choice :3
;
;Source array: 
;   12   13   34   56   67   35   45   23   23   56
;Destination array: 
;   12   13   34   56   67   35   45   23   23   56
;-----------------------------------------------------------------------
;                                   MENU
;-----------------------------------------------------------------------
;1.	Non-overlapping  without string instructions
;2.	Overlapping  without string instructions
;3.	Non-overlapping  with string instructions
;4.	Overlapping  with string instructions
;5.	Exit
;-----------------------------------------------------------------------
;		Enter your choice :4
;
;Given array: 
;   01   02   03   04   05   06   07   08   09   0A   0B   0C   0D   0E   0F
;Overlapped array: 
;   01   02   03   04   01   02   03   04   05   06   07   08   09   0A   0F
;-----------------------------------------------------------------------
;                                   MENU
;-----------------------------------------------------------------------
;1.	Non-overlapping  without string instructions
;2.	Overlapping  without string instructions
;3.	Non-overlapping  with string instructions
;4.	Overlapping  with string instructions
;5.	Exit
;-----------------------------------------------------------------------
;		Enter your choice :5
;	
