.data
	value: .asciiz "Enter any number:"
	range: .asciiz "Enter range:"
	multi: .asciiz "x"
	equat: .asciiz "="
	next: .asciiz "\n"
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

	li $v0,4
	la $a0, range
	syscall

	li $v0,5
	syscall
	move $t1,$v0
	addi $t1,$t1,1
	
	add $a1,$0,$t0
	add $a2,$0,$t1

	jal table
	
	li $v0, 10
	syscall

.end main

.globl table

.ent table

table:
	




	addi $s0,$0,1
loop:	slt $s1,$s0,$a2
	beq $s1,$0,out
	
	li $v0,1
	move $a0,$a1
	syscall
	
	li $v0,4
	la $a0, multi
	syscall
	
	li $v0,1
	move $a0,$s0
	syscall
	
	mult $a1,$s0
	mflo $s1

	li $v0,4
	la $a0, equat
	syscall

	li $v0,1
	move $a0,$s1
	syscall
	
	li $v0,4
	la $a0, next
	syscall
	
	addi $s0,$s0,1
	j loop

out: 	jr $ra
.end table