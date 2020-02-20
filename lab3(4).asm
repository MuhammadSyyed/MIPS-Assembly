.data
	msg1: .asciiz "Enter any upper case alphabet:"
	msg2: .asciiz "\nYou entered:"
.text
.globl main
.ent main
main:

	li $v0, 4
	la $a0, msg1
	syscall

	li $v0, 12
	syscall
	move $t0,$v0
	
	li $v0, 4
	la $a0, msg2
	syscall

	li $v0,11
	addi $t0,$t0,32
	move $a0, $t0
	syscall

	jr $ra

.end main
  
