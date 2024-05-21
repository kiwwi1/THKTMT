.data
x: .space 21 # destination string x, empty
y: .space 21 #source
Message1: .asciiz "Nhap 1 xau: "
Message2: .asciiz "Xau dao la: "
.text
 li $v0, 8
 la $a0, y
 la $a1, 21
 syscall
 get_length: 
 addi $t5,$t5,20
 la $a0,y # $a0 = address(string[0])
 add $t0,$zero,$zero # $t0 = i = 0
check_char: 
 add $t1,$a0,$t0 # $t1 = $a0 + $t0
 # = address(string[i]) 
 lb $t2, 0($t1) # $t2 = string[i]
 beq $t2, $zero, reverse_strcpy # is null char? 
 addi $t0, $t0, 1 # $t0 = $t0 + 1 -> i = i + 1
 bgt $t0,$t5,EXIT
 j check_char
reverse_strcpy:
la $a0,x
la $a1,y
add $s1,$zero,$zero
addi $s0,$t0,-2 # $s0 = do dai cua xau y
L1:
add $t1,$s0,$a1 # = address of y[last]
lb $t2,0($t1) # $t2 = value at $t1 = y[last]
add $t3,$s1,$a0 # $t3 = $s0 + $a0 = i + x[0] 
 # = address of x[i]
sb $t2,0($t3) # x[i]= $t2 = y[i]
beq $s0,$zero,end_of_strcpy # if y[i] == 0, exit
addi $s0,$s0,-1 # $s0 = $s0 - 1 <-> i = i - 1
addi $s1,$s1,1
j L1 # next character
end_of_strcpy:

print:
 li $v0, 59
 la $a0, Message2
 la $a1, x
 syscall 
EXIT:
