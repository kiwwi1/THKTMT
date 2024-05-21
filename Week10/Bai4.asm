.eqv MONITOR_SCREEN 0x10010000 #Dia chi bat dau cua bo nho man hinh 
.eqv RED 0x00FF0000 #Cac gia tri mau thuong su dung 
.eqv GREEN 0x0000FF00 
.eqv BLUE 0x000000FF 
.eqv WHITE 0x00FFFFFF 
.eqv YELLOW 0x00FFFF00 
.text 
 li $k0, MONITOR_SCREEN #Nap dia chi bat dau cua man hinh 
 addi $t1,$t1,0
 loop:
 bgtu $t1,7,end
 li $t0, RED 
 sw $t0, 0($k0) 
 nop 
 li $t0, GREEN 
 sw $t0, 4($k0) 
 nop 
 li $t0, RED 
 sw $t0, 8($k0) 
 nop 
 li $t0, GREEN 
 sw $t0, 12($k0) 
 nop 
 li $t0, RED 
 sw $t0, 16($k0) 
 nop 
 li $t0, GREEN 
 sw $t0, 20($k0) 
 nop 
 li $t0, RED 
 sw $t0, 24($k0) 
 nop 
 li $t0, GREEN 
 sw $t0, 28($k0) 
 nop 
 li $t0, GREEN 
 sw $t0, 32($k0) 
 nop 
 li $t0, RED 
 sw $t0, 36($k0) 
 nop 
 li $t0, GREEN 
 sw $t0, 40($k0) 
 nop 
 li $t0, RED 
 sw $t0, 44($k0) 
 nop 
 li $t0, GREEN 
 sw $t0, 48($k0) 
 nop 
 li $t0, RED 
 sw $t0, 52($k0) 
 nop 
 li $t0, GREEN 
 sw $t0, 56($k0) 
 nop 
   li $t0, RED 
 sw $t0, 60($k0) 
 nop 
 addi $k0,$k0,64
 j loop
 
 end :
 li $v0,10
 syscall