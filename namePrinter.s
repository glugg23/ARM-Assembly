.data
inputFirstName:
    .asciz "Enter first name: "

inputLastName:
    .asciz "Enter last name: "

print:
    .asciz "Hello %s!\n"

space:
    .asciz " "

firstName:
    .skip 128 @char[128]

lastName:
    .skip 128

fullName:
    .skip 256

.text

.global main
main:
    push {lr}
    
    ldr r0, =inputFirstName
    bl printf
    
    ldr r0, =firstName
    mov r1, #128
    ldr r2, =stdin
    ldr r2, [r2]
    bl fgets

    ldr r0, =firstName
    bl strlen
    mov r4, r0 @Store result of strlen
    sub r4, r4, #1 @Find last index/length after new line is removed

    mov r0, #0x00 @'\0'
    ldr r1, =firstName
    str r0, [r1, r4] @firstName[strlen(firstName)-1] = '\0'

    ldr r0, =inputLastName
    bl printf

    ldr r0, =lastName
    mov r1, #128
    ldr r2, =stdin
    ldr r2, [r2]
    bl fgets

    ldr r0, =lastName
    bl strlen
    mov r4, r0
    sub r4, r4, #1

    mov r0, #0x00
    ldr r1, =lastName
    str r0, [r1, r4]

    ldr r0, =fullName
    ldr r1, =firstName
    bl strcpy

    ldr r0, =fullName
    ldr r1, =space
    bl strcat

    ldr r0, =fullName
    ldr r1, =lastName
    bl strcat

    ldr r0, =print
    ldr r1, =fullName
    bl printf

    pop {pc}
