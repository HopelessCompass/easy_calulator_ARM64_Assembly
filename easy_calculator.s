.data
first_txt:
    .ascii "Hello!\nEnter first number\n"
second_txt:
    .ascii "Enter second number\n"
action_txt:
    .ascii "Enter you action (+,-)\n"
action_plus:
    .ascii "+"
action_minus:
    .ascii "-"
input:
    .space 256
output:
    .space 256
num1:
    .quad 0

.text
.p2align 2
.global _start

_start:

//greetings message
mov x0, #1
adrp x1, first_txt@PAGE
add x1, x1, first_txt@PAGEOFF
mov x2, #26
mov x16, #4
svc #0x80

//input read
mov x0, #0
adrp x1, input@PAGE
add x1, x1, input@PAGEOFF
mov x2, #256
bl _read
