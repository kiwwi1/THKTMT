.data
ketqua: .asciiz "Tong cac chu so nhi phan la: "
.text
jal read_int
move $t0,$v0 # luu gia tri cua N vao t0
li $t1,2
# $s0: luu tong can tinh
loop:
beq $t0,$zero,endloop
div $t0,$t1
mflo $t0 #ket qua sau khi chia 2
mfhi $t2 #phan du 
add $s0,$t2,$s0
j loop
endloop:
 li $v0, 4
 la $a0, ketqua
 syscall
move $a0,$s0
jal print_int
li $v0,10
syscall

print_int:
        li $v0, 1               # load system call code for printing integer into $v0
        syscall                 # make system call
        jr $ra                  # return
read_int:
        li $v0, 5               # load system call code for reading integer into $v0
        syscall                 # make system call
        jr $ra                  # return
