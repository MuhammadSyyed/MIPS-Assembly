.data
	input: .asciiz "Enter some integer: "
	odd: .asciiz "the number is odd"
	even: .asciiz "the number is even"

.text
.globl main
.ent main

main:

	li $v0,4
	la $a0,input
	syscall
	
	li $v0,5
	syscall
	move $s0,$v0

	addi $s2,$0,2
	
	div $s0,$s2
	
	mfhi $t1

	beq $t1,$0,label

	li $v0,4
	la $a0,odd
	syscall
	jr $ra
	
label:  li $v0,4
	la $a0,even
	syscall	
	jr $ra
	

.end main