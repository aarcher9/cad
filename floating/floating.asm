.data 0x10008000


.text 0x400000
main:
    # 
    li.s $f12, 0.00000001
    jal print_float
    jal sep

    li.s $f12, 1.10000000
    jal print_float
    jal sep

    # Posso agire sulla frazione piu piccole come 1/2^24, e quindi aggiungerla o meno al numero 0.94580072, tutti i reali che stanno fra 0.94580072 e 0.94580078 (= 0.94580072 + 1/2^24) non possono essere rappresentati (in single precision chiaramente, con piu bit posso fare piu numeri reali, non solo rappresentare numeri piu piccoli ma anche lasciare meno buchi)
    # Penso sia 1/2^24 per via del numero di bit nella mantissa
    li.s $f12, 0.94580078
    jal print_float
    jal sep

    li.s $f12, 0.94580073
    jal print_float
    jal sep

    li.s $f12, 0.94580072
    jal print_float
    jal sep


    #
    li.s $f12, 8191.94580072
    jal print_float
    jal sep

    li.s $f12, 16777219.0
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
