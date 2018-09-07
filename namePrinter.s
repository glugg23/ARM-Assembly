.data
inputFirstName:
    .asciz "Enter first name: "

inputLastName:
    .asciz "Enter last name: "

print:
    .asciz "Hello %s!\n"

firstName:
    .skip 128 /* char[128] */

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
    /* Remove new line after this */ 

    ldr r0, =print
    ldr r1, =firstName
    bl printf

    pop {pc}
