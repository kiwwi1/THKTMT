.data
prompt:         .asciiz "Nhập số phần tử của mảng: "
array_prompt:   .asciiz "Nhập phần tử thứ "
result:         .asciiz "\nCặp phần tử liền kề có tích lớn nhất là: "
space:          .asciiz " "
array:          .space 100
max_pair:       .space 8

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

    # Nhảy tới nhập mảng
    j input_array

input_array:
    # Lặp để nhập mảng từ bàn phím
    li $t0, 0         # Khởi tạo biến đếm $t0 = 0
    la $t1, array     # Lưu địa chỉ bắt đầu của mảng vào $t1

input_loop:
    # In prompt để nhập phần tử thứ i
    li $v0, 4
    la $a0, array_prompt
    syscall

    # In số thứ tự của phần tử
    move $a0, $t0
    li $v0, 1
    syscall

    # In chuỗi ": "
    li $v0, 4
    la $a0, space
    syscall

    # Đọc phần tử từ người dùng
    li $v0, 5
    syscall
    sw $v0, ($t1)    # Lưu phần tử vào mảng

    # Di chuyển con trỏ đến phần tử tiếp theo
    addi $t0, $t0, 1    # Tăng biến đếm lên 1
    addi $t1, $t1, 4    # Di chuyển con trỏ đến phần tử tiếp theo

    # Kiểm tra xem đã nhập đủ số phần tử chưa
    bne $t0, $s0, input_loop

    # Sau khi nhập xong mảng, gọi hàm để tìm cặp phần tử liền kề có tích lớn nhất
    jal find_max_pair

    # In kết quả
    li $v0, 4
    la $a0, result
    syscall

    # In phần tử đầu của cặp
    lw $a0, 0(max_pair)
    li $v0, 1
    syscall

    # In chuỗi " * "
    li $v0, 4
    la $a0, space
    syscall

    # In phần tử thứ hai của cặp
    lw $a0, 4(max_pair)
    li $v0, 1
    syscall

    # Kết thúc chương trình
    li $v0, 10
    syscall

# Hàm để tìm cặp phần tử liền kề có tích lớn nhất
find_max_pair:
    li $t0, 0         # Khởi tạo biến đếm $t0 = 0
    la $t1, array     # Lưu địa chỉ bắt đầu của mảng vào $t1
    li $t2, 0         # Khởi tạo biến lưu tích lớn nhất $t2 = 0
    li $t3, 0         # Khởi tạo biến lưu vị trí phần tử 1 trong cặp $t3 = 0
    li $t4, 0         # Khởi tạo biến lưu vị trí phần tử 2 trong cặp $t4 = 0

find_loop:
    # Kiểm tra xem đã duyệt hết mảng chưa
    bge $t0, $s0, end_find_loop

    # Tính tích của cặp phần tử liền kề hiện tại
    lw $t5, ($t1)          # Phần tử đầu của cặp
    lw $t6, 4($t1)         # Phần tử thứ hai của cặp
    mul $t7, $t5, $t6      # Tích của cặp
    bgt $t7, $t2, update_max_pair # Nếu tích lớn hơn tích hiện tại, cập nhật
    addi $t0, $t0, 1       # Tăng biến đếm lên 1
    addi $t1, $t1, 4       # Di chuyển con trỏ đến phần tử tiếp theo trong mảng
    j find_loop

update_max_pair:
    move $t2, $t7          # Cập nhật tích lớn nhất
    move $t3, $t5          # Cập nhật giá trị phần tử 1 trong cặp
    move $t4, $t6          # Cập nhật giá trị phần tử 2 trong cặp
    addi $t0, $t0, 1       # Tăng biến đếm lên 1
    addi $t1, $t1, 4       # Di chuyển con trỏ đến phần tử tiếp theo trong mảng
    j find_loop

end_find_loop:
    # Lưu cặp phần tử liền kề có tích lớn nhất vào max_pair
    sw $t3, max_pair
    sw $
