section .text
	global cmmmc

;; int cmmmc(int a, int b)
;
;; calculate least common multiple fow 2 numbers, a and b
cmmmc:
	push ebp
	push esp
	pop ebp

	push dword [ebp + 8]
	pop ebx ;primul argument
	push dword [ebp + 12]
	pop edi ;al doilea argument

	push ebx
	pop eax
	;stochez in eax maximul
	cmp ebx, edi
	jl greatestNumber
	jmp skip

greatestNumber:
	push edi
	pop eax

skip:

;verific daca eax se imparte exact la primul
;element si daca se imparte ma duc pe 
;verifySecondNumber
lcmLoop:
	;pun eax in ecx
	push eax
	pop ecx
	push 0
	pop edx
	div ebx
	cmp edx, 0
	je verifySecondNumber
	push ecx
	pop eax
	;daca nu se imparte cresc eax cu 1
	add eax, 1
	jmp lcmLoop

;verific daca eax se imparte exact la al doilea
;numar
verifySecondNumber:
	push ecx
	pop eax
	push 0
	pop edx
	div edi
	cmp edx, 0
	je exit
	push ecx
	pop eax
	;daca nu se imparte cresc eax cu 1
	add eax, 1
	jmp lcmLoop

exit:
	push ecx
	pop eax
	
	pop ebp
	ret
