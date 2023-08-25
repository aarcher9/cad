.data 0x10008000
# Notare come uscendo dal range possibile di cifre rappresentabili sul byte, viene in pratica fatta una somma in modulo 128
.byte 10 127 129

.text 0x400000
main:
    lb $a0, 0x10008000
    li $v0, 1
    syscall

    li $a0, ' '
    li $v0, 11
    syscall 

    lb $a0, 0x10008001
    li $v0, 1
    syscall

    li $a0, ' '
    li $v0, 11
    syscall 

    lb $a0, 0x10008002
    li $v0, 1
    syscall

    li $v0, 10
    syscall
