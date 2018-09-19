.data
print:
    .asciz "argc=%d, argv[1]=%s\n"

.text
.global main

commandFlags:
    push {r11, lr} @Save frame pointer and lr
    add r11, sp, #0 @Set bottom of stack frame
    sub sp, sp, #16 @Allocate some buffer on stack

    mov r2, r1
    ldr r2, [r2]
    mov r1, r0
    ldr r0, =print
    bl printf

    sub sp, r11, #0 @Readjust stack pointer
    pop {r11, pc} @Restore frame pointer and pop lr into pc to go back to main

main:
    bl commandFlags

    mov r0, #0 @return 0
    mov r7, #1 @exit is syscall 1
    swi #0 @Call it
