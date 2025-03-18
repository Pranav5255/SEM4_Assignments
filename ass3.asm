;Assembly language program to find out largest number of a given byte, word, double or quad word from array and display it

section .data
	array db 11H,22H,05H,73H,33H
	m1 db "Display this array value" , 10,13
	l1 equ $-m1
	m2 db "Print largest value from array" , 10,13
	l2 equ $-m2

%macro write 2
	mov rax,1
	mov rdi,1
	mov rsi, %1
	mov rdx, %2
	syscall
%endmacro


section .bss
	counter resb 2
	result resb 4


section .text
	global _start
_start:
	;print array message
	write m1,l1

	;initialize counter and pointer
	mov byte[counter],05
	mov rsi,array

	d2:
		mov al,[rsi]
		push rsi
		call disp
		pop rsi
		inc rsi
		dec byte[counter]
		jnz d2

	;print largest number message
	write m2,l2

	;find largest value
	mov byte[counter],05
	mov rsi,array
	mov al,0

	d1:
		cmp al,[rsi]
		jg skip
		mov al,[rsi]
	skip:
		inc rsi
		dec byte[counter]
		jnz d1

	;display largest value
	call disp

	;exit the program
	mov rax,60
	mov rdi,0
	syscall

	disp:
	;convert input string into hexadecimal
	xor rbx,rbx
	mov bl,al
	mov rdi,result
	mov cx,02
	
	l3:
		rol bl,4
		mov al,bl
		and al,0FH
		cmp al,09H
		jg l4

		add al,30H
		jmp l5

	l4:
		add al , 37H
	l5:
		mov[rdi],al
		inc rdi
		dec cx
		jnz l3
		write result,4
		ret
