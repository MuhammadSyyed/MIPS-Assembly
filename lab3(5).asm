.data
.text
.globl main
.ent main
main:
	lui $t1, 0xabcd
	ori $s0,$t1, 0xef35
	lui $t2, 0x4567
	ori $s1,$t2,0x89ab
	xor $t0,$s0,$s1
	jr $ra
.end main
  
