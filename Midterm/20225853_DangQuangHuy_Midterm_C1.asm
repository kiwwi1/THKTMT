.data
prompt: .asciiz "Nhap xau ki tu: "
not_symmetric_msg: .asciiz "Xau khong doi xung."
symmetric_msg: .asciiz "Xau doi xung."
newline: .asciiz "\n"
input_buffer: .space 256
.text
main:
    # In prompt để nhập xâu ký tự
    li $v0, 4
    la $a0, prompt
    syscall

    # Đọc xâu ký tự từ người dùng
    li $v0, 8
    la $a0, input_buffer
    li $a1, 256  # Độ dài tối đa của xâu là 255 ký tự, và 1 ký tự cuối cùng là ký tự kết thúc chuỗi
    syscall

    # Thiết lập con trỏ để duyệt xâu
    la $t0, input_buffer      # $t0 lưu địa chỉ bắt đầu của xâu
    jal strlen                # Gọi hàm strlen để tính độ dài của xâu

    # Lưu độ dài của xâu vào $t2
    move $t2, $v0

    # Lặp qua xâu để kiểm tra tính đối xứng
    li $t3, 0                  # $t3 là con trỏ bắt đầu từ đầu xâu
    addi $t4,$t2,-1             # $t4 lưu độ dài của xâu - 1 (index của ký tự cuối cùng trong xâu)
    add $t1,$t0,$t2
    addi $t1,$t1,-2
    li $t5, 1                  # $t5 dùng để kiểm tra hoàn tất việc kiểm tra đối xứng

    check_symmetry_loop:
        bge $t3, $t4, done_checking  # Nếu con trỏ bắt đầu vượt quá con trỏ kết thúc, kết thúc vòng lặp
        lb $t6, 0($t0)         # Load ký tự đầu tiên
        lb $t7, 0($t1)         # Load ký tự cuối cùng
        beq $t6, $t7, continue_checking  # Nếu ký tự tương ứng là giống nhau, tiếp tục kiểm tra
        j not_symmetric        # Nếu ký tự không giống nhau, xâu không đối xứng

    continue_checking:
        addi $t0, $t0, 1      # Di chuyển con trỏ bắt đầu sang phải
        addi $t1, $t1, -1      # Di chuyển con trỏ kết thúc sang trái
        addi $t3, $t3, 1      # Tăng con trỏ bắt đầu lên
        addi $t4, $t4, -1     # Giảm con trỏ kết thúc xuống
        j check_symmetry_loop  # Lặp lại vòng lặp

    done_checking:
    # Nếu vòng lặp hoàn tất mà không gặp phải lỗi, xâu là đối xứng
    j symmetric

    # Xử lý kết quả khi xâu không đối xứng
    not_symmetric:
    li $v0, 4
    la $a0, not_symmetric_msg
    syscall
    j end_program

    # Xử lý kết quả khi xâu đối xứng
    symmetric:
    li $v0, 4
    la $a0, symmetric_msg
    syscall
    j end_program

    # Kết thúc chương trình
    end_program:
    li $v0, 10
    syscall

# Hàm tính độ dài của xâu
strlen:
    move $v0, $a1         # Đặt kết quả ban đầu bằng độ dài tối đa cho phép
    move $t0, $a0         # $t0 lưu địa chỉ bắt đầu của xâu
    li $t1, 0             # Khởi tạo đếm độ dài xâu
strlen_loop:
    lb $t2, 0($t0)       # Load ký tự tại vị trí hiện tại
    beqz $t2, strlen_end  # Nếu gặp ký tự kết thúc chuỗi, kết thúc vòng lặp
    addi $t0, $t0, 1      # Di chuyển con trỏ sang phải
    addi $t1, $t1, 1      # Tăng biến đếm
    j strlen_loop         # Lặp lại vòng lặp
strlen_end:
    move $v0, $t1         # Lưu kết quả vào $v0
    la $t0,input_buffer
    jr $ra                # Trả về


