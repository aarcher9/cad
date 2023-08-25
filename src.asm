.data 0x10008000
OPEN_SQUARE_BRACKET: 
    .word '['
CLOSE_SQUARE_BRACKET: 
    .word ']'
OpenSquareBracketParseError:
    .asciiz "Error: Missing '['"
CloseSquareBracketParseError:
    .asciiz "Error: Missing ']'"

.first_token:
    .word '0'
.last_token:
    .word '0'
.array_length:
    .word 0
.first_token_address:
    .word 0
.last_token_address:
    .word 0


a:
    .word '[' 23 16 166 ']' 

.text 0x400000
main:
    la $a0, a
    li $a1, 3
    jal array_parse

    li $v0, 10
    syscall

array_parse:
    # @ $a0: array address
    # @ $a1: array length

    jal init_data

    # lw $t0, ($a0)
    # lw $t1, OPEN_SQUARE_BRACKET
    # bne $t0, $t1, open_bracket_parse_error 
    
    # li $t2, 4
    # addi $a1, $a1, 1
    # mult $a1, $t2
    # mflo $a1

    # addi $t0, $a0, 13
    # lw $t1, CLOSE_SQUARE_BRACKET
    # bne $t0, $t1, close_bracket_parse_error 
    # j terminate

init_data:
    sw $a0, first_tokejn_address
    sw $a1, array_length

    li $t0, 4
    mult $a1, $t0
    mflo $a1
    add $a1, $a0, $a1
    sw $a1, last_token_address 

    jr $ra

open_bracket_parse_error:
    la $a0, OpenSquareBracketParseError
    li $v0, 4
    syscall 

    j terminate

close_bracket_parse_error:
    la $a0, CloseSquareBracketParseError
    li $v0, 4
    syscall 

    j terminate

terminate:
    li $v0, 10
    syscall