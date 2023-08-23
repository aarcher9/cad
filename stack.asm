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
    addi $sp, $sp, -64 # alloco lo spazio
    sw $fp, 60($sp) # salvo il $fp della routine precedente
    sw $ra, 56($sp)

    jal A

    lw $ra, 56($sp)
    lw $fp, 60($sp) # ripristino il $fp della routine precedente
    addi $sp, $sp, 64 # dealloco lo spazio

    la $a0, main_message
    li $v0, 4
    syscall
    
    li $v0, 10
    syscall

A:
    addi $sp, $sp, -64
    sw $fp, 60($sp)
    sw $ra, 56($sp)

    jal B

    la $a0, A_message
    li $v0, 4
    syscall

    lw $ra, 56($sp)
    lw $fp, 60($sp)
    addi $sp, $sp, 64

    jr $ra

B:
    addi $sp, $sp, -64
    sw $fp, 60($sp)
    sw $ra, 56($sp)

    jal C

    la $a0, B_message
    li $v0, 4
    syscall

    lw $ra, 56($sp)
    lw $fp, 60($sp)
    addi $sp, $sp, 64

    jr $ra

C:
    la $a0, C_message
    li $v0, 4
    syscall

    jr $ra
