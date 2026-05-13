global _start

section .text
_start:

xor al, al

loop10:
not al
mov [buf] ,al
call display_char
jmp loop10 ;infinite loop

display_char:
mov rax, 1;sys-write
mov rdi, 1;stdout
mov rsi, buf;char in buf will be displayed
mov rdx, 1
syscall
ret

mov rax, 60
xor rdi, rdi

section .bss
buf resb 1

