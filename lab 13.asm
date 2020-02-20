.data
	value:	.asciiz "Enter 1st integer: "
	value1:	.asciiz "enter second integer: "
	value2:	.float 0.0
	msg1:	.asciiz" Your result is: "
	msg3:	.asciiz" there is an overflow"
	msg4:	.asciiz" Ther is an underflow"
.text
.globl main
.ent main
main:

	#la $t0,value
			
	lwc1 $f4,value2			#storing initial value in $f0

	#lwc1 $f1,4($t0)			#storing initial value in $f1
	#li $s7, 1
	#li $s8, 2

	li $v0,4
	la $a0,value
	syscall

	li $v0,6
	syscall

	mfc1 $s6,$f0			#transfering value of $f0 in $t1
	add.s $f1,$f0,$f4
	

	li $v0,4
	la $a0,value
	syscall

	li $v0,6
	syscall

	mfc1 $s7,$f0			#transfering value of $f1 in $t2
	add.s $f2,$f0,$f4

	c.eq.s $f1,$f4			
	bc1t display
	c.eq.s $f2,$f4		
	bc1t display
	#beq $0, $t1,zero		#checking if the initial value is zero
	#beq $0, $t2,zero		#checking if the initial value is zero

	exponent:
	srl $t3,$s6,23			#shifting right 23 times
	srl $t4,$s7,23

	andi $t3,$t3,0xFF		#anding to remove sign bit
	andi $t4,$t4,0xFF

	add $s0,$t3,$t4			#adding exponent
	addi $s1,$s0,-127		#subtracting 127 
	
	slti $t5,$s1,128		#if exponent greater than 128 report overflow 
	beq $t5,$0,overflow		
	
	slti $t6,$s1,-127		#if exponent lesser than -127 report overflow 
	bne $t6,$0,underflow

	sll $s1,$s1,23

	mantissa:
	
	li $t5,0x7FFFFF			
	li $t6,0x800000
	

	and $s2,$t5,$s6			#ANDING to get mantissa
	and $s3,$t5,$s7

	or $s2,$s2,$t6			#adding 1 to mantissa
	or $s3,$s3,$t6

	mult $s2,$s3
	mflo $s4

	and $s4,$t6,$s4

	compiling:

	li $t7,0x80000000
	
	xor $s5,$s6,$s7		#extracting sign bit
	and $s5,$s5,$t7		
	or $s6,$s5,$s1
	or $s6,$s6,$s4

	display:
	
	li $v0,4
	la $a0,msg1
	syscall
	
	add $t0,$0,$s6		#storing answer in $t0
	add $t1,$0,$0		#storing 0 in $t1
	addi $t2,$0,1		#storing 1 in $t2 for masking
	sll $t2,$t2,31
	add $t3,$0,32		#looping value

	loop:
	and $t1,$t0,$t2		#anding result with masking value
	beq $t1,$0,print	#if $t1 is 0 we will jump to print
	add $t1,$0,$0		#storing 0 in $t1
	addi $t1,$0,1		#storing 1 in $t1
	j print			#jump to print

	print:
	li $v0,1
	move $a0,$t1		
	syscall

	srl $t2,$t2,1
	addi $t3,$t3,-1
	bne $t3,$0,loop

	j exit


	#li $v0,1
	#move $a0,$s6
	#syscall
	#j exit


	overflow:
	li $v0,4
	la $a0,msg3
	syscall
	j exit

	underflow:
	li $v0,4
	la $a0,msg4
	syscall
	j exit

	exit:
	li $v0,10		#exit from the program
	syscall
.end main