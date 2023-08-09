.data 0x10008000
s: .asciiz "Ciao!"
EOS: .asciiz ""

.text 0x400000
main:
        li $s0, 0 # lunghezza stringa
        la $a1, s # indirizzo char corrente
        lb $s1, EOS # terminatore

        jal length

        li $v0, 1
        move $a0, $s0
        syscall

        li $v0, 10
        syscall

# --- Routines --- #
length:  
        lb $t0, ($a1)
        beq $t0, $s1, terminate

        addi $s0, $s0, 1
        addi $a1, $a1, 1

        j length

terminate:
        jr $ra


