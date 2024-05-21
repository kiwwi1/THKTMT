.data
array: .word 1, -5, 3, -7, 2, -4, 6, -8, 9, -1
size: .word 10

.text
main:
    la $t0, array     # Load the base address of the array
    lw $t1, size      # Load the size of the array
    li $t2, 0         # Initialize the maximum absolute value to 0
    li $t3, 0         # Initialize the index of the maximum absolute value to 0

loop:
    beq $t1, $zero, end   # If the size is 0, exit the loop
    lw $t4, 0($t0)        # Load the current element

    # Check if the current element is negative
    bltz $t4, negative_check
    move $t5, $t4         # If positive, store the current element as the temporary maximum
    j compare

negative_check:
    sub $t5, $zero, $t4   # If negative, take the absolute value

compare:
    bgt $t5, $t2, update  # If the absolute value is greater than the maximum absolute value, update the maximum
    addi $t0, $t0, 4     # Move to the next element
    addi $t1, $t1, -1    # Decrease the size
    j loop

update:
    move $t2, $t5        # Update the maximum absolute value
    sub $t3, $t3, $t1    # Update the index of the maximum absolute value
    j loop

end:
