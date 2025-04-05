; .text: Contains executable code (instructions).
; .data: Contains initialized global and static variables.
; .rodata: Stores read-only data like constants and strings.
; .bss: Declares uninitialized variables.
section .text
   global _start

_start:
   mov ecx,10           ; Initialize the loop counter (10 iterations)
   mov eax, '1'         ; Set EAX to the ASCII value of '1' to start printing from '1'
    
l1:
   mov [num], eax       ; Store the current value of EAX (ASCII of the number) into the variable 'num'
   mov eax, 4           
   mov ebx, 1           
   push ecx             ; Save the loop counter on the stack before modifying ECX
    
   mov ecx, num         ; Set ECX to the address of 'num' (the character to be printed)
   mov edx, 1           ; Set the number of bytes to write (1 = one character)
   int 0x80             ; Call the kernel to execute sys_write and print the character
    
   mov eax, [num]       ; Reload the current ASCII value from 'num' into EAX
   sub eax, '0'         ; Convert ASCII to the numeric value (e.g., '1' -> 1)
   inc eax              ; Increment the numeric value by 1 (e.g., 1 -> 2)
   add eax, '0'         ; Convert the numeric value back to ASCII (e.g., 2 -> '2')
   pop ecx              ; Restore the loop counter from the stack
   loop l1              ; Decrement the loop counter (ECX) and jump to l1 if ECX != 0
    
   mov eax,1            ; Set up the sys_exit system call (1 = exit)
   int 0x80
   
section .bss
    num resb 1            ; Declare a 1-byte space in memory to store the ASCII value