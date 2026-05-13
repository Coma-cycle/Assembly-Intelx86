global _start

section .data
msg_ok: db "RAM OK", 10
msg_ok_len: equ $ - msg_ok

msg_err:  db "RAM ERROR", 10
msg_err_len: equ $ - msg_err

section .bss
buffer resb 2048   ;2048=2KB ending address = 0000H + 0800H - 1 = 07FFH

section .text

_start:
    ; ===== Fill buffer with 0xAA =====
    mov rcx, 2048 ; 2000 bytes all containing AAH = 10101010 
    mov rdi, buffer
    mov al, 0xAA;

.fill_loop:
    mov [rdi], al
    inc rdi
    loop .fill_loop

    ; ===== Verify buffer =====
    mov rcx, 2048
    mov rdi, buffer
    mov al, 0xAA ;al=10101010

.verify_loop:
    cmp byte [rdi], al
    jne .TEST10
    inc rdi
    loop .verify_loop

    ; ===== All OK =====
.TEST20:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg_ok
    mov rdx, msg_ok_len
    syscall
    jmp .exit

    ; ===== Error =====
.TEST10:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg_err
    mov rdx, msg_err_len
    syscall

.exit:
    mov rax, 60
    xor rdi, rdi
    syscall
