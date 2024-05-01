j main

recursive:
lw $t0, 0($sp)
addi $sp, $sp, 4

bne $t0, $0, else
addi $sp, $sp, -4
sw $t0, 0($sp)
jr $ra

else:
addi $t0, $t0, -1
addi $sp, $sp, -8
sw $t0, 0($sp)
sw $ra, 4($sp)
jal recursive
lw $t0, 0($sp)
lw $ra, 4($sp)
addi $sp, $sp, 8
addi $t0, $t0, 1
addi $sp, $sp, -4
sw $t0, 0($sp)
jr $ra

main:
addi $s0, $0, 0xABCD
addi $sp, $sp, -4
sw $s0, 0($sp)
jal recursive
lw $s1, 0($sp)
addi $sp, $sp, 4

# store s0 -> -4
## sp = sp_0 - 4
# chama rec n
# load inicial de rec -> +4
# n�o � zero, vai pra else
# store return e t0 -> -8
## sp = sp_0 - 8
# chama rec n-1
# load inicial de rec -> +4
# n�o � zero, vai pra else
# store return e t0 -> -8
## sp = sp_0 - 12
# chama rec n-2
# load inicial de rec -> +4
# n�o � zero, vai pra else
# store return e t0 -> -8
## sp = sp_0 - 16
## ...
# chama rec n-k
# load inicial de rec -> +4
# n�o � zero, vai pra else
# store return e t0 -> -8
## sp = sp_0 - 8 - 4 * k
## ...
## sp = sp_0 - 8 - 4 * (n-1) = sp_0 - 4 - 4n
# chama rec 0
## no total, s�o feitas n + 1 chamadas
# load inicial de rec -> +4
# � zero, segue
# store t0 -> -4
## sp = sp_0 - 4 - 4n
# retorno de  0
# load return e t0 -> 8
# store t0 -> -4
## sp = sp_0 - 4 - 4n + 4 = sp_0 - 4n
# retorno de 1
# load return e t0 -> 8
# store t0 -> -4
## sp = sp_0 - 4n + 4
# retorno de 2
# load return e t0 -> 8
# store t0 -> -4
## sp = sp_0 - 4n + 8
# retorno de 3
# load return e t0 -> 8
# store t0 -> -4
## sp = sp_0 - 4n + 12
## ...
# retorno de k
# load return e t0 -> 8
# store t0 -> -4
## sp = sp_0 - 4n + 4k
## ...
## para o programa seguir a partir
## da primeira chamada de fun��o,
## deve retornar todas, at� n
# retorno de n - 1
# load return e t0 -> 8
# store t0 -> -4
## sp = sp_0 - 4n + 4(n-1) = sp_0 - 4
# retorno de n
## ap�s retornar da chamada de rec(n),
## j� est� na main
# load s1 -> 4
## sp = sp_0 - 4 + 4 = sp_0
