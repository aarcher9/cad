.data 0x10008000
main_message:
    .asciiz "MAIN\n"
A_message:
    .asciiz "A\n"
B_message:
    .asciiz "B\n"
C_message:
    .asciiz "C\n"

.text 0x400000
main:
    # ---
    move $s0, $ra
    jal malloc_256B
    sw $s0, 0($fp)

    jal A

    lw $s0, 0($fp)
    jal free_256B
    move $ra, $s0
    # ---

    la $a0, main_message
    li $v0, 4
    syscall
    
    li $v0, 10
    syscall

# Operazioni sulla memoria
malloc_256B:
    addi $sp, $sp, -256
    sw $fp, 0($sp)
    addi $fp, $sp, 4
    jr $ra

free_256B:
    lw $fp, 0($sp)
    addi $sp, $sp, 256
    jr $ra


A:
    move $s0, $ra
    jal malloc_256B
    sw $s0, 0($fp)

    jal B

    la $a0, A_message
    li $v0, 4
    syscall

    lw $s0, 0($fp)
    jal free_256B
    move $ra, $s0

    jr $ra

B:
    move $s0, $ra
    jal malloc_256B
    sw $s0, 0($fp)

    jal C

    la $a0, B_message
    li $v0, 4
    syscall

    lw $s0, 0($fp)
    jal free_256B
    move $ra, $s0

    jr $ra

C:
    move $s0, $ra
    jal malloc_256B
    sw $s0, 0($fp)

    la $a0, C_message
    li $v0, 4
    syscall

    lw $s0, 0($fp)
    jal free_256B
    move $ra, $s0

    jr $ra

