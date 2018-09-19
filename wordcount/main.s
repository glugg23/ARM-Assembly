.data
input: .asciz "-i"
output: .asciz "-o"
inputFilename: .skip 128 @char[128]
outputFilename: .skip 128

.text
.global main

commandFlags:
    push {fp, lr} @Save frame pointer and lr
    add r11, sp, #0 @Set bottom of stack frame
    sub sp, sp, #16 @Allocate some buffer on stack

    @TODO: Rewrite this using stack?
    mov r4, r1 @Save argv
    mov r5, r0 @Save argc
    mov r6, #0 @i = 0

    loop:
        cmp r6, r5 @If i >= argc
        bge end @End loop
    
        

        add r6, r6, #1 @i++
        b loop

    end:
    sub sp, r11, #0 @Readjust stack pointer
    pop {fp, pc} @Restore frame pointer and pop lr into pc to go back to main

main:
    bl commandFlags

    mov r0, #0 @return 0
    mov r7, #1 @exit is syscall 1
    swi #0 @Call it
