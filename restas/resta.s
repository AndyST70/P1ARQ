.global start


start:
	MOV R0, #15
	MOV R1, #3
	
	push {R0, R1}
	BL func_rec_division
	MOV R0, R6
	pop {R0, R1}
	
	MOV R2, R1
	MOV R1, R0
	MOV R3, R6
	MOV R0, =format_res
	BL printf
	
	MOV R7, #1
	SVC 0

func_rec_division:
	MOV R2, #0
	
tail:	
	CMP R0, #0 
	BLT end
	ADD R2, R2, #1
	SUB R0, R0, R1
	B tail
end:
	MOV R0, R2
	MOV PC, LR

.data
format_res: .asciz "El resultado de %d/%d es: %d\n"