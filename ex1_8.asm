.data
	space: .asciiz " "
.text
	li $v0, 5 #đọc giá trị của n
	syscall
	add $s0, $zero, $v0 #$0 = n
	jal solve
	li $v0, 10
	syscall
print:
	li $v0, 1 #in ra
	add $a0, $zero, $t0 #a0 = i^2
	syscall
	li $v0, 4
	la $a0, space
	syscall 
	j continue
solve:
	li $t1, 1
	while:
		mul $t0, $t1, $t1 # t0 = i^2
		bgt $t0, $s0, done #neu i^2 > n thi done
		j print
		continue:
		addi $t1, $t1, 1 #i = i + 1
		j while
	done:
	 	jr $ra
		
		
