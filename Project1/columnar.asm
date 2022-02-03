section .data
    extern len_cheie, len_haystack

section .text
    global columnar_transposition

;; void columnar_transposition(int key[], char *haystack, char *ciphertext);
columnar_transposition:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha 

    mov edi, [ebp + 8]   ;key
    mov esi, [ebp + 12]  ;haystack
    mov ebx, [ebp + 16]  ;ciphertext
    ;; DO NOT MODIFY

    ;; TODO: Implment columnar_transposition
    ;; FREESTYLE STARTS HERE
    mov ecx, 0
    mov eax, 0
    add eax, [edi]
    jmp keyLoop
;iau fiecare element din vectorul key
;si il pun in eax
begin:
    add ecx, 1
    mov eax, 0
    add eax, [edi + 4 * ecx]

;verific daca am trecut prin tot vectorul key
keyLoop:
    mov edx, [len_cheie]
    cmp ecx, edx
    je exit
    jmp haystackLoop

;pun octetul care corespunde matricei haystack
;in ciphertext
haystackLoop:
    mov edx, [len_haystack]
    cmp eax, edx
    jge begin
    mov edx, 0
    mov dl, byte [esi + eax]
    mov byte [ebx], dl
    add ebx, 1
    mov edx, [len_cheie]
    add eax, edx
    jmp haystackLoop 

exit:
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY