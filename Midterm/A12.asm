.data
ketqua: .asciiz "Chu so lon nhat cua N la: "
.text

jal read_int
move $t0,$v0 #luu N vao t0
li $t1,10
div $t0,$t1
mfhi $t2 #luu chu so cuoi cung vao t2
mflo $t0
loop:
beq $t0,$zero,endloop
div $t0,$t1
mfhi $t3 #luu tung chu so vao t3
mflo $t0
ble $t3,$t2,loop #neu t3>= t2 thi xet chu so tiep theo
move $t2,$t3 #neu be hon update t2
j loop
endloop:
 
 move $a0,$t2
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
