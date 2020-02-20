.data
	input: .asciiz "Enter the number: "
	rslt: .asciiz "Result is:"
	
.text
.globl main
.ent main

main:

	li $v0,4
	la $a0,input
	syscall
	
	li $v0,5
	syscall
	move $s0,$v0
	
	addi $s2,$2,0	# sum = $s2

	addi $s1,$0,1	# var 'i' $s1

loop:	slt $t1,$s1,$s0
	beq $t1,$0,label
	add $s2,$s2,$s1 # sum= sum+i
	addi $s1,$s1,1	# i = i+1
	j loop

label:	li $v0,4
	la $a0,rslt
	syscall

	li $v0,1
	move $a0,$s2
	syscall	

jr $ra

.end main