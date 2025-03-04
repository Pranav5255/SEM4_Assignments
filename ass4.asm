;write the assembly lang program using the switch case to perform 64 bit hexadecimal arithmetic operation(+,-,*,/) usign the suitable macro
;defne the procedure for each operation 

section .data


menu db "-------Enter your choice:-----",10,13,"MENU",10,13,"1:Addition",10,13," 2:Substraction",10,13," 3:Multiplication",10,13," 4:Division",10,13," 5:exit",

menulen equ $-menu
choice db 10d , 13d , "Enter Choice : "
choicelen equ $-choice




inputmsg1 db "1st Number: "
  inputmsg1len equ $-inputmsg1
 
  inputmsg2 db "2nd Number: "
  inputmsg2len equ $-inputmsg2
 
  outputmsg db "Result: "
  outputmsglen equ $-outputmsg
 
 
  addmsg db 10d , 13d , "Result of Addition is: "
  addmsglen equ $-addmsg
 
  submsg db 10d , 13d , "Result of Substraction is: "
  submsglen equ $-submsg
 
  mulmsg db 10d , 13d , "Result of Multiplication is: "
  mulmsglen equ $-mulmsg
 
  divmsg db 10d , 13d , "Result of Division is: "
  divmsglen equ $-divmsg
 
 
 
  array dq 0000000000000006H, 0000000000000006H
  arraylen equ 2

section .bss
  c resb 1
  num resb 16
 
%macro rw 3
  mov rax, %1
  mov rdi, %1
  mov rsi, %2
  mov rdx, %3
  syscall
%endmacro

%macro exit 0
  mov rax, 60
  mov rdi, 0
  syscall
%endmacro



section .text
global _start
_start:

rw 1 , menu , menulen

rw 1 , choice , choicelen
rw 0 , c , 2

    cmp byte[c], '1'
    je case1
   
    cmp byte[c], '2'
    je case2
   
    cmp byte[c], '3'
    je case3
   
    cmp byte[c], '4'
    je case4
   
    cmp byte[c], '5'
    je case5  
   
   
   
    case1:
    call addition
    jmp case5
   
    case2:
    call substraction
    jmp case5
   
    case3:
    call multiplication
    jmp case5
   
    case4:
    call division
    jmp case5
   
    case5:
    exit
   
   
   
    addition:
      rw 1 , addmsg , addmsglen
      mov rbp, array
      mov rbx, [rbp]
      add rbx, [rbp+8]
      call hexToAscii
      rw 1 , num , 16
      ret
   
   
      substraction:
      rw 1 , submsg , submsglen
      mov rbp, array
      mov rbx, [rbp]
      sub rbx, [rbp+8]
      call hexToAscii
      rw 1 , num , 16
      ret
     
      multiplication:
     rw 1 , mulmsg , mulmsglen
     mov rsi , array
     mov eax, [rsi]
     add rsi , 08
     mov ebx , [rsi]
     mul ebx
     mov rbx , rax
      call hexToAscii
      rw 1 , num , 16
      ret
     
     
      division:
     rw 1 , divmsg , divmsglen
     mov rdx ,0
     mov rsi , array
     mov rax , [rsi]
     add rsi , 08
     mov ebx , [rsi]
     div ebx
     mov rbx , rax
     call hexToAscii
     rw 1 , num , 16
     xor rbx,rbx
     mov rbx , rdx
     call hexToAscii
     rw 1 , num , 16
      ret
   
   
    hexToAscii:
      mov rcx, 16
      mov rdi, num
 
      loop1:
        rol rbx, 04H
        mov al, bl
        and al, 0FH
        cmp al, 09
        jg a1
        add al, 30H
        jmp a2
   
        a1: add al, 37H
   
        a2: mov byte[rdi], al
            inc rdi
            dec rcx
            jnz loop1
         
      ret
