# Constants
.data
elements: .word 1, 5, 3, 9, -2, 6, 4, -3
comma: .asciiz ", "
largest_msg: .asciiz "The largest element is stored in $s"
smallest_msg: .asciiz "The smallest element is stored in $s"
.text
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
    move $a0, $t4
    syscall
    li $v0, 11
    la $a0, comma
    syscall
    li $v0, 1
    move $a0, $t5
    syscall  
    li $v0, 4       # Print message
    la $a0, largest_msg
    syscall
    li $v0, 11
    la $a0, comma
    syscall
    li $v0, 1
    move $a0, $t6
    syscall
    li $v0, 11
    la $a0, smallest_msg
    syscall
    li $v0, 11
    la $a0, comma
    syscall
    li $v0, 1
    move $a0, $t7
    syscall
    
    # Exit
    li $v0, 10
    syscall
find_largest_smallest:
    # Initialize largest and smallest with the first element
    move $t4, $s0       # Largest element
    move $t5, $zero     # Position of largest element
    move $t6, $s0      # Smallest element
    move $t7, $zero    # Position of smallest element
    
    # Loop through the list
    li $t0, 1           # Initialize loop counter
    li $t1, 8           # Number of elements in the list
    la $s0, elements
    addi $s0,$s0,4
    loop_start:
        # Check if current element is larger than the current largest
        lw $t2,0($s0)
        slt $t3, $t4, $t2  # Compare largest with current element
        beq $t3, $zero, check_smallest # If not larger, check if smallest
        
        # Update largest element and its position
        move $t4, $t2   # Update largest element
        move $t5, $t0     # Update position
        
        # Check smallest element
        check_smallest:
            # Check if current element is smaller than the current smallest
            slt $t3, $t2, $t6  # Compare smallest with current element
            beq $t3, $zero, update_counter # If not smaller, update loop counter
            
            # Update smallest element and its position
            move $t6, $t2 # Update smallest element
            move $t7, $t0   # Update position
            
        # Update loop counter
        update_counter:
            addi $t0, $t0, 1    # Increment loop counter
            addi $s0, $s0, 4    # Move to next element
            blt $t0, $t1, loop_start   # Loop until all elements are checked
    jr $ra              # Return