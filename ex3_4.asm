.data
	st: .space 256
	a: .word 1024
.text
	li $v0, 8
	la $a0, st
	li $a1, 256
	syscall
	la $s0, st
	la $s2, a #s2 tro den bang dem 
	li $t0, -1 #i = 0
	li $t3, 100000 #min = 100000
	li $s5, 10 #ki tu ket thuc xau
solve:
	
	lb $s6, 0($s0) #doc tung ki tu
	beq $s6, $s5, done # neu gap kí tự kết thúc xâu thì done
	add $s1, $s6, $zero # 
	sll $s1, $s1, 2 # s1 = s1 * 4
	add $s1, $s1, $s2 #load địa chỉ của a
	lw $t1, 0($s1) #t1 = a[s1]
	addi $t1, $t1, 1 #a[s1]++
	sw $t1, 0($s1)
	
	addi $s0, $s0, 1# i = i + 1
	j solve
	
done:
	li $t0, -4 #i =-4
	li $t1, 1024
	for:	
		bgt $t0, $t1, print #neu t0 = 1024 thi in
		addi $t0, $t0, 4 #i = i + 1
		add $t4, $t0, $s2 #load địa chỉ của s2
		lw $t2, 0($t4) #t2 = a[i]
		
		beq $t2, $zero, for
		blt  $t2, $t3, ganmin
ganmin:
	addi $t3, $t2, 0 #gan min = a[s1]
	j for
print:
	la $t0, st #i = st
	loop:
	lb $s6, 0($t0)
	
	add $s1, $s6, $zero #
	sll $s1, $s1, 2 # s1 = s1 * 4
	add $s1, $s1, $s2 #load địa chỉ của a
	lw $t1, 0($s1) #t1 = a[s1]
	
	beq $t1, $t3, end
	addi $t0, $t0, 1
	j loop
end:
	li $v0, 11
    	add $a0, $zero, $s6   # Load ký tự tương ứng
    	syscall
	
		
			
	
	
	
	
	
	
	
