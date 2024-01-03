.global main
main:
LDR R0, =filename @ open read file
MOV R1, #0
MOV R2, #0      @ read all bytes
MOV R7, #5
SVC 0

LDR R1, =bufferascii @ read file
MOV R2, #20      @ read all bytes
MOV R7, #3
svc 0

MOV R7, #6 @ close file
SVC 0

LDR R4, =bufferascii @ print buffer
MOV R5, #0
MOV R6, #10

loop: @ byte by byte
LDRB R0, [R4], #1
CMP R0, #0 @ end string
BEQ end
CMP R0, #10 @ enter ascii
BEQ enter
SUB R0, R0, #48 @ convert ascii
MUL R1, R5, R6 @ to integer
ADD R5, R0, R1
B loop

enter:
LDR R0, =pattern @ print integer
MOV R1, R5
BL printf
MOV R5, #0      @ reset R5 after newline
B loop

end:
MOV R0, #0
MOV R7, #1 @ b exit
SVC 0

.data

filename: .asciz "test01.txt"
pattern: .asciz "num: %d \n"
bufferascii: .asciz
