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
	move $s0,$v0
	
	
	slti $t2,$s0,0
	beq $t2,$0,label
	
	li $v0,4
	la $a0,err
	syscall
	jr $ra
	
label: 	beq $s0,$0,one
	j final
one: 	li $v0,4
	la $a0,msg
	syscall
	jr $ra
	

final:	slt $s6,$0,$s0
	beq $s6,$0,result
	mult $s0,$t0
	mflo $t0
	addi $s0,$s0,-1
	j final



result: li $v0,4
	la $a0,rslt
	syscall

	li $v0,1
	move $a0,$t0
	syscall
	jr $ra




.end main