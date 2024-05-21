li $s0,10
li $s1,16 
li $s2,1
loop:
beq $s1, $s2, endloop 
sll $s0,$s0,1 #40 80
srl $s1,$s1,1 #2 
j loop # goto loop 
endloop: