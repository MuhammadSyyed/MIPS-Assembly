.data
	msg1: .asciiz "Enter Your Number:"
	msg2: .asciiz "The 2's complement of your number is: "
.text
.globl main
.ent main
main:
	li $v0,4
	la $a0, msg1
	syscall

	li $v0,5
	syscall
	move $t0,$v0

	nor $t2,$t0,$0
	addi $t2,$t2,1

	li $v0,4
	la $a0,msg2
	syscall

	li $v0,1
	move $a0, $t2
	syscall
	jr $ra
	
.end main