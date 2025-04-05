section .data
    message1 db 'Condition met!', 0
    message2 db 'Condition not met!', 0

section .text
    global _start

_start:
    mov eax, 5           ; Load value 5 into EAX
    mov ebx, 10          ; Load value 10 into EBX

    cmp eax, ebx         ; Compare EAX and EBX
						 ; jl for jump if less, and jg for jump if greater
    jg else_label        ; Jump to "else" if EAX < EBX (signed comparison)

    ; "If" block
    mov ecx, message1    ; Load address of message1
    call print_message   ; Call procedure to print the message
    jmp end_label        ; Skip "else" block

else_label:
    ; "Else" block
    mov ecx, message2    ; Load address of message2
    call print_message   ; Call procedure to print the message

end_label:
    ; Exit program
    mov eax, 1           ; sys_exit
    xor ebx, ebx         ; Exit code 0
    int 0x80

print_message:
    mov edx, 14          ; Length of message (e.g., "Condition met!" has 14 bytes)
    mov ebx, 1           ; File descriptor for stdout
    mov eax, 4           ; sys_write system call number
    int 0x80             ; Make system call
    ret                  ; Return to caller
