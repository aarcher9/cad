.data 0x10008000


.text 0x400000
main:
    li.s $f12, 0.99999988
    jal print_float
    jal sep

    li.s $f12, 1.99999988
    jal print_float
    jal sep

    # Non ho piu spazio per i decimali, infatti il numero equivale a 2^24 (la mantissa), l'
    li.s $f12, 16777216.000000
    jal print_float
    jal sep

    li $v0, 10
    syscall

sep:
    li $a0, '\n'
    li $v0, 11
    syscall 
    jr $ra

print_float:
    li $v0, 2
    syscall
    jr $ra
