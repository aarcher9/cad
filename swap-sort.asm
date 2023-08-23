.data 0x10008000
array: 
    .word 4 1 110 4 1 3 0 9 7 7 9 88 ']'
counter:
    .word 0
swaps_performed:
    .word 1
spacer:
    .asciiz ", "
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
    lw $t0, counter
    addi $t0, $t0, 4
    sw $t0, counter
    j sort

load_current_item:
    lw $t0, counter
    la $t1, array
    add $t2, $t1, $t0 
    lw $v0, 0($t2)
    jr $ra

load_next_item:
    lw $t0, counter
    la $t1, array
    add $t2, $t1, $t0 
    lw $v0, 4($t2)
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
    lw $t1, counter
    add $t2, $t0, $t1
    lw $a0, 0($t2)
    lw $a1, 4($t2)
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
            sw $a0, 4($a2)
            sw $a1, 0($a2)
            j increment_swaps_performed

            increment_swaps_performed:
                lw $t0, swaps_performed
                addi $t0, $t0, 1
                sw $t0, swaps_performed
                j increment_counter

check_for_termination:
    lw $t0, swaps_performed
    beqz $t0, sorting_completed
    j reset_counter_and_swaps_performed

    sorting_completed:
        jal print
        j exit

    reset_counter_and_swaps_performed:
        li $t0, -4 # Mi serve perchè lo incremento subito dopo
        sw $t0, counter
        li $t0, 0
        sw $t0, swaps_performed
        j increment_counter

# Stampa sequenza di byte a schermo
print:
    sw $zero, counter
    j print_remaining

    print_remaining:
        j load_item

    load_item:
        lw $t0, counter
        la $t1, array
        add $t2, $t0, $t1
        lw $a0, 0($t2)
        j log

    log:
        li $v0, 1
        syscall

        la $a0, spacer
        li $v0, 4
        syscall

        j increment_index

    increment_index:
        lw $t0, counter
        addi $t0, $t0, 4
        sw $t0, counter
        j restart_or_terminate

    restart_or_terminate:
        lw $t0, counter
        la $t1, array
        add $t2, $t1, $t0 
        lw $s0, 0($t2)
        
        bne $s0, ']', print_remaining
        jr $ra