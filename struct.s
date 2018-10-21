/*
struct array {
    char* word
    int used
    int size
}
12 byte size
*/

.data
hello: .asciz "Hello world!"
print: .asciz "%s, %d, %d\n"

.text
.global main
main:
    mov r0, #12
    bl malloc
    mov r4, r0 @Allocate 12 bytes and save pointer to r4
    
    ldr r0, =hello
    str r0, [r4, #0] @Store char* at 0 offset

    mov r0, #1
    str r0, [r4, #4] @Store 1 at offset +4
    
    mov r0, #10
    str r0, [r4, #8] @Store 10 at offset +8

    ldr r0, =print
    ldr r1, [r4]
    ldr r2, [r4, #4]
    ldr r3, [r4, #8]
    bl printf

    mov r0, r4
    bl free

    mov r0, #0 @return 0
    mov r7, #1 @exit is syscall 1
    swi #0 @Call it
