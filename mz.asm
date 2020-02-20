.data
          msg: .asciiz" what function do you want to choose: /n 1.addition /n 2.subtraction:"
          value1: .word -70
          value2: .word 60
          over: .asciiz"OVERFLOW"
          under: .asciiz"UNDERFLOW"
          zero: .asciiz"The answer is zero"
          sign: .asciiz"sign:"
          exponent: .asciiz"exponent:"
          significand: .asciiz"significand:"	
.text
.globl main
.ent main
main: 
       la $t0,value1    # x
       lw $t0,0($t0)      
       la $t1,value2        # y
       lw $t1,0($t1) 
       li $v0,4
       la $a0,msg
       syscall
       li $v0,5
       syscall
       move $t3,$v0


       addi $t4,$0,1         #selection of addition
       addi $t5,$0,2        #selection of subtraction
       add $a1,$t0,$0
       add $a2,$t1,$0
       bne $t3,$t4,subt
       jal ADD
       syscall
       li $v0,10                #EXIT
       syscall
       jr $ra
.end main
subt:
       bne $t3,$t5,EXIT
       jal SUB
EXIT:
       li $v0,10                #EXIT
       syscall
       jr $ra
.end main

.text
.globl SUB
.ent SUB
SUB:
       nor $a2,$a2,$0           # complement of   y
       addi $a2,$a2,1            # 2's complement of y
       beq $a1,$0,PRINTx        # condition for x whether it is 0 or not
       beq $a2,$0,PRINTy       # condition for y whether it is 0 or not
       srl $t8,$a1,23            #x
       andi $t8,$t8,0xff
       addi $t8,$t8,-127     #biased exponent
       srl $t9,$a2,23          #y
       andi $t9,$t9,0xff     
       addi $t9,$t9,-127    #biased exponent
       addi $s3,$0,0
       lui $s3,0x7f
       ori $s3,$s3,0xffff
       and $s3,$a1,$s3
       addi $s3,$s3,1            #significand x
       addi $s4,$0,0
       lui $s4,0x7f
       ori $s4,$s4,0xffff
       and $s4,$a2,$s4
       addi $s4,$s4,1          #significand y
looping:
       beq  $t8,$t9,ADSIGNED    #if equal then add
       slt $t7,$t9,$t8                     #checking for increment
       beq $t7,$0,increment
       addi $t9,$t9,1
       srl $s4,$s4,1
       beq $s3,$0,Z
       beq $s4,$0,Z2
       j looping
increment:
       
       beq $t8,$t9,ADSIGNED
       addi $t8,$t8,1
       srl $s3,$s3,1
       beq $s3,$0,Zx                             #significand x is equal to 0 or not
       beq $s4,$0,Zy                           #significand  y is equal to 0 or not 
      j loop
Zx:
     li $v0,1
     move $a0,$s4
     syscall 
     j OUT
Zy:
     li $v0,1
     move $a0,$s3
     syscall
Z:
     li $v0,1
     move $a0,$s4
     syscall
     j OUT
Z2:
     li $v0,1
     move $a0,$s3
     syscall
     j OUT

      
ADSIGNED:
      add $s5,$s4,$s3                  # add x+y
      blez $s5,zeros                     # if sum=0 then goto zero
      srl $s0,$a1,31                      # extract sign bit of x
      andi $s0,$s0,1
      bne $s0,$0,forx
      srl $s1,$a2,31                    #extract sign bit of y
      andi $s1,$s1,1
      bne $s1,$0,fory
      addi $s1,$s1,0
      srl $s2,$s5,24                   #extract sign bit of result(add)
      andi $s2,$s2,1
      bne $s2,$0,nos
      addi $s2,$s2,0
checking:
      beq $s0,$s1,check            #checking sign bit x and y is equal or not
      j OUT
forx:
      not $s0,$0
      srl $s0,$s0,31
      andi $s0,$s0,1
      addi $s0,$s0,0
fory:
       not $s1,$0
       srl $s1,$s1,31
      andi $s1,$s1,1
nos:
       not $s2,$0
      srl $s2,$s2,31
      andi $s2,$s2,1                       #extract sign bit of sum of significand
      j checking
check:
      beq $s0,$s2,equal               #check sign bit of operand equal with the sign or result or not
      srl $s5,$s5,1                          #not then shift result right
      addi $t9,$t9,1
      addi $s6,$0,127
      beq $t9,$s6,overflows         #check whether the exponent is overflow or not
      j OUT
equal:
       addi $s7,$0,1                   #normalization  checking
       addi $t6,$s5,0
backing:
       slt $t2,$t6,$s7
       beq $t2,$s7,Result
       sll $t6,$t6,1                 #shift left  significand
       addi $t9,$t9,-1
       addi $t7,$0,-127
       beq $t7,$t9,underflows
       j backing
Result:
       li $v0,4
       la $a0,sign
       syscall
       li $v0,1
       move $a0,$s2
       syscall


       li $v0,4
       la $a0,exponent
       syscall
       li $v0,1
       move $a0,$t9
       syscall


       li $v0,4
       la $a0,significand
       syscall
       li $v0,1
       move $a0,$t6
       syscall
       j OUT
