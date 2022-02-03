; This is your structure
struc  my_date
    .day: resw 1
    .month: resw 1
    .year: resd 1
endstruc

section .data
	age: dd 0

section .text
    global ages

; void ages(int len, struct my_date* present, struct my_date* dates, int* all_ages);
ages:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; present
    mov     edi, [ebp + 16] ; dates
    mov     ecx, [ebp + 20] ; all_ages
    ;; DO NOT MODIFY
    xchg ecx, edx
    ;iau fiecare element din dates(de la ultimul la primul)
    ;si pun in eax varsta rezultate din scaderea anului prezent
    ;si anul nasterii fiecarei persoanei din dates
lenLoop:
	mov eax, dword [esi + 4]
	sub eax, dword [edi + 8 * ecx - 4]
	;daca varsta <= 0
	cmp eax, 0
	jle addZero
	mov bx, word [esi + 2]
	sub bx, word [edi + 8 * ecx - 6]
	;verific daca este aceeasi luna
	cmp bx, 0
	je Day
	cmp bx, 0
	jg addAge
	sub eax, 1
	jmp addAge
label:
loop lenLoop
jmp exit

;daca este aceeasi luna verific daca ziua
;este mai mare sau mai mica decat cea curenta
Day:
	mov bx, word [esi]
	sub bx, word [edi + 8 * ecx - 8]
	cmp bx, 0
	jge addAge
	sub eax, 1
	jmp addAge

;adaug 0 in vectorul ages daca diferenta intre
;ani este 0 sau daca este mai mica decat 0
addZero:
	mov dword [edx + 4 * ecx - 4], 0
	jmp label

;adaug varsta in vectorul ages
addAge:
	mov [edx + 4 * ecx - 4], eax
	jmp label

exit:
    ;; TODO: Implement ages
    ;; FREESTYLE STARTS HERE

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
