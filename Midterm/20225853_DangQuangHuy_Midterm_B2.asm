.data
	a: .word 10
	s: .asciiz " "
	prompt1: .asciiz "Nhap so phan tu cua mang: "
	prompt2: .asciiz "Cap phan tu co tich lon nhat la: "
	space: .asciiz " "
.text
        li $v0, 4
        la $a0, prompt1
        syscall
	li $v0, 5
	syscall
	addi $s0, $v0, 0 #n = v0 la số phần tử
	la $s1, a #s1 = a
#Nhap xau ki tu 
scan:
	li $t0, 0 # i = 0
	for:
		sll $t1, $t0, 2 #t1 = i * 4 
		add $t1, $t1, $s1 #lấy địa chỉ của A[i]
		li $v0, 5
		syscall
		addi $t2, $v0, 0 #gán số đã nhập bằng t2
		sw $t2, 0($t1) # a[i] = t2
		addi $t0, $t0, 1 #i = i + 1
		bge $t0, $s0, solve #Kiểm tra đã đủ số chưa
		j for
solve:
	li $t0, 0 # i = 0
	addi $s3, $s0, -1 #m = n - 1
	
	sll $t1, $t0, 2 #t1 = 4 * i 
	add $t1, $t1, $s1 #lấy địa chỉ của A[i]
	lw $t2, 0($t1) # a[i] = t2
	
	addi $t0, $t0, 1 #i = i + 1
	
	sll $t1, $t0, 2 #t1 = 4 * i 
	add $t1, $t1, $s1 #lấy địa chỉ của A[i]
	lw $t3, 0($t1) # a[i] = t2
	
	mul $t4, $t2, $t3 #max = a[0] * a[1]
	addi $t6, $t2, 0 #luu gia tri phan tu
	addi $t7, $t3, 0#luu gia tri phan tu
	for1:
		sll $t1, $t0, 2 #t1 = i * 4 
		add $t1, $t1, $s1 #lấy địa chỉ của A[i]
		lw $t2, 0($t1) # a[i] = t2
		
		addi $t1, $t0, 1 #t1 = i + 1
		sll $t1, $t1, 2 #t1 = 4 * i 
		add $t1, $t1, $s1 #lấy địa chỉ của A[i+1]
		lw $t3, 0($t1) # a[i+1] = t2
	
		mul $t5, $t2, $t3 # t5 = a[i] * a[i+1]
		
		bgt $t5, $t4, ganmax #neu t5 > max thi gan max = t5 
		
		addi $t0, $t0, 1 #i = i + 1
		bge $t0, $s3, done #neu doc hết số phần tử thì rẽ nhánh để giải
		j for1
	ganmax:
		addi $t4, $t5, 0 #max = t5
		addi $t6, $t2, 0 #luu gia tri phan tu
		addi $t7, $t3, 0#luu gia tri phan tu
		j for1
done:
        li $v0, 4
        la $a0, prompt2
        syscall   
	li $v0, 1
	move $a0,$t6
	syscall
	li $v0, 4
        la $a0, space
        syscall
	li $v0, 1
	move $a0,$t7
	syscall
		
		
