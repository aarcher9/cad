.data 0x10008000
op_code: .byte '+'
array_1: .word 3 3 2 '!'

.text 0x400000
main:
        # Predispongo parametri e valori di ritorno
        li $s0, 0 # Somma
        li $s1, 1 # Prodotto
        li $s2, 0 # <first> AND <third>
        la $s3, array_1 # Indirizzo di partenza
        lb $s4, op_code # Codice operazione

        jal op
        
        li $v0, 10
        syscall

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
