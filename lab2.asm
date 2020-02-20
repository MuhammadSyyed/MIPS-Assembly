.data
     LIST:.half 7, 8, 9, 10, 11, 12, 13, 14, 15
.text
.globl main
.ent main
main:
	la $t0 , LIST
	lw $t1 , 0($t0)
	lw $t2 , 4($t0)
	lw $t3 , 8($t0)
	lw $t4 , 12($t0)
	lw $t5 , 16($t0)
	jr $ra
.end main 