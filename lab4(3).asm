.data
	Ctemp: .word 2
	ftemp: .word 0
	res: .asciiz "The temperature in fehrenheit is: "
.text
.globl main
.ent main
main:

	la $s0,Ctemp
	la $s1,ftemp
	lw $t1,0($s0)
	
	addi $t2,$0,9

	mult $t2,$t1
	mflo $t3
	
	addi $t4,$t3,2
	
	addi $t5,$0,5
	
	div $t4,$t5
	mflo $t6
	
	addi $t7,$t6,32

	
	li $v0,4
	la $a0, res
	syscall

	li $v0,1
	move $a0,$t7
	sw $t7,0($s1)
	syscall

	jr $ra

.end main