.global main

.text

main:

  ; Imprime un mensaje de bienvenida
  LDR R0, =welcome_msg
  SWI 0x1

  ; Solicita al usuario que introduzca el nombre del archivo
  LDR R0, =prompt
  SWI 0x1

  ; Lee el nombre del archivo introducido por el usuario
  LDR R0, =buffer
  SWI 0x6

  ; Cierra el teclado
  LDR R0, =0
  SWI 0x67

  ; Abre el archivo
  LDR R0, =3
  LDR R1, =buffer
  LDR R2, =0
  SWI 0x66

  ; Bucle para leer el archivo
loop:

  ; Lee un byte del archivo
  LDR R0, =buffer
  LDR R1, =R4
  SWI 0x66

  ; Si el byte leído es una coma
  CMP R0, #','
  BEQ comma

  ; Si el byte leído es un salto de línea
  CMP R0, #'\n'
  BEQ eol

  ; Si no es ninguna de las dos, continuamos leyendo
  B loop

comma:

  ; Lee dos bytes más del archivo
  LDR R0, =buffer
  LDR R1, =R5
  SWI 0x66

  ; Convierte los dos bytes en un número entero
  LDR R1, =R5
  LDR R0, [R1]
  LDR R1, =R4
  LDR R2, [R1]
  ADD R0, R0, R2

  ; Empila el número en el stack
  LDR R1, =stack
  STR R0, [R1], #4

  ; Incrementa el tamaño del stack
  ADD R4, R4, #4

  ; Continuamos leyendo
  B loop

eol:

  ; Despilla los números del stack
  LDR R1, =stack
loop2:
  LDR R0, [R1], #4
  SWI 0x1
  CMP R1, #0
  BNE loop2

  ; Cierra el archivo
  LDR R0, =archivo ; Dirección del archivo
  SWI 0x67

  ; Termina el programa
  SWI 0x1

.data

welcome_msg: .asciz "Bienvenido al programa de lectura de archivos.\n"
prompt: .asciz "Introduzca el nombre del archivo: "
archivo: .word 0
buffer: .space 100
stack: .space 100
