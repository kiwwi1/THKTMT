.data
    prompt_m: .asciiz "Nhập số nguyên dương M: "
    prompt_n: .asciiz "Nhập số nguyên dương N: "
    prompt_length: .asciiz "Nhập độ dài của mảng: "
    array_elements: .asciiz "Nhập phần tử thứ "
    newline: .asciiz "\n"
    result: .asciiz "So phan tu thuoc doan M N la : "
.text
 main:
        # Nhập số nguyên dương M
        la $a0, prompt_m        # Load địa chỉ của chuỗi yêu cầu nhập số M vào $a0
        jal print_string        # Gọi hàm in chuỗi
        jal read_int            # Gọi hàm nhập số nguyên
        move $s0, $v0           # Lưu giá trị của M vào $s0

        # Nhập số nguyên dương N
        la $a0, prompt_n        # Load địa chỉ của chuỗi yêu cầu nhập số N vào $a0
        jal print_string        # Gọi hàm in chuỗi
        jal read_int            # Gọi hàm nhập số nguyên
        move $s1, $v0           # Lưu giá trị của N vào $s1

        # Nhập độ dài của mảng
        la $a0, prompt_length   # Load địa chỉ của chuỗi yêu cầu nhập độ dài mảng vào $a0
        jal print_string        # Gọi hàm in chuỗi
        jal read_int            # Gọi hàm nhập số nguyên
        move $s2, $v0           # Lưu giá trị của độ dài mảng vào $s2

        # Khởi tạo biến đếm số phần tử trong đoạn (M, N)
        li $s3, 0               # Khởi tạo biến đếm bằng 0

        # Nhập mảng số nguyên từ bàn phím
        li $t0, 0               # Khởi tạo chỉ số mảng bằng 0
        input:
        blt $t0, $s2, continue_input_array # Nếu chỉ số mảng nhỏ hơn độ dài mảng, tiếp tục nhập
            j end_input_array   # Nếu không, kết thúc nhập mảng

        continue_input_array:
            
            addi $t0, $t0, 1        # Tăng chỉ số mảng lên 1 để tương ứng với chỉ số phần tử
            jal read_int            # Gọi hàm nhập số nguyên
            move $t1, $v0           # Lưu giá trị của phần tử vào $t1

            # Kiểm tra xem phần tử có nằm trong đoạn (M, N) không
            blt $t1, $s0, not_in_range # Nếu phần tử lớn hơn M, tiếp tục kiểm tra
            ble $t1, $s1, in_range     # Nếu phần tử nhỏ hơn hoặc bằng N, tăng biến đếm lên 1
            j not_in_range             # Nếu không, tiếp tục kiểm tra phần tử tiếp theo

        in_range:
            addi $s3, $s3, 1        # Tăng biến đếm lên 1 nếu phần tử nằm trong đoạn (M, N)
            j input  # Tiếp tục nhập phần tử tiếp theo của mảng

        not_in_range:
            j input  # Tiếp tục nhập phần tử tiếp theo của mảng

        end_input_array:
        # In ra số phần tử của mảng nằm trong đoạn (M, N)
        la $a0, result           # Load địa chỉ của chuỗi thông báo vào $a0
        jal print_string         # Gọi hàm in chuỗi
        move $a0, $s3            # Load số phần tử nằm trong đoạn (M, N) vào $a0
        jal print_int            # Gọi hàm in số nguyên
        jal print_newline        # In newline

        # Kết thúc chương trình
        li $v0, 10               # Load mã hệ thống cho việc thoát chương trình vào $v0
        syscall                  # Gọi hàm thoát chương trình
    read_int:
        li $v0, 5               # load system call code for reading integer into $v0
        syscall                 # make system call
        jr $ra                  # return

    # Hàm in chuỗi
    # Đầu vào:
    #   $a0 = địa chỉ của chuỗi cần in
    print_string:
        li $v0, 4               # load system call code for printing string into $v0
        syscall                 # make system call
        jr $ra                  # return

    # Hàm in số nguyên
    # Đầu vào:
    #   $a0 = số nguyên cần in
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

    # Hàm main
   
