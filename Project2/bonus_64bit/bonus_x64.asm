extern printf

section .data
	print_format: db "max: %u", 13, 10, 0

section .text
	global intertwine

;; void intertwine(int *v1, int n1, int *v2, int n2, int *v);
;
;  Take the 2 arrays, v1 and v2 with varying lengths, n1 and n2,
;  and intertwine them
;  The resulting array is stored in v
intertwine:
	enter 0, 0
	push rbx
	push r12
	push r13

	mov r12, 0
	mov r13, 0

;pun elementele din cei doi vectori in vectorul final
loop:
	cmp r12, rsi
	je FirstArrayDone
	cmp r12, rcx
	je SecondArrayDone
	mov eax, dword [rdi]
	mov dword [r8 + 4 * r13], eax
	add r13, 1
	mov eax, dword [rdx]
	mov dword [r8 + 4 * r13], eax
	add r13, 1
	add rdi, 4
	add rdx, 4
	add r12, 1
	jmp loop

;in cazul in care primul vector s-a terminat
;continui cu al doilea
FirstArrayDone:
	cmp r12, rcx
	je exit
	mov eax, dword [rdx]
	mov dword [r8 + 4 * r13], eax
	add r13, 1
	add rdx, 4
	add r12, 1
	jmp FirstArrayDone

;in cazul in care al doilea vector s-a terminat
;continui cu primul
SecondArrayDone:
	cmp r12, rsi
	je exit
	mov eax, dword [rdi]
	mov dword [r8 + 4 * r13], eax
	add r13, 1
	add rdi, 4
	add r12, 1
	jmp SecondArrayDone

exit:
	
	pop r13
	pop r12
	pop rbx
	mov rax, 0
	leave
	ret
