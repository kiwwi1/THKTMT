.eqv KEY_CODE 0xFFFF0004 # ASCII code from keyboard, 1 byte
.eqv KEY_READY 0xFFFF0000 # =1 if has a new keycode ?
# Auto clear after lw
.eqv DISPLAY_CODE 0xFFFF000C # ASCII code to show, 1 byte
.eqv DISPLAY_READY 0xFFFF0008 # =1 if the display has already to do
# Auto clear after sw
.text
li $k0, KEY_CODE
li $k1, KEY_READY
li $s0, DISPLAY_CODE
li $s1, DISPLAY_READY
li $t3, 0
loop:
nop
WaitForKey: 
lw $t1, 0($k1) # $t1 = [$k1] = KEY_READY
beq $t1, $zero, WaitForKey # if $t1 == 0 then Polling
ReadKey: 
lw $t0, 0($k0) # $t0 = [$k0] = KEY_CODE
WaitForDis: 
lw $t2, 0($s1) # $t2 = [$s1] = DISPLAY_READY
beq $t2, $zero, WaitForDis # if $t2 == 0 then Polling 
Encrypt:
jal check_exit
jal check_uppercase
ShowKey: 
sw $t0, 0($s0) # show key
li $v0, 1
add $a0, $zero, $t3
syscall
bge $t3, 4, end_main
nop 
j loop
end_main:
li $v0, 10
syscall
check_uppercase:
bgt $t0, 90, check_lowercase
blt $t0, 65, check_number
addi $t0, $t0, 32
jr $ra 
check_lowercase:  
bgt $t0, 122, default
blt $t0, 97, default
subi $t0, $t0, 32
jr $ra
check_number:
blt $t0, 48, default
bgt $t0, 57, default
jr $ra
default:
addi $t0, $zero, 42
jr $ra
check_exit:
beq $t0, 101, check_e
beq $t0, 120, check_x
beq $t0, 105, check_i
beq $t0, 116, check_t
li $t3, 0
jr $ra
check_e:
bne $t3, 0, return
addi $t3, $t3, 1
jr $ra
check_x:
bne $t3, 1, return
addi $t3, $t3, 1
jr $ra
check_i:
bne $t3, 2, return
addi $t3, $t3, 1
jr $ra
check_t:
bne $t3, 3, return
addi $t3, $t3, 1
jr $ra
return:
li $t3, 0
jr $ra