section .text
    global rotp

;; void rotp(char *ciphertext, char *plaintext, char *key, int len);
rotp:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]  ; ciphertext
    mov     esi, [ebp + 12] ; plaintext
    mov     edi, [ebp + 16] ; key
    mov     ecx, [ebp + 20] ; len
    ;; DO NOT MODIFY

    ;; TODO: Implment rotp
    ;; FREESTYLE STARTS HERE

    ;imi iau registrul ebx ca fiind un contor pentru
    ;a adauga in ciphertext la adresa corecta
    mov ebx, 0
    ;iau fiecare byte din plaintext la rand
    ;si din key invers, dupa care le fac xor si pun
    ;rezultatul in ciphertext
ciphertext:
 	mov al, byte [esi + ebx]
 	mov ah, byte [edi + ecx - 1]
 	xor al, ah
 	mov byte [edx + ebx], al
 	add ebx, 1
 loop ciphertext

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY