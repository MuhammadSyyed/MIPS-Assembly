.data
	CEP: .asciiz "Enter marks obtained in Complex Engineering Problem : "
	DLP: .asciiz "What was the difficulty level of project? "
	final: .asciiz  "CEP Marks are: "
	
.text
.globl main
.ent main

main:
	li $v0,4
	la $a0,CEP
	syscall
	
	li $v0,5
	syscall
	move $s0,$v0
	
	li $v0,4
	la $a0,DLP
	syscall

	li $v0,5
	syscall
	move $s1,$v0

	slti $s3,$s1,3 	        #($s3=1 if less than 3, otherwise 0)
	bne $s3,$0,label	#(if $s3 = 0 , means greater than 3 so goto label and add 5 then print)

	
	addi $s0,$s0,5

label:	li $v0,4
	la $a0,final
	syscall	
	
	li $v0,1
	move $a0, $s0
	syscall
	jr $ra
	

.end main