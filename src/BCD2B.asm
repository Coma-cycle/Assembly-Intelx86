global _start

section .text

BCDTOBinary:
	xor rax, rax
	mov rcx, 1000
	mov rsi, Num1
	movzx rdx,byte [rsi]

.BCD10:	add rax, rdx
	dec rcx
	jnz .BCD10
	push rax ;data in rax is stored in stack memory save part1

	xor rax, rax
	mov rcx, 100
	movzx rdx, byte [rsi + 1]

.BCD20:	add rax, rdx
	dec rcx
	jnz .BCD20
	push rax ; save part2

	xor rax, rax
	mov rcx, 10
	movzx rdx,byte [rsi + 2]

.BCD30:	add rax ,rdx
	dec rcx
	jnz .BCD30

	movzx rdx, byte [rsi + 3]
	add rax, rdx
	pop rdx ;the last data stored in stack --output BCD20 part2
	add rax, rdx
	pop rdx ; part1
	add rax, rdx
	ret

print_number:
mov rbx, 10
mov rsi, buf+19 ; start point of memory is buf + 19
	          ;since we take number from write to left as remainder
		  ;in a few ines i will store it from left to write to diplay
	.convert:
	xor rdx, rdx
	div rbx
	add dl, '0' ; for example in 1234 1234/10 dl  = '4' + '0' = '4'
	mov [rsi], dl ; remember rsi = buf+19
	dec rsi ; rsi = rsi - 1
	test rax, rax ;just an arithmetic to trigger flag jnz
	jnz .convert
inc rsi ;
mov rax , 1 ;sys_write
mov rdi, 1 ; stdout
; rsi already points to first digit
lea rdx, buf+20
sub rdx, rsi
syscall ; now it will print the value in [rsi], [rsi + 1], ..., [rsi + 4]

_start:
call BCDTOBinary
call print_number
xor rdi, rdi
mov rax ,60
syscall


section .data
Num1: db 1, 2, 4, 7 ;BCD digits

section .bss
buf resb 20
