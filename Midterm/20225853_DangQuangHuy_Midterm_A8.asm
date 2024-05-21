.data
prompt: .asciiz "Nhap N: "
ketqua: .asciiz "Cac so chinh phuong nho hon N la: "
space: .asciiz " "
.text
li $v0, 4
la $a0, prompt
syscall
jal read_int
 move $t0,$v0 #copy so can check $t0
 beqz $t0,end #neu so nhap la 0 thi ket thuc
 li $t1,1  #khoi tao bien dem i cua vong lap
 li $v0, 4
 la $a0, ketqua
 syscall
loop:
mul $t2,$t1,$t1 #i^2
bge $t2,$t0,end #neu i^2>n thi ket thuc
move $a0,$t2
ble $t1,$t0,print_int #neu be hon thi in ra 
addi $t1,$t1,1 #tang bien dem len 1
j loop
end:
 li $v0,10
 syscall
print_int:
        li $v0, 1               # load system call code for printing integer into $v0
        syscall                 # make system call
        li $v0, 4
        la $a0, space
        syscall 
        addi $t1,$t1,1
        j loop                 # return
read_int:
        li $v0, 5               # load system call code for reading integer into $v0
        syscall                 # make system call
        jr $ra                  # return
