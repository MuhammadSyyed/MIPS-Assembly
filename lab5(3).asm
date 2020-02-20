.data
	input: .asciiz "Enter temperature of the day: "
	plsnt: .asciiz "Pleasent weather"
	hot: .asciiz "It is hot today"
	cold: .asciiz "It is cold today"

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
	
	slti $t1,$s0,20
	beq $t1,$0,label

	li $v0,4
	la $a0,cold
	syscall
	jr $ra
	
label:  slti $t1,$s0,30
	beq $t1,$0,last
	li $v0,4
	la $a0,plsnt
	syscall	
	jr $ra
	
last:   li $v0,4
	la $a0,hot
	syscall
	jr $ra
	

.end main