.data
	input: .asciiz "Enter the number: "
	prime: .asciiz "Prime"
	comp : .asciiz "Composite"
	
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
	
	addi $s1,$0,0 	#counter count = 0 counts number of exact division
	addi $s2,$0,2	# i = 2 

loop:	slt $s4,$s2,$s0
	beq $s4,$0,exit
	div $s0,$s2	#dividing
	mfhi $s5	#remainder
	bne $s5,$0,ad
	addi $s1,$s1,1	#updating counter
ad:	addi $s2,$s2,1	#updating loop counter
	j loop
exit :	
	beq $s1,$0,pri
	li $v0,4
	la $a0,comp
	syscall
	j out
pri:	li $v0,4
	la $a0,prime
	syscall
out:	jr $ra

.end main