

section .data
	m1 db "Accept a string: ",10,13          ;this 10,13 gives newline and a carriage return
	l equ $-m1
section .bss
	string resb 200
	res resb 16
section .text
	global _start
_start:
	;first we need to display the message m1
	mov rax,1
	mov rdi,1
	mov rsi, m1
	mov rdx,l
	syscall
	
	;take input from user
	mov rax,0
	mov rdi,0
	mov rsi,string				;Buffer to store input
	mov rdx,20				;Read upto 20bytes
	syscall
	
	;convert input string into hexadecimal
	xor rbx,rbx				;Clears rbx register
	mov rbx,rax				;Moves input length to rbx
	mov rdi,res				;Points rdi to result buffer
	mov cx,16				;Sets counter to 16

	l1: 
		rol rbx,4			;Rotate left by 4 bits
		mov al,bl			;Copy lowest byte to al
		and al,0FH			;Mask to get only lowest 4bits
		cmp al,09H			;Compare with 9
		jg l2				;If >9, goto 12
	
	add al,30H				;Convert to ASCII no.
	jmp l3
	
	l2:
		add al , 37H			;Convert to ASCII Letters(A-F)
	l3:
		mov[rdi],al			;Store ASCII chars in result buffer
	inc rdi					;Move to next position in buffer
	dec cx					;Decrement Counter
	jnz l1					;If counter is not zero, continue loop
	
	; Print the hexadecimal result string
   	mov rax, 1      
	mov rdi, 1          
	mov rsi, res      
	mov rdx,16    
	syscall

	;exit the program
	mov rax,60
	mov rdi,0
	syscall
	
	
