

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
	mov rsi,string
	mov rdx,20
	syscall
	
	;convert input string into hexadecimal
	xor rbx,rbx
	mov rbx,rax
	mov rdi,res
	mov cx,16

	l1: 
		rol rbx,4
		mov al,bl
		and al,0FH
		cmp al,09H
		jg l2
	
	add al,30H
	jmp l3
	
	l2:
		add al , 37H
	l3:
		mov[rdi],al
	inc rdi
	dec cx
	jnz l1
	
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
	
	
