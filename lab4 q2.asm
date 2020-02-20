.data
	value1: .asciiz "Enter some integer value for x followed by enter: "
	value2: .asciiz "Enter some integer value for y followed by enter: "
	final:  .asciiz  "Quotient is: "
	final2: .asciiz "\nRemainder is: "
	
.text
.globl main
.ent main

main:
	li $v0,4
	la $a0,value1
	syscall
	
	li $v0,5
	syscall
	move $t0,$v0
	
	li $v0,4
	la $a0,value2
	syscall

	li $v0,5
	syscall
	move $t1,$v0

	div $t0, $t1
	mflo $t5
	mfhi $t6
	
	li $v0,4
	la $a0,final
	syscall	
	
	li $v0,1
	move $a0, $t5
	syscall

	li $v0,4
	la $a0,final2
	syscall	

	li $v0,1
	move $a0, $t6
	syscall
	jr $ra

.end main