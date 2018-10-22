/*
struct WordArray {
    Word* array
    int used
    int size
    int totalWords
}
sizeof(WordArray) = 16 bytes

struct Word {
    char* word
    int count
}
sizeof(Word) = 8 bytes
*/

.cpu cortex-a53
.text

@input: int size for memory allocation
@output: pointer to struct
createArray:
    push {fp, lr} @Save frame pointer and lr
    add fp, sp, #0 @Set bottom of stack frame
    sub sp, sp, #16 @Allocate some buffer on stack

    push {r4, r5} @Save non-volatile registers
    
    mov r4, r0 @Save size for array alocation

    mov r0, #16
    bl malloc @Allocate 16 bytes

    mov r5, r0 @Save this bit of memory
   
    mov r0, r4
    mov r1, #8
    mul r0, r0, r1 @sizeof(Word) * size of array
    bl malloc @Allocate memory for array
    str r0, [r5] @Store this at &struct+0

    mov r0, #0
    str r0, [r5, #4] @Save 0 as used amount at &struct+4
    str r0, [r5, #12] @Store 0 as well at &struct+12 for total word count

    str r4, [r5, #8] @Store capacity at &struct+8
   
    mov r0, r5 @Return struct
    
    pop {r4, r5} @Reset registers

    sub sp, fp, #0 @Readjust stack pointer
    pop {fp, pc} @Restore frame pointer and pop lr into pc


@TODO Test this function
@input: WordArray and a Word to be inserted into it
insertArray:
    push {fp, lr} @Save frame pointer and lr
    add fp, sp, #0 @Set bottom of stack frame
    sub sp, sp, #16 @Allocate some buffer on stack

    push {r4, r5}

    mov r4, r0 @Save WordArray
    mov r5, r1 @Save Word

    ldr r0, [r4, #4] @Load used
    ldr r1, [r4, #8] @Load size
    cmp r0, r1 @Check if they are equal

    moveq r2, #2
    muleq r1, r1, r2
    streq r1, [r4, #8] @Increase size by 2

    moveq r2, #8 @Size of Word
    muleq r1, r1, r2 @Work out bytes to allocate
    ldreq r0, [r4] @Load array into r0
    bleq realloc @Call realloc

    ldr r0, [r4] @Load array
    ldr r1, [r4, #4] @Store index to insert at

    mov r2, #8
    mul r2, r1, r2 @Calculate byte offset

    str r5, [r0, r2] @Store Word at WordArray[i]
    
    add r1, r1, #1 @Increase used number by 1
    str r1, [r4, #4] @Store this value back again

    pop {r4, r5}

    sub sp, fp, #0 @Readjust stack pointer
    pop {fp, pc} @Restore frame pointer and pop lr into pc


@input: WordArray to be destroyed
freeArray:
    push {fp, lr} @Save frame pointer and lr
    add fp, sp, #0 @Set bottom of stack frame
    sub sp, sp, #16 @Allocate some buffer on stack

    push {r4, r5}

    mov r4, r0 @Save struct

    @TODO Add loop here to free each char* in Word struct in array
    
    ldr r0, [r4]
    bl free @Free the array

    mov r0, r4
    bl free @Free the struct

    pop {r4, r5}

    sub sp, fp, #0 @Readjust stack pointer
    pop {fp, pc} @Restore frame pointer and pop lr into pc
