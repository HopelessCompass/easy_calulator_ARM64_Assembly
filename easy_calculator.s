.data
first_txt:
    .ascii "Hello!\nEnter first number\n"
second_txt:
    .ascii "Enter second number\n"
action_txt:
    .ascii "Enter you action (+,-)\n"
exit_txt:
    .ascii "Bye!\n"
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
svc #0x80

//preparation for converting atoi
adrp x0, input@PAGE
add x0, x0, input@PAGEOFF
mov x5, #0
mov x10, x10

//parse loop cycle from ASCII to number
atoi:
ldrb w3, [x0]

cmp w3, #'0'
b.lt atoi_done
cmp w3, #'9'
b.gt atoi_done

sub w3, w3, #'0'
uxtw x3, w3
madd x5, x5, x10, x3
add x0, x0, #1
b atoi

//done parsing and storing ready number
atoi_done:
adrp x11, num1@PAGE
add x11, x11, num1@PAGEOFF
str x5, [x11]

//say goodbye and quit
exit:
mov x0, #1
adrp x1, exit_txt@PAGE
add x1, x1, exit_txt@PAGEOFF
mov x2, #5
mov x16, #4
svc #0x80
//quit
mov x0, #0
mov x16, #1
svc #0x80

//сделать проверку на недопустимые значения.
//В данный момент нет проверки на отрицаельное значение
//и недопустимые символы.
