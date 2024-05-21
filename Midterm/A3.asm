.data
    space: .asciiz " "
.text
main:
li $v0, 5               # load system call code for reading integer into $v0
syscall                 # make system call
move $a0,$v0      #s1 luu so thu 1
li $v0,5
syscall
move $a1,$v0     #s2 luu so thu 2
is_prime:
        # Nếu số là 1 hoặc 0, không phải là số nguyên tố
        li $t0, 1               # Gán giá trị 1 vào $t0
        beq $a0, $t0, not_prime # Nếu số là 1 thì không phải là số nguyên tố
        li $t0, 0               # Gán giá trị 0 vào $t0
        beq $a0, $t0, not_prime # Nếu số là 0 thì không phải là số nguyên tố

        # Lặp từ 2 đến căn bậc hai của số cần kiểm tra
        li $t0,2               # Gán giá trị 2 vào $t0
        loop:
           sqrt.s $t1,$a0
            bge $t0, $t1, end_loop # Nếu bình phương của $t0 lớn hơn hoặc bằng số cần kiểm tra, kết thúc vòng lặp
            div $a0, $t0        # Chia số cần kiểm tra cho $t0
            mfhi $t2            # Lưu phần dư vào $t2
            beq $t2, $zero, not_prime # Nếu phần dư bằng 0, số không phải là số nguyên tố
            addi $t0, $t0, 1    # Tăng $t0 lên 1
            j loop              # Lặp lại vòng lặp

       end_loop:
        li $v0, 1               # Nếu thoát vòng lặp, số là số nguyên tố
        jr $ra                  # Trả về

    not_prime:
        li $v0, 0               # Nếu số không là số nguyên tố
        jr $ra                  # Trả về

    # Hàm in tất cả các số nguyên tố trong đoạn từ M đến N
    # Đầu vào:
    #   $a0 = M
    #   $a1 = N
    print_primes_in_range:
        move $t0, $a0           # Lưu giá trị của M vào $t0
        loop:
            beq $t0, $a1, end_loop # Nếu $t0 = N, kết thúc vòng lặp
            jal is_prime        # Kiểm tra xem $t0 có phải là số nguyên tố không
            beq $v0, $zero, next_number # Nếu không phải số nguyên tố, chuyển sang số tiếp theo
            move $a0, $t0       # Nếu là số nguyên tố, in số đó
            jal print_int       # Gọi hàm in số nguyên
            jal print_newline   # In newline
            next_number:
            addi $t0, $t0, 1    # Tăng $t0 lên 1
            j loop              # Lặp lại vòng lặp

        end_loop:
        jr $ra                  # Trả về
        next_number:
        





print_int:
        li $v0, 1               # load system call code for printing integer into $v0
        syscall                 # make system call

        jr $ra                  # return
print_newline:
        li $v0, 4               # load system call code for printing string into $v0
        la $a0, space         # load address of newline into $a0
        syscall                 # make system call

        jr $ra                  # return
