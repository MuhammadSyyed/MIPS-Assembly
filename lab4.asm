.data
	x: .word 97
	Y: .word 83
.text
.globl main
.ent main
main:
	la $s0,x
	lw $t1,0($s0)

	la $s1,Y
	lw $t2,0($s1)

	mult $t1,$t1
	mflo $t3

	addi $t4,$0,5

	mult $t4,$t3
	mflo $s6	# 5x^2
	
	addi $t5,$0,7

	mult $t5,$t2
	mflo $t6	# 7y
	
	addi $t6,$t6,2
	
	div $t6,$t4
	mflo $t7	# 7y/5
	
	add $s5,$s6,$t7	# 5x^2+7y/5
	
 
 	li $v0,1
	move $a0, $s5
	syscall
	jr $ra

.end main