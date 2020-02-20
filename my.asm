.data
	msg1: .asciiz "Sign bit is"
	msg2: .asciiz "\nNumber is Positive"
	msg3: .asciiz "\nTrue Number is:"
	msg4: .asciiz "\nSignificand is: 1."
	

.text
.globl main
.ent main
main:

	li $s0,0x67102104
	 

	srl $s2,$s0,31 #sign bit
	
	sll $s3,$s0,1
	srl $s3,$s3,24
	sub $s3,$s3,127

	li $v0,4
	la $a0,msg1
	syscall

	li $v0,1
	move $a0,$s2
	syscall

	bne $s2,$0,out
	li $v0,4
	la $a0,msg2
	syscall


	addi $s5,$0,1 
	li $v0,4
	la $a0,msg3
	syscall

	li $v0,1
	move $a0,$s3
	syscall

	addi $t0,$0,22

	li $v0,4
	la $a0,msg4
	syscall


out: jr $ra

.end main
