.data 0x10008000
array: 
    .byte 4 1 0 4 1 3 0 9 7 7 9 8 ']'
counter:
    .byte 0
swaps_performed:
    .byte 1
ra_stack:
    .space 20 

.text 0x400000
main:
    j sort

    li $v0, 10
    syscall

exit:
    li $v0, 10
    syscall

# --- Main routine
increment_counter:
    lb $t0, counter
    addi $t0, $t0, 1
    sb $t0, counter
    j sort

load_current_item:
    lb $t0, counter
    la $t1, array
    add $t2, $t1, $t0 
    lb $v0, 0($t2)
    jr $ra

load_next_item:
    lb $t0, counter
    la $t1, array
    add $t2, $t1, $t0 
    lb $v0, 1($t2)
    jr $ra

sort:
    j proceed_or_restart

    proceed_or_restart:
        jal load_next_item
        bne $v0, ']', proceed
        beq $v0, ']', restart

        proceed:
            j load

        restart:
            j check_for_termination

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

        dont_swap:
            j increment_counter

        swap:
            sb $a0, 1($a2)
            sb $a1, 0($a2)
            j increment_swaps_performed

            increment_swaps_performed:
                lb $t0, swaps_performed
                addi $t0, $t0, 1
                sb $t0, swaps_performed
                j increment_counter

check_for_termination:
    lb $t0, swaps_performed
    beqz $t0, sorting_completed
    j reset_counter_and_swaps_performed

    sorting_completed:
        jal print
        j exit

    reset_counter_and_swaps_performed:
        li $t0, -1 # Mi serve perchè lo incremento subito dopo
        sb $t0, counter
        li $t0, 0
        sb $t0, swaps_performed
        j increment_counter

# Stampa sequenza di byte a schermo
print:
    sb $zero, counter
    j print_remaining

    print_remaining:
        j load_item

    load_item:
        lb $t0, counter
        la $t1, array
        add $t2, $t0, $t1
        lb $a0, 0($t2)
        j log

    log:
        li $v0, 1
        syscall
        j increment_index

    increment_index:
        lb $t0, counter
        addi $t0, $t0, 1
        sb $t0, counter
        j restart_or_terminate

    restart_or_terminate:
        lb $t0, counter
        la $t1, array
        add $t2, $t1, $t0 
        lb $s0, 0($t2)
        
        bne $s0, ']', print_remaining
        jr $ra