global _start

section .text

_start:

mov rax, 1
mov rdi, 1
mov rsi, helloMsg ; puts the address pointed by helloMsg into rsi
mov rdx, 14  ; 14 is the size of our message in bytes, put this into rdx

syscall ; rax=1==write,
	; --The content of rdi is the file descriptor, in this case 1 means stdout,
	; the standard output. The system call takes the address
	; in rsi as the beginning of the text to write, and
	; the value in rdx as the number of bytes to be written.

mov rax, 60
xor rdi, rdi ;rdi=0 --> exit code

syscall

section .data ; This is the section used to reserve memory for our program

  helloMsg: db "Hello, world!", 10     ; helloMsg will be replaced by a memory
                                      ; address, and when we use it we will
                                      ; be referring to this address.
                    ; db is a 8-bit (or byte) "type".
                    ; Then we write our string between double quotation marks,
                    ; each character taking up 1 byte, and we put the byte
                    ; 10 in the end. 10 is the newline character. Note that
                    ; we could have written this whole string as a sequence of
                    ; comma-separated numbers, each number representing the
                    ; ASCII code of the character.
