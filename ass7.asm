

%macro IO 4
    mov rax, %1
    mov rdi, %2
    mov rsi, %3
    mov rdx, %4
    syscall
%endmacro



section .data

    Prot db "Protected Mode : ",10
    Protlen equ $-Prot
    
    Real db "Real Mode : ",10
    Reallen equ $-Real
    
    msw db "MSW  : "
    mswlen equ $-msw
    
    gdtr db 10,"GDTR : "
    gdtrlen equ $-gdtr
    
    idt db 10,"IDTR : "
    idtlen equ $-idt
    
    tr db 10,"TR : "
    trlen equ $-tr
    
    ld db 10,"LDTR : "
    ldlen equ $-ld
    
    colsgn db ":"


    
section .bss
    gdt resb 8                      
    gdtli resb 2                    
    msw1 resb 2                     
    temp resb 1                     
    result1 resq 1      
    result2 resw 1
    idt1 resb 8                     
    idtli resb 2                    
    ldt resb 2                      
    t_r resb 2                      



section .text
    global _start

_start:
    mov rsi,msw1
    smsw [rsi]
    mov ax,[rsi]
    bt ax,0                         
    jc next                         
    IO 1,1,Real,Reallen             
    jmp z1

next: 
    IO 1,1,Prot,Protlen 

z1:
    IO 1,1,msw,mswlen               
    mov ax,word[msw1]
    call display2 
    
    IO 1,1,gdtr,gdtrlen
    mov rsi,gdt
    sgdt [rsi]
    mov rax, qword[rsi]
    call display1  
    
    IO 1,1,colsgn,1                 
    
    mov rsi,gdtli
    mov ax,word[rsi]
    call display2                   
    
    IO 1,1,ld,ldlen
    mov rsi,ldt
    sldt [rsi]
    mov rax, [ldt]
    call display2                   
    
    IO 1,1,idt,idtlen
    mov rsi,idt1
    sidt [rsi]
    mov rax, [idt1]
    call display1                   
    
    IO 1,1,colsgn,1
    
    mov ax,[idtli]
    call display2                   
    
    IO 1,1,tr,trlen
    mov rsi,t_r
    str [rsi]
    mov rax, [t_r]
    call display2                    
    
    ; Exit System Call
    IO 60,0,0,0 

; ----------- PROCEDURES -----------
    
display1:

        mov bp,16                   
    up1:
        rol ax,4
        mov qword[result1],rax
        and al,0fh
        cmp al,09h
        jbe next1
        add al,07h
    next1:
        add al,30h
        mov byte[temp],al
        IO 1,1,temp,1
        mov rax,qword[result1]
        dec bp
        jnz up1
        ret

display2:  
                                    
        mov bp,4                     
    up2:
        rol ax,4
        mov word[result2],ax
        and al,0fh
        cmp al,09h
        jbe next2
        add al,07h
    next2:
        add al,30h
        mov byte[temp],al
        IO 1,1,temp,1
        mov ax,word[result2]
        dec bp
        jnz up2
        ret
