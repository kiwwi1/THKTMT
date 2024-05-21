.data
prompt:         .asciiz "Nhập xâu ký tự: "
unique_chars:   .asciiz "Các ký tự khác nhau trong xâu là: "
newline:        .asciiz "\n"
char_flags: .space 256
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

    # In ra các ký tự khác nhau trong xâu
    li $v0, 4
    la $a0, unique_chars
    syscall

    # Gọi hàm để in ra các ký tự khác nhau trong xâu
    la $a0, input_buffer
    jal print_unique_chars

    # Xuống dòng
    li $v0, 4
    la $a0, newline
    syscall

    # Kết thúc chương trình
    li $v0, 10
    syscall

# Hàm để in ra các ký tự khác nhau trong xâu
# Đầu vào:
#   $a0: Địa chỉ của xâu ký tự
print_unique_chars:
    # Khởi tạo bảng đánh dấu các ký tự đã in ra
    li $t7, 256          # $t7 lưu số lượng ký tự ASCII (256)
    la $s0, char_flags   # $t8 là con trỏ đến bảng đánh dấu

    # Khởi tạo con trỏ duyệt từng ký tự trong xâu
    move $s1, $a0        # $t9 là con trỏ duyệt từng ký tự trong xâu

    # Duyệt qua từng ký tự trong xâu để in ra các ký tự khác nhau
print_loop:
    lb $t0, ($s1)       # Load ký tự hiện tại từ xâu
    beqz $t0, print_end # Nếu gặp ký tự kết thúc chuỗi, kết thúc vòng lặp
    lb $t1, ($s0)       # Load giá trị đánh dấu cho ký tự hiện tại từ bảng đánh dấu
    beqz $t1, print_char # Nếu ký tự chưa được in ra, in ra và đánh dấu đã in ra
    addiu $s1, $s1, 1   # Di chuyển con trỏ sang phải
    j print_loop        # Lặp lại vòng lặp

print_char:
    li $v0, 11          # Load system call code để in ra một ký tự
    move $a0, $t0       # Load ký tự cần in ra
    syscall
    sb $t0, ($s0)       # Đánh dấu ký tự đã được in ra trong bảng đánh dấu
    addiu $s1, $s1, 1   # Di chuyển con trỏ sang phải
    j print_loop        # Lặp lại vòng lặp

print_end:
    jr $ra              # Trả về

# Bảng đánh dấu các ký tự đã in ra (tối đa 256 ký tự ASCII)


# Buffer để lưu xâu ký tự nhập vào từ bàn phím

