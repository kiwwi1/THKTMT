.data
    space: .asciiz " "
.text
main:
li $v0, 5               # load system call code for reading integer into $v0
syscall                 # make system call
move $a0,$v0
move $s1,$v0
li $t0,1
li $t1,1
loop:
ble $t0,$s1,printfb
j endfb
printfb:
move $a0,$t0
jal print_int
jal print_newline
add $t2,$t0,$t1
move $t0,$t1
move $t1,$t2
j loop
endfb:
li $v0,10
syscall
print_int:
        li $v0, 1               # load system call code for printing integer into $v0
        syscall                 # make system call

        jr $ra                  # return
print_newline:
        li $v0, 4               # load system call code for printing string into $v0
        la $a0, space         # load address of newline into $a0
        syscall                 # make system call

        jr $ra                  # return