overflows:
        li $v0,4
        la $a0,over
        syscall  
        j OUT  
underflows:
        li $v0,4
        la $a0,under
        syscall  
        j OUT                     
zeros:
       li $v0,4
       la $a0,zero      #z=0
       syscall
       j OUT
PRINTx:
       li $v0,1
       move $a0,$a2    #print y
       syscall
       j OUT
      
PRINTy:
       li $v0,1
       move $a0,$a1    #print x
       syscall
OUT:
        jr $ra
.end SUB
.text
.globl ADD
.ent ADD
ADD:
       beq $a1,$0,OUTs     # condition for x whether it is 0 or not
       beq $a2,$0,PRINTs   # condition for y whether it is 0 or not
       srl $t8,$a1,23            #x
       andi $t8,$t8,0xff
       addi $t8,$t8,-127     #biased exponent
       srl $t9,$a2,23          #y
       andi $t9,$t9,0xff     
       addi $t9,$t9,-127    #biased exponent
       lui $s3,0x7f
       ori $s3,$s3,0xffff
       and $s3,$a1,$s3
       addi $s3,$s3,1
       addi $s4,$0,0
       lui $s4,0x7f
       ori $s4,$s4,0xffff
       and $s4,$a2,$s4
       addi $s4,$s4,1
loop:
       beq  $t8,$t9,ADSIGNEDs
       slt $t7,$t9,$t8
       beq $t7,$0,incremen
       addi $t9, $t9, 1
       srl $s4,$s4,1       
       beq $s3,$0,zeroxs                            #significand x is equal to 0 or not
       beq $s4,$0,zeroys                          #significand  y is equal to 0 or not 
       j loop
incremen:
       addi $t8,$t8,1
       srl $s3,$s3,1
       beq $s3,$0,zerox                             #significand x is equal to 0 or not
       beq $s4,$0,zeroy                           #significand  y is equal to 0 or not 
       j loop
zerox:
     li $v0,1
     move $a0,$s4
     syscall 
     j OUT
zeroy:
     li $v0,1
     move $a0,$s3
     syscall
     j OUT
zeroxs:
     li $v0,1
     move $a0,$s4
     syscall 
     j OUT
zeroys:
     li $v0,1
     move $a0,$s3
     syscall
     j OUT


ADSIGNEDs: 
        add $s5,$s4,$s3   #add significand x+y
        blez $s5,zer       # if sum=0 then goto zero
      srl $s0,$a1,31                      # extract sign bit of x
      andi $s0,$s0,1
      bne $s0,$0,x
      srl $s1,$a2,31                    #extract sign bit of y
      andi $s1,$s1,1
      bne $s1,$0,y
      addi $s1,$s1,0
      srl $s2,$s5,24                   #extract sign bit of result(add)
      andi $s2,$s2,1
      bne $s2,$0,invert
      addi $s2,$s2,0
checkings:
      beq $s0,$s1,checks            #checking sign bit x and y is equal or not
      j OUT

x:
      not $s0,$0
      srl $s0,$s0,31                
      andi $s0,$s0,1
      addi $s0,$s0,0
y:
       not $s1,$0
       srl $s1,$s1,31
      andi $s1,$s1,1
invert:
       not $s2,$0
      srl $s2,$s2,31
      andi $s2,$s2,1                       #extract sign bit of sum of significand
      j checkings
checks:
      beq $s0,$s2,equals              #check sign bit of operand equal with the sign or result or not
      srl $s5,$s5,1                          #not then shift result right
      addi $t9,$t9,1
      addi $s6,$0,127
      beq $t9,$s6,overflow         #check whether the exponent is overflow or not
      j OUT
equals:
       addi $s7,$0,1                   #normalization  checking
       addi $t6,$s5,0
backs:
       slt $t2,$t6,$s7
       beq $t2,$s7,Results
       sll $t6,$t6,1                 #shift left  significand
       addi $t9,$t9,-1
       addi $t7,$0,-127
       beq $t7,$t9,underflow
       j backs
Results:
       li $v0,4
       la $a0,sign
       syscall
       li $v0,1
       move $a0,$s2
       syscall


       li $v0,4
       la $a0,exponent
       syscall
       li $v0,1
       move $a0,$t9
       syscall


       li $v0,4
       la $a0,significand
       syscall
       li $v0,1
       move $a0,$t6
       syscall
       j OUT
overflow:
        li $v0,4
        la $a0,over
        syscall  
        j OUT  
underflow:
        li $v0,4
        la $a0,under
        syscall  
        j OUT                     

        j OUT
zer:
       li $v0,4
       la $a0,zero  #z=0
       syscall
       j OUT

OUTs:
       li $v0,1
       move $a0,$a2   #print y
       syscall 

       jr $ra
PRINTs:
       li $v0,1
       move $a0,$a1   #print 
       syscall
       jr $ra
.end ADD
      
       