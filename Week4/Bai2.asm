.text
# Extract MSB of $s0
li $s0,  0x12345678 
srl $t0, $s0, 24 
sll $t0, $t0, 24

# Clear LSB of $s0
srl $t1, $s0, 8
sll $t1, $t1, 8

# Set LSB of $s0 (bits 7 to 0 are set to 1)
ori $t2, $s0, 0x000000ff

# Clear $s0 ($s0=0, must use logical instructions)
andi $t3, $s0, 0
