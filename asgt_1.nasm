;PROGRAM :  Write 64 bit ALP to count number of positive and negative numbers from the array 
;NAME : SHARVARI S. WAGH
;SE(A)-73
;---------------------------------------------

global _start
_start:	
	
;----------------------------------------------------------------------------------------
section .text 
 
	 %macro disp 2  				;display macro
	 mov rax,01
	 mov rdi,01
	 mov rsi,%1
	 mov rdx,%2
	 syscall
	 %endmacro

	 disp msg,len  	  				;new line 		
	 mov rsi,arr      					;copy array into rsi
			
  loop : 
  	 mov rax,[rsi]    					;print number
	 push rsi         					;contents of rsi will change in disp proc
	 call display	  					;call to display procedure 
	 disp msg,len     					;new line
	 pop rsi	  						;pop original rsi
	 add rsi ,8   	  					;rsi incremented by 2 byte
	 dec byte[display_cnt]			;array numbers count(4)
	 jnz loop	
	 mov rsi,arr      					;start procedure of counting
		
  loop2:
	 BT qword[rsi],63  				;to check MSB bit of number
	 jc  inc_neg	   					;if MSB bit SET then jump to label
	 inc byte[p_count] 				;else inc positive count
	 jmp label     	   				;jump to label
			
  inc_neg:
	 inc byte[n_count]				 ;inc negativs count
		
  label:
	 add rsi,8						;next element of array
	 dec byte[display_cnt1] 			;dec count
	 jnz loop2
			
	 disp p_msg,p_len				 ;display positive count		
	 mov ah,00h					 ;move positive count to register rax
	 mov al,byte[p_count]
	 call display
	 disp msg,len  
	 disp n_msg,n_len				 ;display negative count
	 mov ah,00h					 ;move negative count to register rax
	 mov al,byte[n_count]
	 call display
			
	 mov rax,60   					    ;system to EXIT 	       
	 mov rdi,0
	 syscall
	    
  display:    							;display procedure
  	  mov rsi,array+15         
	  mov rcx,16
		
     l2:  mov rdx,0
	  mov rbx,10h
	  div rbx      						;from last digit of num to first           
	  cmp dl,09h   
	  jbe l3
			
	  add dl,07h   					;if it is letter
    l3:   add dl,30h					;if it is number
	  mov [rsi],dl 					;mov data to rsi
	  dec rsi      
	  dec rcx
	  jnz l2
			
	  mov rax,1
	  mov rdi,1
	  mov rsi,array
	  mov rdx,16
	
	  syscall
	  ret
			
;-----------------------------------------------------------------------
section .data
		
	arr dq 8888888888888888h,9999999999999999h,5555555555555555h,3333333333333333h
	display_cnt db 4
	display_cnt1 db 4

	p_msg:db "Positive count : ",10
	p_len:equ $-p_msg
		
	n_msg:db "Negative count : ",10
	n_len:equ $-n_msg
		
	msg :db "",10  					 ;msg for new line
	len :equ $-msg	

;---------------------------------------------------------
section .bss
	array resb 36
	p_count resb 1
	n_count resb 1

;------------------------------------------------------------------------------
;OUTPUT :
;8888888888888888
;9999999999999999
;5555555555555555
;3333333333333333
;Positive count : 
;0000000000000002
;Negative count : 
;0000000000000002		
;
		
	
		 
		
