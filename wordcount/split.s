.text
splitString:
    push {fp, lr} @Save frame pointer and lr
    add fp, sp, #0 @Set bottom of stack frame
    sub sp, sp, #16 @Allocate some buffer on stack

    push {r4, r5}
    mov r4, r0 @Save file
    mov r5, r1 @Save array

    pop {r4, r5}

    sub sp, fp, #0 @Readjust stack pointer
    pop {fp, pc} @Restore frame pointer and pop lr into pc
