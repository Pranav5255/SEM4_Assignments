;Assembly language program to find out largest number of a given byte, word, double or quad word from array and display it

section .data
	array db 11H,22H,05H,73H,33H						;Array of 5 bytes
	m1 db "Display this array value" , 10,13
	l1 equ $-m1
	m2 db "Print largest value from array" , 10,13
	l2 equ $-m2

%macro write 2
	mov rax,1								;System call for write
	mov rdi,1								;stdout file descriptor
	mov rsi, %1								;First parameter: buffer address
	mov rdx, %2								;Second parameter: buffer length
	syscall
%endmacro


section .bss
	counter resb 2
	result resb 4


section .text
	global _start
_start:
	;print array message							
	write m1,l1								;Call macro to display m1
					
	;initialize counter and pointer
	mov byte[counter],05							;Set counter to 5
	mov rsi,array								;Point to start of array

	d2:									;Display element of loop
		mov al,[rsi]							;Load current value to al
		push rsi							;Save array points
		call disp							;Call display procedure
		pop rsi								;Restore array pointer
		inc rsi								;Move to next array element
		dec byte[counter]						;Decrement counter
		jnz d2								;Continue loop till counter=0

	;print largest number message
	write m2,l2

	;find largest value
	mov byte[counter],05							;Reset counter to 5
	mov rsi,array								;Reset pointer to array start
	mov al,0								;Initialise max. value to 0

	d1:									;Loop to find max
		cmp al,[rsi]							;Compare arr max with array ele
		jg skip								;If max > curr ele, skip update
		mov al,[rsi]							;Else, update max
	skip:
		inc rsi								;Move to next ele
		dec byte[counter]						;Decrement counter
		jnz d1								;If counter not zero, continue loop

	;display largest value
	call disp

	;exit the program
	mov rax,60
	mov rdi,0
	syscall

	disp:
	;convert input string into hexadecimal
	xor rbx,rbx								;Clear rbx
	mov bl,al								;Move value to convert to bl
	mov rdi,result								;Point to result buffer
	mov cx,02								;Set counter to 2
	
	l3:
		rol bl,4							;Rotate left bit by 4 bits
		mov al,bl							;Get current 4 bits in al
		and al,0FH							;Mask off high bits
		cmp al,09H							;Compare with 9
		jg l4								;If > 9, jump to l4
					
		add al,30H							;Convert to ASCII(0-9)
		jmp l5								;Jump to store

	l4:
		add al , 37H							;Convert to ASCII letter
	l5:
		mov[rdi],al							;Store in result buffer
		inc rdi								;Move to next position
		dec cx								;Decrement counter
		jnz l3								;If counter != 0, continue
		write result,4							;Display result
		ret
