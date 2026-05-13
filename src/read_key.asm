SYSCALL_WRITE equ 1
STDOUT equ 1

section .data; variables are defind with value 
;mess1 db 'press"ESC"for exit from program', 10 ; 10 means newline
;mess2 db 'enter a charachter :', 10

section .bss ;reserving memory
store_byte resb 1
LEN equ 1 ; for unknown bytes
	  ; $ store_byte - nasm directive, here $ means the current position
	  ; so LEN is the size of data starting starting in mess2

section .text
global _start

_start:

again:
call read_key
cmp al, 1BH ; ascii(ESC) = 1BH
je exit

call disp_char
jmp again

exit:
mov rax, 60
xor rdi, rdi ; rdi = 0
syscall     ; since rax = 60 it means terminate program

read_key:
mov rax, 0 ;type of syscall : sys_read
mov rdi, 0 ;type of file : stdin
mov rsi, store_byte ; read content
mov rdx, 1 ; read 1byte
syscall

mov al, [rsi]
ret

disp_char:
mov rax, 1 ;sys_write
mov rdi, 1 ;stdout
mov rsi, store_byte ; content to write goes in rsi
mov rdx, LEN; length of content goes in rdx
syscall

mov al, [rsi]
ret
