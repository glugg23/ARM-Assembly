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
