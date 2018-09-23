.data
input: .asciz "-i"
output: .asciz "-o"
inputFilename: .skip 4 @char*
outputFilename: .skip 4 @char*

print: .asciz "-i: %s\n-o: %s\n"

.text
.global main

commandFlags:
    push {fp, lr} @Save frame pointer and lr
    add fp, sp, #0 @Set bottom of stack frame
    sub sp, sp, #16 @Allocate some buffer on stack

    push {r4, r5, r6, r7} @Save the existing values to ensure we can reset program state

    mov r4, r1 @Save argv
    mov r5, r0 @Save argc
    mov r6, #0 @i = 0
    mov r7, #0 @Starting offset for argv

    loop:
        cmp r6, r5 @If i >= argc
        bge end @End loop
        
        @Find input file
        ldr r0, =input
        ldr r1, [r4, r7] @argv[i]
        bl strcmp @argv[i] == "-i"

        cmp r0, #0 @If they are equal

        @Conditionally execute next instructions to save a branch instruction
        addeq r3, r7, #4 @Increment offset to get next value of argv 
        ldreq r0, =inputFilename @Load r0 with pointer to filename
        ldreq r1, [r4, r3] @Load r1 with argv[i + 1]
        streq r1, [r0] @Store the value of r1 at *r0
        
        @Find output file
        ldr r0, =output
        ldr r1, [r4, r7] @argv[i]
        bl strcmp @argv[i] == "-o"

        cmp r0, #0 @If equal

        addeq r3, r7, #4 @Increase offset
        ldreq r0, =outputFilename
        ldreq r1, [r4, r3] @argv[i + 1]
        streq r1, [r0] @outputFilename = argv[i + 1]
        
        add r6, r6, #1 @i++
        add r7, r7, #4 @Increase offset by 4 bytes
        b loop

    end:
    pop {r4, r5, r6, r7} @Reset program state

    sub sp, fp, #0 @Readjust stack pointer
    pop {fp, pc} @Restore frame pointer and pop lr into pc to go back to main

main:
    bl commandFlags

    ldr r0, =print
    ldr r1, =inputFilename
    ldr r1, [r1]
    ldr r2, =outputFilename
    ldr r2, [r2]
    bl printf

    mov r0, #0 @return 0
    mov r7, #1 @exit is syscall 1
    swi #0 @Call it
