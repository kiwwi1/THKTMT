.data
A: .word 7, -2, 5, 1, 5,6,7,3,6,8,8,59,5
Aend: .word
.text
main: la $a0,A #$a0 = Address(A[0])
  la $a1,Aend
 addi $a1,$a1,-4 #$a1 = Address(A[n-1])
 j sort #sort
 after_sort: li $v0, 10 #exit
 syscall
end_main:
#--------------------------------------------------------------
#procedure sort (ascending selection sort using pointer)
#register usage in sort program
#$a0 pointer to the first element in unsorted part
#$a1 pointer to the last element in unsorted part
#$t0 temporary place for value of last element
#$v0 pointer to max element in unsorted part
#$v1 value of max element in unsorted part
#--------------------------------------------------------------
sort: beq $a0,$a1,done #single element list is sorted
      j max #call the max procedure
after_max: 
 lw $t0,0($a1) #load last element into $t0
 sw $t0,0($v0) #copy last element to max location
 sw $v1,0($a1) #copy max value to last element
 addi $a1,$a1,-4 #decrement pointer to last element
 j sort #repeat sort for smaller list
done:  j print_sorted_array # Chuyển đến in ra mảng đã sắp xếp

print_sorted_array:
    # In ra các phần tử của mảng đã sắp xếp
    la $t0, A            # Khởi tạo index i = 0
    la $t3,A
    la $a1,Aend
print_loop:
    beq $t0, $a1, after_sort # Nếu i == địa chỉ cuối cùng của mảng, kết thúc
    lw $t1, 0($t3)       # Load giá trị của phần tử thứ i vào $t1
    li $v0, 1            # Chuẩn bị syscall để in ra số nguyên
    move $a0, $t1        # Đưa giá trị cần in ra vào $a0
    syscall              # In ra giá trị       
    addi $t3, $t3, 4     # Di chuyển con trỏ đến phần tử tiếp theo của mảng
    addi $t0, $t0, 4     # Tăng index i lên 1
    j print_loop         # Lặp lại quá trình in


max:
addi $v0,$a0,0 #init max pointer to first element
lw $v1,0($v0) #init max value to first value
addi $t0,$a0,0 #init next pointer to first
loop:
beq $t0,$a1,ret #if next=last, return
addi $t0,$t0,4 #advance to next element
lw $t1,0($t0) #load next element into $t1
slt $t2,$t1,$v1 #(next)<(max) ?
bne $t2,$zero,loop #if (next)<(max), repeat
addi $v0,$t0,0 #next element is new max element
addi $v1,$t1,0 #next value is new max value
j loop #change completed; now repeat
ret:
j after_max
