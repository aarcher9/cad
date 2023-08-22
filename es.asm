.data 0x10008000
array: 
    .byte 4 1 2 4 1 3 0 9 7 1
counter:
    .byte 0
start:
    .byte 0
end:
    .byte 9
swaps_performed:
    .byte 0
alert_msg:
    .asciiz "!"

.text 0x400000
main:
    j sort

    li $v0, 10
    syscall

# --- Main routine
print:
    la $t0, array
    lb $a0, 3($t0)
    li $v0, 1
    syscall
    jr $ra

sorting_completed:
    # jal print
    li $v0, 10
    syscall

sort:
    j proceed_or_restart

increment_counter:
    lb $t0, counter
    addi $t0, $t0, 1
    sb $t0, counter
    j sort

proceed_or_restart:
    lb $t0, counter
    lb $t1, end
    bne $t0, $t1, proceed
    beq $t0, $t1, restart

proceed:
    j load

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
    beqz $t0, dont_swap
    bnez $t0, swap

swap:
    sb $a0, 1($a2)
    sb $a1, 0($a2)
    jal increment_swaps_performed
    j increment_counter

increment_swaps_performed:
    lb $t0, swaps_performed
    addi $t0, $t0, 1
    sb $t0, swaps_performed
    jr $ra

dont_swap:
    j increment_counter

check_for_termination:
    lb $t0, swaps_performed
    beqz $t0, sorting_completed
    jr $ra

reset_counter_and_swaps_performed:
    li $t0, 0
    sb $t0, counter
    sb $t0, swaps_performed
    jr $ra

restart:
    jal check_for_termination
    jal reset_counter_and_swaps_performed
    j increment_counter