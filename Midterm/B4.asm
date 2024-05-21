.data
prompt: .asciiz "Nhập số phần tử của mảng: "
space: .asciiz " "
sorted_array: .asciiz "\nMảng sau khi sắp xếp các phần tử dương tăng dần: "
array: .space 100

.text
main:
    # In prompt để nhập số phần tử của mảng
    li $v0, 4
    la $a0, prompt
    syscall

    # Đọc số phần tử của mảng từ người dùng
    li $v0, 5
    syscall
    move $s0, $v0   # Lưu số phần tử vào $s0
    li $t0, 4       # Kích thước của mỗi phần tử là 4 bytes

    # Tính toán địa chỉ của phần tử cuối cùng trong mảng
    mul $t1, $s0, $t0   # Tính số byte cần cho mảng
    la $s1, array
    add $s2, $s1, $t1   # Lưu địa chỉ phần tử cuối cùng vào $s2

    # Nhập mảng từ người dùng
    la $t3, array       # $t3 là con trỏ đến phần tử đang nhập
    loop_input:
        # Kiểm tra xem đã nhập đủ số phần tử chưa
        beq $s0, $zero, sort_positive

        # Đọc phần tử từ người dùng
        li $v0, 5
        syscall
        sw $v0, 0($t3)      # Lưu phần tử vào mảng
        addi $t3, $t3, 4    # Di chuyển con trỏ mảng đến phần tử tiếp theo
        addi $s0, $s0, -1   # Giảm số phần tử còn lại của mảng đi 1
        j loop_input

    # Sắp xếp các phần tử dương tăng dần
    sort_positive:
    la $t3, array      # $t3 là con trỏ đến phần tử đầu tiên trong mảng
    loop_outer:
      bge $t3,$s2,endloop
        lw $t4, 0($t3)  # Load phần tử hiện tại vào $t4
        bltz $t4, skip_swap   # Bỏ qua nếu phần tử là số âm

        la $t5, 0($t3)  # $t5 lưu địa chỉ của phần tử hiện tại
        move $t6, $t3   # $t6 lưu địa chỉ của phần tử nhỏ nhất tìm được

        la $t7, 0($t3)  # $t7 lưu địa chỉ của phần tử tiếp theo
        addi $t7, $t7, 4    # Di chuyển con trỏ mảng đến phần tử tiếp theo

        loop_find_min:
            bge $t7, $s2, swap_min  # Kết thúc nếu đã duyệt hết mảng
            lw $s0, 0($t7)  # Load phần tử tiếp theo vào $t8
            bltz $s0, skip_check_min   # Bỏ qua nếu phần tử tiếp theo là số âm
            bgt $s0, $t4, set_min     # Nếu phần tử tiếp theo nhỏ hơn phần tử nhỏ nhất hiện tại
            addi $t7, $t7, 4    # Di chuyển con trỏ mảng đến phần tử tiếp theo
            j loop_find_min
        skip_check_min:
        addi $t7,$t7,4
        j loop_find_min

        set_min:
        move $t6, $t7   # Lưu địa chỉ của phần tử nhỏ nhất hiện tại
        addi $t7, $t7, 4    # Di chuyển con trỏ mảng đến phần tử tiếp theo
        j loop_find_min

        swap_min:
        lw $s1, 0($t3)  # Load phần tử hiện tại vào $t9
        lw $s3, 0($t6) # Load phần tử nhỏ nhất vào $t10
        sw $s3, 0($t3) # Đổi chỗ phần tử hiện tại với phần tử nhỏ nhất
        sw $s1, 0($t6)

        skip_swap:
        addi $t3, $t3, 4    # Di chuyển con trỏ mảng đến phần tử tiếp theo
        j loop_outer

    # In ra mảng sau khi sắp xếp các phần tử dương tăng dần
    endloop:
    li $v0, 4
    la $a0, sorted_array
    syscall

    la $t3, array      # $t3 là con trỏ đến phần tử đầu tiên trong mảng
    loop_print:
        bge $t3, $s2, end_print   # Kết thúc nếu đã in hết mảng

        lw $a0, 0($t3)     # Load phần tử vào $a0 để in ra
        li $v0, 1
        syscall

        li $v0, 4
        la $a0, space
        syscall

        addi $t3, $t3, 4    # Di chuyển con trỏ mảng đến phần tử tiếp theo
        j loop_print

    end_print:
    # Kết thúc chương trình
    li $v0, 10
    syscall
