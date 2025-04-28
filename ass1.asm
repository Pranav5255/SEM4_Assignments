section .data

hello: db "Enter 5 hexadecimal digits: ", 0xA
len: equ $-hello

show:db "The 5 numbers are: ", 0xA
len2:equ $-show

cnt1: db 05h   		;Loop counter (5times)
cnt2: db 05h   		;Loop counter (5times)

section .bss
arr resb 85    		;Buffer of 85bytes to store user input

section .text
global _start
_start:
;Enter 5 hexadecimal digits message
	mov rax, 01	;System call for write
	mov rdi, 01	;File descriptor 1 is stdout
	mov rsi, hello	;Pointer to message
	mov rdx, len	;Message length
	syscall

mov r8, arr		;r8 points to buffer
l1:
	mov rax, 00	;System call number for read
	mov rdi, 00	;File descriptor 0 is sdin
	mov rsi, r8	;Store input at r8 position
	mov rdx, 17	;Read 17bytes
	syscall

add r8, 17		;Move pointer to next block
dec byte[cnt1]		;Decreases counter
jnz l1			;Jump if counter is not zero

;Print 5 numbers message
	mov rax, 01
	mov rdi, 01
	mov rsi, show
	mov rdx, len2
	syscall

mov r8, arr
l2:
	mov rax, 01	;System call for write
	mov rdi, 01	;File descriptor 1 is stdout
	mov rsi, r8	;Store output at r8
	mov rdx, 17	;Write 17 bytes
	syscall

add r8, 17
dec byte[cnt2]
jnz l2

mov rax, 60
mov rdi, 90
syscall
ret			;standard exit procedure
