.data 0x10008000
start: .byte 23 34 7 8 90 8
end: .byte ';'

.text 0x400000
main:

    j run

    li $v0, 10
    syscall

init:
    la $a0, start
    jr $ra

increment:
    addi $a0, $a0, 1
    jr $ra

print:
    li $v0, 1
    syscall
    jr $ra

print_sep:
    li $v0, 11
    li $a0, '\n'
    syscall
    
move_back:
    move $a0, $a1
    jr $ra

check:
    lb $t0, 0($a0)

    la $t1, end
    lb $t1, 0($t1)

    beq $t0, $t1, exit
    move $a1, $a0
    move $a0, $t0
    jr $ra


exit:
    li $v0, 10
    syscall

loop:
    jal check
    jal print
    jal print_sep
    jal move_back
    jal increment
    j loop

run:
    jal init
    j loop