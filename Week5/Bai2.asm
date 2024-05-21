.data
Cau1: .asciiz "The sum of " 
Cau2: .asciiz " and " 
Cau3: .asciiz " is " 
.text
li $v0, 4
la $a0, Cau1
syscall
li $v0,1
li $s0,4
move $a0,$s0
syscall
li $v0, 4
la $a0, Cau2
syscall
li $v0,1
li $s1,5
move $a0,$s1
syscall
li $v0, 4
la $a0, Cau3
syscall
add $s0,$s0,$s1
move $a0,$s0
li $v0,1
syscall

