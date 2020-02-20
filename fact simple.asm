.data
	input: .asciiz "Enter the number: "
	rslt: .asciiz "Result is:"
	err : .asciiz "neg Error"
	msg : .asciiz "fact is 1"
	
.text
.globl main
.ent main

main:
	li $v0,4
	la $a0,input
	syscall
	
	li $v0,5
	addi $t0,$0,1	# initialization
	syscall
	move $t1,$v0
	
	slti $t2,$t1,0
	beq $t2,$0,label
	
	li $v0,4
	la $a0,err
	syscall
	j out

label: 	beq $t1,$0,one
	move $a0,$t1
	move $a1,$t0
	jal fact
	
	add $t3,$0,$v0

	li $v0,4
	la $a0,rslt
	syscall

	li $v0,1
	move $a0,$t3
	syscall
	j out
	

one: 	li $v0,4
	la $a0,msg
	syscall
	j out

out :	li $v0,10
	syscall
.end main

.globl fact	
.ent fact

fact:
	addi $sp,$sp,-4
	sw $s0 , 0($sp)


loop:	slt $s0,$0,$a0
	beq $s0,$0,result
	mult $a0,$a1
	mflo $a1
	addi $a0,$a0,-1
	j loop

result:	move $v0,$a1
	
	lw $s0 , 0($sp)
	addi $sp,$sp,4
	jr $ra

.end fact