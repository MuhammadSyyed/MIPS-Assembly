.data

	x: .word 0x67102104
	n: .asciiz "Number is "
	s: .asciiz "\nSign bit is "
	e: .asciiz "\nTrue Exponent is "
	g: .asciiz "\nSignificant is 1."
	p: .asciiz "Positive"
	t: .asciiz "Negative"
	

.text
.globl main
.ent main
main:

	la $t0, x		#loading the value in Hex
	lw $t1, 0($t0)

	srl $t4, $t1, 31	#Extracting Sign
	
	srl $t0, $t1, 23	#Extracting Exponent
	andi $t2, $t0, 0xff
	addi $t3, $t2, -127

	lui $t0, 0x7f		#Extracting Fraction part
	li $t5, 0xffff
	or $t7, $t0, $t5
	and $t6, $t1, $t7

	
	beq $t4, $0, Pos	#checking whether sign is positive or negative
				
	li $v0, 4		#For Negative Number
	la $a0, n 
	syscall

	li $v0, 4
	la $a0, t 
	syscall

	li $v0, 4
	la $a0, s 
	syscall

	li $v0, 1
	move $a0, $t4
	syscall

	j Exp


	Pos:	li $v0, 4	#For Positive Number
		la $a0, n 
		syscall

		li $v0, 4
		la $a0, p 
		syscall

		li $v0, 4
		la $a0, s 
		syscall

		li $v0, 1
		move $a0, $t4
		syscall

	Exp:	li $v0, 4
		la $a0, e 
		syscall

		li $v0, 1
		move $a0, $t3
		syscall

		li $v0, 4
		la $a0, g
		syscall



	bin:	add $s0, $0, $t6	#saving value of fraction part
		addi $s1, $0, 1		#for masking
		add $s2, $0, $0		#initializing
		sll $s3, $s1, 22	#shift to get bit of fraction part in sequence
		addi $s4, $0, 23	#looping value

	loop:	and $s2, $s0, $s3
		beq $s2, $0, print
		add $s2, $0, $0
		addi $s2, $0, 1
		j print

	print:	li $v0, 1
		move $a0, $s2
		syscall

	srl $s3, $s3, 1
	addi $s4, $s4, -1
	bne $s4, $0, loop
	

	Exit:	li $v0, 10
		syscall

.end main

	