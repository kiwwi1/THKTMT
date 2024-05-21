.data
    x1: .word 1      # Tọa độ x của điểm thứ nhất
    y1: .word 2      # Tọa độ y của điểm thứ nhất
    x2: .word 5      # Tọa độ x của điểm thứ hai
    y2: .word 4      # Tọa độ y của điểm thứ hai

    RED: .word 0xFF0000    # Màu đỏ
    GREEN: .word 0x00FF00  # Màu xanh lá

.text
main:
    lw $t0, x1           # Tải tọa độ x của điểm thứ nhất vào $t0
    lw $t1, y1           # Tải tọa độ y của điểm thứ nhất vào $t1
    lw $t2, x2           # Tải tọa độ x của điểm thứ hai vào $t2
    lw $t3, y2           # Tải tọa độ y của điểm thứ hai vào $t3

    # Vẽ các đường thẳng của hình chữ nhật
    # Đường thẳng đầu tiên
    # (x1, y1) -> (x2, y1)
    jal draw_line       # Gọi hàm vẽ đường thẳng
    # Đường thẳng thứ hai
    # (x1, y1) -> (x1, y2)
    jal draw_line       # Gọi hàm vẽ đường thẳng
    # Đường thẳng thứ ba
    # (x2, y1) -> (x2, y2)
    jal draw_line       # Gọi hàm vẽ đường thẳng
    # Đường thẳng thứ tư
    # (x1, y2) -> (x2, y2)
    jal draw_line       # Gọi hàm vẽ đường thẳng

    # Tô màu cho hình chữ nhật
    # Tô màu viền màu đỏ
    lw $a0, RED         # Đưa màu đỏ vào $a0
    jal fill_rectangle  # Gọi hàm tô màu cho hình chữ nhật
    # Tô màu nền màu xanh lá
    lw $a0, GREEN       # Đưa màu xanh lá vào $a0
    jal fill_rectangle  # Gọi hàm tô màu cho hình chữ nhật

    # Kết thúc chương trình
    li $v0, 10          # Sử dụng syscall 10 để thoát chương trình
    syscall

# Hàm vẽ đường thẳng từ (x1, y1) đến (x2, y2)
# $a0, $a1, $a2, $a3: Tọa độ của điểm đầu và điểm cuối
# $t0, $t1: Biến tạm thời
draw_line:
    move $t0, $a0       # Sao chép tọa độ x của điểm đầu vào $t0
    move $t1, $a1       # Sao chép tọa độ y của điểm đầu vào $t1

    # Vẽ đường thẳng từ (x1, y1) đến (x2, y2)
    loop_draw_line:
        # Vẽ điểm tại tọa độ ($t0, $t1)

        # Kiểm tra điều kiện dừng vẽ đường thẳng
        # Nếu đã vẽ đến điểm cuối thì thoát khỏi vòng lặp
        # So sánh tọa độ hiện tại với tọa độ điểm cuối
        bne $t0, $a2, continue_draw_line  # So sánh tọa độ x
        bne $t1, $a3, continue_draw_line  # So sánh tọa độ y
        j end_draw_line                     # Thoát khỏi vòng lặp nếu đã vẽ đến điểm cuối

    continue_draw_line:
        # Tính toán tọa độ tiếp theo trên đường thẳng
        # Tăng hoặc giảm tọa độ x hoặc y tùy theo hướng vẽ
        # Điều chỉnh tọa độ x và y tương ứng

        # Lặp lại quá trình vẽ cho điểm tiếp theo trên đường thẳng
        j loop_draw_line

    end_draw_line:
    jr $ra

# Hàm tô màu cho hình chữ nhật
# $a0: Màu cần tô
# $a1, $a2, $a3, $a4: Tọa độ của hình chữ nhật
fill_rectangle:
    move $t0, $a1       # Sao chép tọa độ x của điểm đầu vào $t0
    move $t1, $a2       # Sao chép tọa độ y của điểm đầu vào $t1

    # Lặp lại từng hàng của hình chữ nhật để tô màu
    loop_fill_rectangle:
        # Vẽ đường thẳng từ ($t0, $t1) đến ($a3, $t1) với màu $a0
        li $a0, 1          # Chỉ định màu đỏ cho viền
        jal draw_line      # Gọi hàm vẽ đường thẳng

        # Kiểm tra điều kiện dừng tô màu cho hàng hiện tại
        # Nếu đã tô màu cho toàn bộ chiều rộng của hình chữ nhật thì thoát khỏi vòng lặp
        bne $t0, $a3, continue_fill_rectangle

        # Điều chỉnh tọa độ y cho hàng tiếp theo của hình chữ nhật
        # Tăng $t1 lên 1 đơn vị
        addi $t1, $t1, 1

        # Lặp lại quá trình tô màu cho hàng tiếp theo của hình chữ nhật
        j loop_fill_rectangle

    continue_fill_rectangle:
        # Điều chỉnh tọa độ x cho điểm bắt đầu của hàng tiếp theo
        # Tăng $t0 lên 1 đơn vị
        addi $t0, $t0, 1

        # Lặp lại quá trình tô màu cho hình chữ nhật
        j loop_fill_rectangle

    end_fill_rectangle:
    jr $ra

