; indicates the start of the data section
section .data
	; hello: label or variable name
	; db (define byte): the value. it declares a sequence of bytes in memory
	; ,0: null terminator. marks the end of the string
    hello db 'Welcome to Advanced Computer Architecture',0

; When combined with the section .data section you provided earlier, 
; the text section handles the instructions (logic) of the program, 
; while the data section manages static variables and constants.
; The text section is where executable code resides, including instructions that the CPU will run
section .text
	; This declares _start as a global label, making it accessible to the linker
	; (which is responsible for combining multiple object files into a single executable or library).
    global _start

_start:
    mov edx, 41 ; set EDX value to 41 bytes
    mov ecx, hello ; load the memory address of the hello label
    mov ebx, 1 ; load EBX with stdout file descriptor, when set to 2 load with stderr
    mov eax, 4 ; load EAX with sys_write sytem call
    int 0x80 ; triggers the kernel to handle the system call in this case display hello value

    mov eax, 1 ; load EAX with sys_exit sytem call
    xor ebx, ebx ; A value of 0 in EBX signifies the exit status cod
    int 0x80 ; triggers the kernel to handle the system call in this case exit