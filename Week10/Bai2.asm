.eqv SEVENSEG_LEFT 0xFFFF0011 # Dia chi cua den led 7 doan trai. 
 # Bit 0 = doan a; 
 # Bit 1 = doan b; ... 
 # Bit 7 = dau . 
.eqv SEVENSEG_RIGHT 0xFFFF0010 # Dia chi cua den led 7 doan phai
.data
prompt: .asciiz "Nhap 1 so nguyen duong: "
led_patterns: .word 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F  
.text
li $t4,10
li $v0, 4
la $a0, prompt
syscall
    jal read_int
    move $t0,$v0
    div $t0,$t4
    mfhi $t3
    div $t0,$t4
    mflo $s0
    div $s0,$t4
    mfhi $s1
    sll $t3,$t3,2
    la $t2, led_patterns # Địa chỉ của mảng led_patterns
    add $t2, $t2, $t3    # Tính địa chỉ của mẫu LED tương ứng
    lw $t1, 0($t2)       # Load mẫu LED vào $t1
    move $a0, $t1 # set value for segments 
    jal SHOW_7SEG_RIGHT # show 
    nop 
    # Lấy chữ số hàng chục
    sll $s1,$s1,2
    la $t2, led_patterns # Địa chỉ của mảng led_patterns
    add $t2, $t2, $s1    # Tính địa chỉ của mẫu LED tương ứng
    lw $t1, 0($t2)       # Load mẫu LED vào $t1
    move $a0, $t1 # set value for segments 
 jal SHOW_7SEG_LEFT # show 
 nop

exit: li $v0, 10 
 syscall 
endmain: 
#--------------------------------------------------------------- 
# Function SHOW_7SEG_LEFT : turn on/off the 7seg 
# param[in] $a0 value to shown 
# remark $t0 changed 
#--------------------------------------------------------------- 
SHOW_7SEG_LEFT: li $t0, SEVENSEG_LEFT # assign port's address 
 sb $a0, 0($t0) # assign new value 
 nop 
 jr $ra 
 nop 
 
#--------------------------------------------------------------- 
# Function SHOW_7SEG_RIGHT : turn on/off the 7seg 
# param[in] $a0 value to shown 
# remark $t0 changed 
#--------------------------------------------------------------- 
SHOW_7SEG_RIGHT: li $t0, SEVENSEG_RIGHT # assign port's address 
 sb $a0, 0($t0) # assign new value 
 nop 
 jr $ra 
 nop 
 read_int:
  li $v0, 5               # load system call code for reading integer into $v0
  syscall                 # make system call
  jr $ra  