section .text
	global sort

; struct node {
;     	int val;
;    	struct node* next;
; };

;; struct node* sort(int n, struct node* node);
; 	The function will link the nodes in the array
;	in ascending order and will return the address
;	of the new found head of the list
; @params:
;	n -> the number of nodes in the array
;	node -> a pointer to the beginning in the array
; @returns:
;	the address of the head of the sorted list
sort:
	enter 0, 0
	
	mov ecx, [ebp + 12]
	mov edx, 0

;fac doua for-uri pentru a sorta array-ul
firstFor:
	cmp edx, [ebp + 8]
	jge exitFirstFor
	mov edi, 0
	mov ebx, 0

secondFor:
	cmp ebx, [ebp + 8]
	jge exitSecondFor

	;pun in esi elementul de pe pozitia ebx
	mov esi, [ecx +  8 * ebx]
	sub esi, 1
	
	;daca este egal cu elementul anterior + 1
	;salvez pozitia lui in vector
	cmp esi, edx
	je updateMin
	add ebx, 1
	jmp secondFor

;updatez minimul
updateMin:
	mov edi, ebx
	add ebx, 1
	jmp secondFor

;pun pe next adresa urmatorului element
;mai mare decat cel anterior
exitSecondFor:
	cmp edx, 0
	je firstElement
	mov esi, ecx
	jmp multiplyEsi
backEsi:
	mov [eax + 4], esi
	mov eax, esi
	add edx, 1
	jmp firstFor

;folosesc multiply pentru a ajunge la adresa
;elementului care e pe pozitia edi
multiplyEsi:
	cmp edi, 0
	je backEsi
	add esi, 8
	sub edi, 1
	jmp multiplyEsi

;pun elementul cu cea mai mica valoare in eax
firstElement:
	mov eax, ecx
	jmp multiply
back:
	push eax
	add edx, 1
	jmp firstFor

;folosesc multiply pentru a ajunge la adresa
;elementului care e pe pozitia edi
multiply:
	cmp edi, 0
	je back
	add eax, 8
	sub edi, 1
	jmp multiply

exitFirstFor:
	pop eax

	leave
	ret
