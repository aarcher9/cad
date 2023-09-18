.data 0x10008000
# Program
xi_addr:
        .word 0
yi_addr:
        .word 0
Ri_addr:
        .word 0
index:
        .word 0


# Do what you want!
vector_1:
        .word 3 1 2
vector_2:
        .word 1 4 0
Res:
        .word 0 0 0

.text 0x400000
main:

        la $a0, vector_1
        la $a1, vector_2
        la $a2, Res
        jal vector_sum

        la $a0, Res
        jal vector_print

        li $v0, 10
        syscall

# Functions
vector_sum:

        sw $a0, xi_addr
        sw $a1, yi_addr
        sw $a2, Ri_addr
        j sum


        sum:

                la $t0, xi_addr
                la $t1, yi_addr

                lw $t0, ($t0)
                lw $t1, ($t1)

                add $v0, $t0, $t1

                j update_result


        update_result:

                sw $v0, Ri_addr
                j update_Ri_addr


        update_Ri_addr:

                la $t0, Ri_addr
                addi $t0, $t0, 4
                sw $t0, Ri_addr

                j update_xi_and_yi_addr


        update_xi_and_yi_addr:
                la $t0, xi_addr
                la $t1, yi_addr

                addi $t0, $t0, 4
                addi $t1, $t1, 4

                sw $t0, xi_addr
                sw $t1, yi_addr

                j end_or_continue_sum


        end_or_continue_sum:

                lw $t0, index
                beq $t0, 4, end_sum

                addi $t0, $t0, 4
                sw $t0, index

                j sum


        end_sum:

                jr $ra


vector_print:

        

        print:

                li $v0, 1
