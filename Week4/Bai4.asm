li $s1,-100
li $s2,50
addu $s3,$s1,$s2
xor $t0,$s1,$s2
bltz $t0,NOTOVERFLOW
xor $t2,$s3,$s1
bgez $t2,NOTOVERFLOW
OVERFLOW:
li $t1,1
j EXIT
NOTOVERFLOW:
li $t1,0
EXIT:

