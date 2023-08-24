.text
main: jr exit

exit:
        li $v0, 10
        syscall
        jr $ra

# Devo aver eseguito prima: la $a0, <str_address>
print_string:
        li $v0, 4
        syscall
        jr $ra

# Devo aver eseguito prima: li $a0, <int>
print_char:
        li $v0, 11
        syscall
        jr $ra

# Devo aver eseguito prima: li $a0, <int>
print_int:
        li $v0, 1
        syscall
        jr $ra