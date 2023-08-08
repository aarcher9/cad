# l'allineamento dei dati viene sempre fatto alla word, anche se il dato è byte

# UMI = unità minima indirizzabile 
# dim(=UMI) = 1 byte, addr = 0x00
# UMI + 1, addr = 0x04
# posso quindi spostarmi di minimo 1 byte

.data 0x10010000 # indirizzo minimo di partenza
.word 0x24 0x25 # $ %
.word 0x38 # 8
msg: .asciiz "€"
.byte 0x63 0x69 0x61 0x6f # c i a o
# Stampa al max fino a 0x7f (DELETE) che non si vede.
# Trattasi del 127 carattere ASCII, questo per via del fatto che un carattere
# che occupa di norma 8 bit = 1 byte ha bisogno di 1 bit come terminatore
# il che riduce i bit disponibili per carattere a 7 -> 2^7 = 128, quindi ASCII
# da 0 a 127, 128 ad esempio non ci sta in una UMA.
# Se volessi stampare gli ASCII successivi dovrei sommare i valori nelle UMA
# basta vedere che msg: .asciiz "123~" non "disallinea" la memoria
# msg: .asciiz "123€" invece la "disallinea"
.word 0x7e # ~
.word 0x7d # }
.word 0x80 # €

.text
main:
li $v0, 4

# posso usare la notazione dec o hex
la $a0, 0x10010000 # $
syscall

la $a0, 268500992 # $
syscall

la $a0, 0x10010004 # %
syscall

la $a0, 0x10010008 # 8
syscall

la $a0, 0x1001000c # €
syscall

# stampa fino a fine parola, e se occupo tutti e 4 i byte mi stampa anche
# la cella adiacente
la $a0, 0x10010010 # ciao~
syscall
la $a0, 0x10010011 # iao~
syscall
la $a0, 0x10010012 # ao~
syscall
la $a0, 0x10010013 # o~
syscall

la $a0, 0x10010013 # ~
syscall

la $a0, 0x10010018 # }
syscall

# se voglio stampare il simbolo €
la $a0, 0x1001001c
# lb $a1, 0x1001001d
# la $a0, 0x1001001c
syscall

li $v0, 10
syscall