.data
	msg1: .asciiz "Enter number: "
	msg2: .asciiz "\nFactorial is 1"
	msg3: .asciiz "\nFactorial is: "
	msg4: .asciiz "\nEnter positive number: "
.text
.globl main
.ent main

main:
	li $v0,4
	la $a0,msg1
	syscall
	
INPUT:	li $v0,5	#input
	addi $t1,$0,1
	syscall
	move $t0,$v0
	move $a0,$t0

	beq $a0,$0,ZERO	# checking zero
	slti $t2,$a0,0
	bne $t2,$0,NEG
	add $a0,$t0,$0
	move $a1,$t1	

	jal FACT

	move $t4,$v0		
	li $v0,4
	la $a0,msg3
	syscall
	
	li $v0,1
	move $a0,$t4
	syscall
	
	li $v0,10
	syscall
	j out
ZERO:	li $v0,4
	la $a0,msg2
	syscall
	j OUT

NEG:	li $v0,4
	la $a0,msg4
	syscall
	j INPUT

OUT:	jr $ra


.end main

.text
.globl FACT
.ent FACT
FACT:
	addi $sp,$sp,-4
	sw $s0 , 0($sp)


loop:	slt $s0,$0,$a0
	beq $s0,$0,result
	mult $a0,$a1
	mflo $a1
	addi $a0,$a0,-1
	j loop

result:	move $v0,$a1
	
	lw $s0 , 0($sp)
	addi $sp,$sp,4
	jr $ra
.end FACT
