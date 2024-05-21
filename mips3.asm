# Procedure to find the largest, smallest elements, and their positions
# Input: $s0-$s7 contain the elements of the list
# Output: $s8 contains the largest element, $s9 contains its position
#         $s10 contains the smallest element, $s11 contains its position

find_largest_smallest:
    # Initialize largest and smallest with the first element
    move $s8, $s0       # Largest element
    move $s9, $zero     # Position of largest element
    move $s10, $s0      # Smallest element
    move $s11, $zero    # Position of smallest element
    
    # Loop through the list
    li $t0, 1           # Initialize loop counter
    li $t1, 8           # Number of elements in the list
    la $t2, elements    # Load the base address of the list
    loop_start:
        # Check if current element is larger than the current largest
        slt $t3, $s8, ($t2)  # Compare largest with current element
        beq $t3, $zero, check_smallest # If not larger, check if smallest
        
        # Update largest element and its position
        move $s8, ($t2)   # Update largest element
        move $s9, $t0     # Update position
        
        # Check smallest element
        check_smallest:
            # Check if current element is smaller than the current smallest
            slt $t3, ($t2), $s10  # Compare smallest with current element
            beq $t3, $zero, update_counter # If not smaller, update loop counter
            
            # Update smallest element and its position
            move $s10, ($t2) # Update smallest element
            move $s11, $t0   # Update position
            
        # Update loop counter
        update_counter:
            addi $t0, $t0, 1    # Increment loop counter
            addi $t2, $t2, 4    # Move to next element
            blt $t0, $t1, loop_start   # Loop until all elements are checked

    jr $ra              # Return

# Sample list of elements
elements: .word 1, 5, 3, 9, -2, 6, 4, -3

# Example usage
main:
    # Load list elements into registers
    la $t0, elements
    lw $s0, 0($t0)
    lw $s1, 4($t0)
    lw $s2, 8($t0)
    lw $s3, 12($t0)
    lw $s4, 16($t0)
    lw $s5, 20($t0)
    lw $s6, 24($t0)
    lw $s7, 28($t0)
    
    # Call the procedure
    jal find_largest_smallest
    
    # Print results
    li $v0, 1
    move $a0, $s8
    syscall
    li $v0, 11
    la $a0, comma
    syscall
    li $v0, 1
    move $a0, $s9
    syscall
    
    li $v0, 4       # Print message
    la $a0, largest_msg
    syscall
    li $v0, 11
    la $a0, comma
    syscall
    li $v0, 1
    move $a0, $s10
    syscall
    li $v0, 11
    la $a0, smallest_msg
    syscall
    li $v0, 11
    la $a0, comma
    syscall
    li $v0, 1
    move $a0, $s11
    syscall
    
    # Exit
    li $v0, 10
    syscall

# Constants
comma: .asciiz ", "
largest_msg: .asciiz "The largest element is stored in $s"
smallest_msg: .asciiz "The smallest element is stored in $s"
