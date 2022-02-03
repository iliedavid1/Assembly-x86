extern strcmp
extern printf

section .data
	print db "number: %d", 10, 0
	printul db "nu: %d", 10, 0
	s1 db "ab", 0
	s2 db "aa", 0

global main

section .text

main:
	enter 0, 0

	push s1
	push s2
	call strcmp
	add esp, 8

	push eax
	push print
	call printf

	add esp, 8

	leave
	ret