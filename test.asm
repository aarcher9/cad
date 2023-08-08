.data
msg: .asciiz "\nHello, World!\n"

.text
main:
# in $v0 inserisco il codice della syscall
# 4 = print
li $v0, 4

# in $a0 inserisco i dati
la $a0, msg

# eseguo la syscall
syscall

# faccio la stessa cosa
# 10 = exit
li $v0, 10
syscall