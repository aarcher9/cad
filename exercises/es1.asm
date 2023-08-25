.data 0x10008000
op_code: .byte '+'
array_1: .word 3 3 2 '!'
op_result: .byte ''

.text 0x400000
main:
        # Predispongo parametri e valori di ritorno
        jal initialize
        jal op
        jal free
        
        li $v0, 10
        syscall

initialize:
        li $a0, 0
        li $s0, 0 # Somma
        li $s1, 1 # Prodotto
        li $s2, 1 # <first> AND <third>
        la $s3, array_1 # Indirizzo di partenza
        lb $s4, op_code # Codice operazione
        jr $ra

free:
        move $s0, $0 # Somma
        move $s1, $0 # Prodotto
        move $s2, $0 # <first> AND <third>
        move $s3, $0 # Indirizzo di partenza
        move $s4, $0 # Codice operazione
        jr $ra

op:
        lw $a0, ($s3)
        beq $a0, '!', print
        beq $s4, '+', sum
        beq $s4, '*', prod

print:
        beq $s4, '+', print_sum
        beq $s4, '*', print_prod
        jr $ra

sum:
        add $s0, $s0, $a0
        addi $s3, $s3, 4
        j op

print_sum:
        move $a0, $s0
        li $v0, 1
        syscall
        jr $ra

prod:
        mult $s1, $a0
        mflo $s1
        addi $s3, $s3, 4
        j op

print_prod:
        move $a0, $s1
        li $v0, 1
        syscall
        jr $ra
