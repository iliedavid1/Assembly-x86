extern printf

section .data
	print db "number: %d", 10, 0
	printul db "nu: %d", 10, 0

section .text
	global cpu_manufact_id
	global features
	global l2_cache_info

;; void cpu_manufact_id(char *id_string);
;
;  reads the manufacturer id string from cpuid and stores it in id_string
cpu_manufact_id:
	enter 	0, 0
	push ebx
	push esi
	push edi

	mov eax, 0x0
	cpuid

	;pun in stringul final string-urile de la ebx, edx si ecx
	mov edi, [ebp + 8]
	mov [edi], ebx
	mov [edi + 4], edx
	mov [edi + 8], ecx

	pop edi
	pop esi
	pop ebx
	leave
	ret

;; void features(char *vmx, char *rdrand, char *avx)
;
;  checks whether vmx, rdrand and avx are supported by the cpu
;  if a feature is supported, 1 is written in the corresponding variable
;  0 is written otherwise
features:
	enter 	0, 0
	push ebx
	push esi
	push edi

	mov eax, 0x1
	cpuid

	mov edi, 1

	shl edi, 4
	push ecx
	and ecx, edi
	shr ecx, 4
	mov esi, [ebp + 8]
	mov [esi], ecx
	pop ecx

	mov edi, 1

	shl edi, 29
	push ecx
	and ecx, edi
	shr ecx, 29
	mov esi, [ebp + 12]
	mov [esi], ecx
	pop ecx

	mov edi, 1

	shl edi, 27
	push ecx
	and ecx, edi
	shr ecx, 27
	mov esi, [ebp + 16]
	mov [esi], ecx
	pop ecx

	pop edi
	pop esi
	pop ebx
	leave
	ret

;; void l2_cache_info(int *line_size, int *cache_size)
;
;  reads from cpuid the cache line size, and total cache size for the current
;  cpu, and stores them in the corresponding parameters
l2_cache_info:
	enter 	0, 0

	push ebx
	push esi
	push edi

	mov esi, [ebp + 8]
	mov ecx, 0
	mov eax, 0x80000006
	cpuid

	push ecx

	;iau primul octet din ecx
	and ecx, 0xff
	mov [esi], ecx

	pop ecx

	;iau ultimi doi octeti din ecx
	shr ecx, 16
	mov esi, [ebp + 12]
	mov [esi], ecx

	pop edi
	pop esi
	pop ebx
	
	leave
	ret
