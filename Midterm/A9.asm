.data
sochan: .asciiz "Tong cac so chan la :"
sole: .asciiz "Tong cac so le la: "
newline: .asciiz "\n"
.text
# $s0: tong chan $s1: tong le $t2: luu phan du
li $t1,10
li $t3,2
jal read_int
move $t0,$v0
loop:
beq $t0,$zero,end
div $t0,$t1
mfhi $t2
mflo $t0
div $t2,$t3
mfhi $t4
beq $t4,$zero,lasochan
add $s1,$s1,$t2
j loop
lasochan:
add $s0,$s0,$t2
j loop
end:
 li $v0, 4
 la $a0, sochan
 syscall
move $a0,$s0
jal print_int
jal print_newline
li $v0, 4
 la $a0, sole
 syscall
move $a0,$s1
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
print_newline:
        li $v0, 4               # load system call code for printing string into $v0
        la $a0, newline         # load address of newline into $a0
        syscall                 # make system call

        jr $ra                  # return