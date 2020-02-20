.data
	title: .asciiz "\t**--WELCOME TO THE SIMPLE CALCULATOR--**
	\n \t \t*MAIN MENU*
	\n \t Select 1 for Addition	\t(x+y)
	\n \t Select 2 for Subtraction\t(x-y)
	\n \t Select 3 for Multiplication\t(x*y)
	\n \t Select 4 for Division	\t(x/y)
	\nYour choice: "
	err: .asciiz "****Error: Please select the correct option..****"
	value1: .asciiz "\nEnter some integer value for x followed by enter: "
	value2: .asciiz "\nEnter some integer value for y followed by enter: "
	rslt: .asciiz  "\nResult is: "
	
.text
.globl main
.ent main

main:
	li $v0,4
	la $a0,title
	syscall
	
	li $v0,5	#input for function
	syscall
	move $t0,$v0
	
	slti $t3,$t0,1	#checking inputs other than 1 t0 4
	beq $t3,$0,other
	j next

other:	slti $t3,$t0,5
	beq $t3,$0,next
	j values
next:	li $v0,4
	la $a0,err
	syscall
	j out

values :li $v0,4	# input values for x and y 
	la $a0,value1
	syscall

	li $v0,5
	syscall
	move $t1,$v0
	
	li $v0,4
	la $a0,value2
	syscall

	li $v0,5
	syscall
	move $t2,$v0


	move $a1,$t1
	move $a2,$t2

	addi $t4,$0,1
	beq $t0,$t4,addt	
	addi $t5,$0,2
	beq $t0,$t5,subt
	addi $t6,$0,3
	beq $t0,$t6,multt
	j divis

addt: 	jal ADDT
	j print
subt:	jal SUBT
	j print
multt:	jal MULTT
	j print
divis:	jal DIVIS
	j print



print: 	move $t7,$v0

	li $v0,4
	la $a0,rslt
	syscall
	li $v0,1
	move $a0,$t7
	syscall

out:	li $v0,10
	syscall
.end main

.globl ADDT
.ent ADDT
ADDT:
	add $v0,$a1,$a2

	jr $ra
.end ADDT

.globl SUBT
.ent SUBT
SUBT:	
	sub $v0,$a1,$a2

	jr $ra
.end SUBT

.globl MULTT
.ent MULTT
MULTT:	
	mult $a1,$a2
	mflo $v0

	jr $ra
.end MULTT

.globl DIVIS
.ent DIVIS
DIVIS:
	div $a1,$a2
	mflo $v0

	jr $ra
.end DIVIS

