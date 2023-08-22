.data 0x10008000
array: 
    .byte 4 1 2 4 1 3 0 9 7 1
counter:
    .byte 0
start:
    .byte 0
end:
    .byte 9
alert_msg:
    .asciiz "!"

.text 0x400000
main:
    jal sort

    li $v0, 1
    lb $a0, array
    syscall

    li $v0, 10
    syscall

# --- Routine
sort:
    j proceed_or_restart
    j increment_counter
    jr $ra

# ---
restart:
    jr $ra

increment_counter:
    lb $t0, counter
    addi $t0, $t0, 1
    sb $t0, counter
    jr $ra

proceed_or_restart:
    lb $t0, counter
    lb $t1, end
    bne $t0, $t1, load
    beq $t0, $t1, restart

load:
    la $t0, array
    lb $t1, counter
    add $t2, $t0, $t1
    lb $a0, 0($t2)
    lb $a1, 1($t2)
    la $a2, 0($t2)
    j compare

compare: 
    li $t0, 0
    sgt $t0, $a0, $a1
    bnez $t0, swap
    beqz $t0, dont_swap

swap:
    sb $a0, 1($a2)
    sb $a1, 0($a2)
    jr $ra

dont_swap:
    sb $a0, 0($a2)
    sb $a1, 1($a2)
    jr $ra