section .text
	global par

;; int par(int str_length, char* str)
;
; check for balanced brackets in an expression
par:
	push ebp
	push esp
	pop ebp

	push dword [ebp + 12]
	pop ecx
	push 0
	pop ebx
	push 0
	pop eax

checkBrackets:
	cmp ebx, [ebp + 8]
	je result
	push 0
	pop edx

	;pun cate un caracter si il verific
	;daca e paranteza inchisa
	push dword [ecx + ebx]
	pop edx
	cmp dl, 41
	je closeBracket

	add eax, 1
	add ebx, 1
	jmp checkBrackets

;daca e paranteza inchisa scad eax cu 1
closeBracket:
	sub eax, 1
	cmp eax, 0
	jl result
	add ebx, 1
	jmp checkBrackets

;verific la sfarsit daca eax e 0 sau nu
result:
	cmp eax, 0
	je trueSeq
	push 0
	pop eax
	jmp exit

trueSeq:
	push 1
	pop eax
exit:
	
	pop ebp
	ret
