.data
	input1: .asciiz "Enter the first number: "
	input2: .asciiz "Enter the second number: "
	input3: .asciiz "Enter the third number: "
	avg : .asciiz "The Average is:"
	
.text
.globl main
.ent main

main:

	li $v0,4	# inputs
	la $a0,input1
	syscall
	
	li $v0,5
	syscall
	move $t0,$v0

	
	li $v0,4
	la $a0,input2
	syscall

	li $v0,5
	syscall
	move $t1,$v0
		
	
	li $v0,4
	la $a0,input3
	syscall	

	li $v0,5
	syscall
	move $t2,$v0

	move $a0,$t0
	move $a1,$t1
	move $a2,$t2

	jal findavg
	
	add $t3,$0,$v0
	
	li $v0,4
	la $a0,avg
	syscall	
	
	li $v0,1
	move $a0,$t3
	syscall
	
	li $v0,10
	syscall

.end main

.globl findavg
.ent findavg

findavg:

	addi $sp,$sp,-16
	sw $s0,0($sp)
	sw $s1,4($sp)
	sw $s2,8($sp)
	sw $s3,12($sp)

	add $s0,$a0,$a1
	add $s1,$s0,$a2
	addi $s2,$0,3
	
	addi $s3,$s1,1
	div $s3,$s2
	
	mflo $s6
	move $v0,$s6
	
	lw $s3,12($sp)
	lw $s2,8($sp)
	lw $s1,4($sp)
	lw $s0,0($sp)


	addi $sp,$sp,16

	jr $ra
.end findavg





