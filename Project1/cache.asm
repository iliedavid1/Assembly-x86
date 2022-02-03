;; defining constants, you can use these as immediate values in your code
CACHE_LINES  EQU 100
CACHE_LINE_SIZE EQU 8
OFFSET_BITS  EQU 3
TAG_BITS EQU 29 ; 32 - OFSSET_BITS

section .text
    global load
    extern printf

;; void load(char* reg, char** tags, char cache[CACHE_LINES][CACHE_LINE_SIZE], char* address, int to_replace);
load:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]  ; address of reg
    mov ebx, [ebp + 12] ; tags
    mov ecx, [ebp + 16] ; cache
    mov edx, [ebp + 20] ; address
    mov edi, [ebp + 24] ; to_replace (index of the cache line that needs to be replaced in case of a cache MISS)
    ;; DO NOT MODIFY

    ;; TODO: Implment load
    ;; FREESTYLE STARTS HERE
    ;imi pun pe stiva toate variabilele de care
    ;am nevoie pentru a elibera registrii
    push eax
    push edi
    mov eax, edx
    and eax, 7
    push eax
    mov eax, edx
    shr eax, 3

    push eax

    mov eax, 0
    mov edx, [esp]

;caut tagul adresei mele in vectorul de taguri
findTag:
	cmp eax, CACHE_LINES
	je noTag
	cmp dword [ebx + 4 * eax], edx
	je existTag
	add eax, 1
    jmp findTag



;daca exista tagul aduc contorul pe linia 
;din cache la care trebuie sa ajung
existTag:
	cmp eax, 0
	je Reg
	add ecx, 8
	sub eax, 1
	jmp existTag

;pun octetul gasit in reg
Reg:
	mov eax, [esp + 4]
	add ecx, eax
	mov eax, [esp + 12]
	mov edx, [ecx]
	mov [eax], edx

	jmp exit

;daca nu exista tagul il adaug in vectorul
;de taguri
noTag:
	mov dword [ebx + 4 * edi], edx
	shl edx, 3
	mov esi, 0

;pun octet cu octet in cache valoarea de la adresele
;pe care le-am optinut din tagul precedent
CacheReplace:
	cmp esi, 8
	je RegNoTag
	mov al, byte [edx]
	mov byte [ecx + 8 * edi], al
	add edx, 1
	add ecx, 1
	add esi, 1
	jmp CacheReplace

;adaug in reg valoarea dorita
RegNoTag:
	sub ecx, 8
	mov eax, [esp + 4]
	add ecx, eax
	mov edx, [ecx + 8 * edi]
	mov eax, [esp + 12]
	mov [eax], edx 
exit:
;eliberez stiva
pop eax
pop eax
pop eax
pop eax
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY


