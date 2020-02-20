.data
	value: .asciiz "Enter any number:"
	space: .asciiz "\n"
.text

.globl main

.ent main

main:
	li $v0,4
	la $a0, value
	syscall

	li $v0,5
	syscall
	move $t0,$v0
	addi $t0,$t0,-1
	addi $t5,$0,0
	addi $t3,$0,1
	
	addi $t2,$0,1
	li $v0,1
	move $a0,$t5
	syscall
	
	li $v0,4
	la $a0, space
	syscall
	li $v0,1
	move $a0,$t3
	syscall
	
	li $v0,4
	la $a0, space
	syscall
	
	
loop:	slt $t1,$t2,$t0
	beq $t1,$0,out
 	add $t4,$t3,$t5

	li $v0,1
	move $a0,$t4
	syscall
	
	li $v0,4
	la $a0, space
	syscall

	move $t5,$t3
	move $t3,$t4
	addi $t2,$t2,1
	j loop

out:	jr $ra

.end main

