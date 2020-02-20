.data
	input1: .asciiz "Enter the number: "
	input2: .asciiz "Enter the power: "
	rslt : .asciiz "The Result is:"
	
.text
.globl main
.ent main

main:

	li $v0,4	# inputs
	la $a0,input1
	syscall
	
	li $v0,5	#base number
	syscall
	move $t0,$v0

	
	li $v0,4
	la $a0,input2
	syscall

	li $v0,5	#power
	syscall
	move $t1,$v0

	move $a0,$t0
	move $a1,$t1
	jal power
	
	add $t2,$0,$v0
	
	li $v0,4
	la $a0,rslt
	syscall	
	
	li $v0,1
	move $a0,$t2
	syscall
	
	li $v0,10
	syscall

.end main

.globl power
.ent power

power:

	addi $sp,$sp,-12
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)

	addi $s0,$0,0	#loop counter
	addi $s1,$0,1	#product init

loop:	slt $s2,$s0,$a1
	beq $s2,$0,exit
	mult $a0,$s1
	mflo $s1
	addi $s0,$s0,1
	j loop

exit:	move $v0,$s1
	
	lw $s2, 8($sp)
	lw $s1, 4($sp)
	lw $s0, 0($sp)

	addi $sp,$sp,12
	jr $ra
.end power





