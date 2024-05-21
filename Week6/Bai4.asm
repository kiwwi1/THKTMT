.data
A: .word 12, 11, 13, 5, 6
Aend: .word
.text
main:
la $a1,Aend
la $a0, A # $a2 = Address(A[0]) (i = 0)
addi $t0, $zero, 0 #initialize index i in $t0 to 0

j sort
nop 
after_sort:
li $v0, 10 # exit syscall
syscall
end_main:
sort:
bgt $a0, $a1, done # stop after getting to the last element (i > n-1)
nop
add $t0, $zero, $a0 # $t0 = Address(A[j]) (j = i)
loop:
beq $t0, $a2, endloop # stop after getting to the first element (j = 0)
nop
addi $t1, $t0, -4 # $t1 = Address(A[j-1])
lw $s0, 0($t0) # load array[j] into $s0
lw $s1, 0($t1) # load array[j-1] into $s1
ble $s1, $s0, endloop # stop if A[j-1] <= A[j]
nop
sw $s1, 0($t0) # store array[j-1] into array[j]
sw $s0, 0($t1) # store array[j] into array[j-1]
addi $t0, $t0, -4 # decrement j (j--)
j loop
endloop:
add $t3, $zero, $a0 # $t3 = $a0
print:
la $s0, A
printloop:
li $v0, 1
lw $a0, 0($s0) #load A[i] into $a0
syscall
addi $s0, $s0, 4 #advance to next element
bgt $s0, $a1, endprint #stop after printing the last element
nop

j printloop
nop
endprintloop:

endprint:
add $a0, $zero, $t3 # set $a0 to most recent i
addi $a0, $a0, 4 # increment pointer (i++)
j sort
nop
done:
j after_sort
nop