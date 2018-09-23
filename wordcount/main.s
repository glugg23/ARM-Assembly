.data
input: .asciz "-i"
output: .asciz "-o"
inputFilename: .skip 4 @char*
outputFilename: .skip 4 @char*

print: .asciz "%p: %s\n"

.text
.global main

commandFlags:
    push {fp, lr} @Save frame pointer and lr
    add fp, sp, #0 @Set bottom of stack frame
    sub sp, sp, #16 @Allocate some buffer on stack

    push {r4, r5, r6} @Save the existing values to ensure we can reset program state

    mov r4, r1 @Save argv
    mov r5, r0 @Save argc
    mov r6, #0 @i = 0

    loop:
        cmp r6, r5 @If i >= argc
        bge end @End loop
    
        mov r3, #4
        mul r3, r6, r3 @Offset for argv
        push {r3} @Call to strcmp clears r3 so save this value
                
        ldr r0, =input
        ldr r1, [r4, r3] @argv[i]
        bl strcmp @argv[i] == "-i"

        cmp r0, #0 @If they are equal
        pop {r3}
        add r3, r3, #4 @Increment offset to get next value of argv
        
        @Conditionally execute next instructions to save a branch instruction
        ldreq r0, =inputFilename @Load r0 with pointer to filename
        ldreq r1, [r4, r3] @Load r1 with argv[i]
        streq r1, [r0] @Store the value of r1 at *r0

        add r6, r6, #1 @i++
        b loop

    end:
    pop {r4, r5, r6} @Reset program state

    sub sp, fp, #0 @Readjust stack pointer
    pop {fp, pc} @Restore frame pointer and pop lr into pc to go back to main

main:
    bl commandFlags

    ldr r0, =print
    ldr r1, =inputFilename
    ldr r2, [r1]
    bl printf

    mov r0, #0 @return 0
    mov r7, #1 @exit is syscall 1
    swi #0 @Call it
