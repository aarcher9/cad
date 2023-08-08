.text
main:
li $v0, 4
lw $t0, 8($sp)
la $a0, 0($t0)

li $v0, 10
syscall