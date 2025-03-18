;Assembly program accept 5 decimal number and display them using an array

section .data
	m1 db "Accept five 64-bits number: ",10,13          ;this 10,13 gives newline and a carriage return
	l1 equ $-m1
	m2 db "Display five 64-bits number: ",10,13
	l2 equ $-m2
section .bss
	array resb 100
	counter resb 2
section .text
	global _start
_start:

	;first we need to display the message m1
	mov rax,1
	mov rdi,1
	mov rsi, m1
	mov rdx,l1
	syscall
	
	;now we need to take 5 numbers and store them in the array
	mov byte[counter],05             ;setup of counter
	mov rbx,0                        ;base register = 0
	accept:                          ;loops starts here with the variable accept here.. you can change the name as per your choice
	mov rax,0
	mov rdi,0
	mov rsi,array
	add rsi, rbx                      ;rsi+rbx
	mov rdx,17                        ;17 because 16 bits for number and 1 bit for enter
	syscall
	add rbx,17
	dec byte[counter]                 ; dec the counter to 0 
	jnz accept                        ;this will jump out of the loop when the counter becomes 0
	
	;now we need to display the message m2
	mov rax,1
	mov rdi,1
	mov rsi,m2
	mov rdx,l2
	syscall
	
	;now we need to display the array
	mov byte[counter],05
	mov rbx,0
	display:
	mov rax,1
	mov rdi,1
	mov rsi,array
	add rsi,rbx
	mov rdx,17
	syscall
	add rbx,17
	dec byte[counter]
	jnz display
	
	;exit the program
	mov rax,60
	mov rdi,0
	syscall
