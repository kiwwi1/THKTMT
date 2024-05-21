.data
    newline: .asciiz "\n"
.text
    # Hàm nhập số nguyên dương từ bàn phím
    # Đầu vào:
    #   $v0 = 5 (system call code for reading integer)
    # Đầu ra:
    #   $v0 = số nguyên nhập từ bàn phím
    #   $a0 = số nguyên nhập từ bàn phím
    # Hàm main
    main:
        # Đọc số nguyên dương N từ bàn phím
        jal read_int            # jump and link to read_int
        move $t0, $v0           # lưu giá trị N vào $t0
        li $t1, 1               # gán giá trị ban đầu là 1
        li $t2, 3               # chia hết cho 3
        li $t3, 5               # chia hết cho 5
    loop:
        # In các số chia hết cho 3 hoặc cho 5 nhỏ hơn N
        ble $t1, $t0, check     # nếu $t1 < N thì kiểm tra điều kiện
        j end_loop              # nếu không thì kết thúc vòng lặp

    check:
        div $t1,$t2
        mfhi $t4
        div $t1,$t3
        mfhi $t5
        beq $t4, $zero, print   # nếu t1 chia hết cho 3 thì in
        beq $t5, $zero, print   # nếu t1 chia hết cho 5 thì in

        addi $t1, $t1, 1        # tăng giá trị của $t1 lên 1
        j loop

    print:
        # In ra số chia hết cho 3 hoặc cho 5
        move $a0, $t1           # load $t1 into $a0
        jal print_int           # jump and link to print_int

        jal print_newline       # jump and link to print_newline

        addi $t1, $t1, 1        # tăng giá trị của $t1 lên 1
        j loop

    end_loop:
        # Kết thúc chương trình
        li $v0, 10              # load system call code for exit into $v0
        syscall                 # make system call
    read_int:
        li $v0, 5               # load system call code for reading integer into $v0
        syscall                 # make system call

        jr $ra                  # return

  
    print_int:
        li $v0, 1               # load system call code for printing integer into $v0
        syscall                 # make system call

        jr $ra                  # return
    # Hàm in newline
    print_newline:
        li $v0, 4               # load system call code for printing string into $v0
        la $a0, newline         # load address of newline into $a0
        syscall                 # make system call

        jr $ra                  # return

    
