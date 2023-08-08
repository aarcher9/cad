.data 0x10010000 
.word 'a' 'b' 'c' 'd'
.asciiz "11\"1"
.asciiz "abc"
.ascii "11\"1"
.asciiz "abc"


.text
main:
li $v0, 4
li $v0, 10
syscall