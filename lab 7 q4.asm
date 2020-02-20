.data
	msg1: .asciiz "Enter number: "
	msg2: .asciiz "\nFactorial is 1  "
	msg3: .asciiz "\nFactorial is "
	msg4: .asciiz "\nEnter positive number: "
.text
.globl main
main:
INPUT:	li $v0,4
	la $a0,msg1
	syscall

	li $v0, 5         #input integer   
     	syscall
     	move $t0, $v0
	
	move $a0,$t0

	jal FACTORIAL

	add $t4,$v0,$0

	li $v0, 1 
	move $a0,$t4
	syscall

	li $v0, 10
	syscall
.end main

.text
.globl FACTORIAL
.ent FACTORIAL
FACTORIAL:
	addi $sp,$sp,-8
	sw $s0, 0($sp)
	sw $s1, 4($sp)

	beq $a0,$0,ZERO	

	blez $a0,NEG

	addi $s0,$s0,1		# i=1
	addi $s1,$s1,1
	addi $a0,$a0,1

BACK:	slt $t2,$s0,$a0		
	beq $t2,$0,FACT		

	mult $s1,$s0
	mflo $s1

	addi $s0,$s0,1
	j BACK

ZERO:	li $v0,4
	la $a0,msg2
	syscall
	j OUT

NEG:	li $v0,4
	la $a0,msg4
	syscall
	j INPUT

FACT:	li $v0,4
	la $a0,msg3
	syscall
	
OUT:	move $v0,$s1
	lw $s0,0($sp)
	lw $s1,4($sp)
	addi $sp,$sp,8

	jr $ra
.end FACTORIAL

