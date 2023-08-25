.data 0x10008000


.text 0x400000
main:
    # Sembra che abbia a disposizione 24 bit fra esponente e mantissa, escluso segno, quindi 25 bit, gli altri 7 non so per cosa siano usati

    # Qui parte decimale massima e intera o 0 o 1, perche ho finito i bit
    li.s $f12, 0.99999988
    jal print_float
    jal sep

    li.s $f12, 1.99999988
    jal print_float
    jal sep

    # Qui nessuna parte decimale, ho finito i bit
    li.s $f12, -16777216.00000
    jal print_float
    jal sep

    # Se infatti provo ad aggiungere, non mi scombina la precisione del numero nei primi due casi, e non succede nulla nel terzo, ovvero arrotonda all'intero vicino

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
