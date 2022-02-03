extern qsort
extern strlen

global get_words
global compare_func
global sort

section .text

;functia de comparare lexicografica
compareL:
	push ebp
	mov ebp, esp


	mov ecx, [ebp + 8]
	mov edx, [ebp + 12]
	mov ecx, [ecx]
	mov edx, [edx]

;verific caracter cu caracter si vad
;care este mai mare in ascii
loopS:
	mov ebx, 0
	mov bl, byte [ecx]

	;verific daca s-a terminat stringul
	cmp ebx, 0
	je EndOfString
	
	mov eax, ebx
	mov ebx, 0
	mov bl, byte [edx]
	
	;verific daca s-a terminat stringul
	cmp ebx, 0
	je EndOfString
	
	add ecx, 1
	add edx, 1

	;verific care caracter este mai mare
	sub eax, ebx
	cmp eax, 0
	je loopS

	cmp eax, 0
	jg big
	cmp eax, 0
	jl small

big:
	mov eax, 1
	jmp exitCompareL

small:
	mov eax, -1
	jmp exitCompareL


EndOfString:
	mov eax, 0

exitCompareL:
	
	leave
	ret

;functia de comparare pentru qsort
compare:
	push ebp
    mov ebp, esp

	mov ecx, [ebp + 8]
	mov ecx, [ecx]
	
	push ecx
	call strlen

	mov ebx, eax

	add esp, 4
	mov ecx, [ebp + 12]
	mov ecx, [ecx]
	
	push ecx
	call strlen

	add esp, 4
	
	xchg eax, ebx
	sub eax, ebx

	;verific diferenta de lungimi a string-urilor
	cmp eax, 0
	jne exitCompare


	mov ecx, [ebp + 8]
	mov edx, [ebp + 12]

	;in caz de egalitate apelez functia de comparare lexicografica
	push edx
	push ecx
	call compareL
	add esp, 8

exitCompare:
	leave
	ret

;; sort(char **words, int number_of_words, int size)
;  functia va trebui sa apeleze qsort pentru soratrea cuvintelor 
;  dupa lungime si apoi lexicografix

sort:
    push ebp
    mov ebp, esp

    mov ecx, [ebp + 16]
    mov edx, [ebp + 12]
    mov ebx, [ebp + 8]

    ;apelez qsort cu functia "compare"
	push dword compare
    push ecx
    push edx
    push ebx

    call qsort
    add esp, 16
    
    leave
    ret

;; get_words(char *s, char **words, int number_of_words)
;  separa stringul s in cuvinte si salveaza cuvintele in words
;  number_of_words reprezinta numarul de cuvinte
get_words:
    enter 0, 0

    mov ecx, [ebp + 8]
    mov edx, [ebp + 12]
    mov esi, 0
    mov eax, 0
    mov ebx, [edx]

;verific daca gasesc vreun delimitator in string
findWords:
	mov al, byte [ecx]
	test al, al
	je exit
	cmp eax, ' '
	je foundDelim
	cmp eax, ','
	je foundDelim
	cmp eax, '.'
	je foundDelim
	cmp eax, 10
	je foundDelim

	;daca nu s-a gasit vreun delimitator, pun caracter cu caracter
	;pentru a forma un cuvant
	mov byte [ebx], al
	add ebx, 1
	add ecx, 1
	jmp findWords

;daca se gaseste un delimitator, verific daca sunt mai multe dupa acesta
;iar daca nu sunt iau urmatoarea pozitie din vectorul de stringuri
foundDelim:
	add ecx, 1
	mov al, byte [ecx]
	test al, al
	je exit
	cmp eax, ' '
	je foundDelim
	cmp eax, ','
	je foundDelim
	cmp eax, '.'
	je foundDelim
	cmp eax, 10
	je foundDelim
	add esi, 1
	mov ebx, [edx + 4 * esi]
	jmp findWords

exit:
    leave
    ret
