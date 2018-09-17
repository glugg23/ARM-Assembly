.data
output:
    .asciz "%d = %s\n"

.text
.global main
main:
    push {lr}

    @argc is at r0
    @argv is at r1
    mov r4, r0 @Save argc
    mov r5, r1 @Save argv
    mov r6, #0 @Use r6 as loop variable 

    loop:
    cmp r6, r4
    bge end

    ldr r0, =output
    mov r1, r6 @move i

    mov r7, #4 @Move pointer size into r7
    mul r7, r6, r7 @Get current offset for argv, assume 4 byte pointer

    mov r2, r5
    ldr r2, [r2, r7]
    bl printf

    add r6, r6, #1 
    b loop

    end:
    mov r0, #0
    pop {pc}
