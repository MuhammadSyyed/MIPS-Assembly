.data
	value1: .asciiz "Enter some integer value for x followed by enter: "
	value2: .asciiz "Enter some integer value for y followed by enter: "
	value3: .asciiz "Enter some integer value for z followed by enter: "
	final: .asciiz "Result of x-y+z-12 is:"
	
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
	
	li $v0,4
	la $a0,value3
	syscall

	li $v0,5
	syscall
	move $t2,$v0

	sub $t3,$t0,$t1
	addi $t4,$t2,-12
	add $t5,$t3,$t4	

	li $v0,4
	la $a0,final
	syscall

	li $v0,1
	move $a0, $t5
	syscall
	jr $ra


.end main