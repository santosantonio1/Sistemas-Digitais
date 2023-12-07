# + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + +
#											    
# 	Trabalho 4 - Fundamentos de Sistemas Digitais				   	    
#											    
# 	Membros: Antônio Vinicius Corrêa dos Santos e Nathan da Rosa Cidal		    
#											    
# 	Versão: 24/11/2023							    
#											    
# 	Descrição: Este programa realiza o produto escalar entre dois vetores de inteiros.  
#		   Primeiro, cria um vetor c, tal que c[i] = a[i] + b[i] e depois	    
#	     	   cria um vetor d, em que d[i] = a[i] - b[i].				    
#		   Por fim, realiza o produto escalar entre c e d.			    
#	     	   O teste realizado utilizou dois vetores de 9 elementos.		    
#											    
# + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + +

.data
	n : 	8
	pe: 	0 
	a : 	.word 2 4 6 -8 9 10 12 -2
	b : 	.word 1 3 5 -7 9 11 -13 0
	c : 	.word 0 0 0 0 0 0 0 0
	d : 	.word 0 0 0 0 0 0 0 0




.text
	.globl main



main:
	
	xor $t0, $t0, $t0	# int i = 0
	xor $s0, $s0, $s0	# auxiliar para salvar o produto escalar
	
	#lw $s0, 0($s0)		# pe = 0
	
	la $s1, n		# int n
	lw $s1, 0($s1)		# n = 8
	
	la $t1, a		# carrega o endereço do vetor a 
	la $t2, b		# carrega o endereço do vetor b
	la $t3, c		# carrega o endereço do vetor c
	
	jal soma_vet		# cria o vetor c (c[i] = a[i] + b[i])
	
	xor $t0, $t0, $t0	# i = 0 novamente
	
	la $t1, a		# carrega o endereço do vetor a de novo
	la $t2, b		# carrega o endereço do vetor b de novo
	la $t4, d		# carrega o endereço do vetor d 
	
	jal subtrai_vet		# cria o vetor d (d[i] = a[i] - b[i])
	
	sll $t0, $t0, 2		# 4 * $t0 para subtrair de c e d
	sub $t3, $t3, $t0	# volta *c para o inicio do vetor
	sub $t4, $t4, $t0	# volta *d para o inicio do vetor 
	xor $t0, $t0, $t0	# i = 0 mais uma vez
	
	#xor $s4, $s4, $s4	# parcelas do produto escalar
		
	j produto_escalar	






# cria o vetor c ...	
soma_vet:
	
	lw $t5, 0($t1)		# carrega a[i]
	lw $t6, 0($t2)		# carrega b[i]
	lw $t7, 0($t3)		# carrega c[i]
	
	add $t7, $t5, $t6	# c[i] = a[i] + b[i]
	sw $t7, 0($t3)		# salva c[i] no vetor c
	
	addi $t0, $t0, 1	# i++
	addi $t1, $t1, 4	# a++
	addi $t2, $t2, 4	# b++
	addi $t3, $t3, 4	# c++
	
	blt $t0, $s1, soma_vet	
	jr $ra






# cria o vetor d ...	
subtrai_vet:
	
	lw $t5, 0($t1)		# carrega a[i]
	lw $t6, 0($t2)		# carrega b[i]
	lw $t7, 0($t4)		# carrega d[i]
	
	sub $t7, $t5, $t6	# d[i] = a[i] - b[i]
	sw $t7, 0($t4)		# salva d[i] no vetor d
	
	addi $t0, $t0, 1	# i++
	addi $t1, $t1, 4	# a++
	addi $t2, $t2, 4	# b++
	addi $t4, $t4, 4	# d++
	
	blt $t0, $s1, subtrai_vet
	jr $ra






produto_escalar:
	
	lw $t1, 0($t3)		# carrega c[i]
	lw $t2, 0($t4)		# carrega d[i]

	xor $t7, $t7, $t7 	# iterador auxiliar
	xor $s3, $s3, $s3	# parcelas do produto escalar
	
	beq $t1, $t7, avanca	# c[i] == 0 => pula
	beq $t2, $t7, avanca	# d[i] == 0 => pula
	
	blt $t2, $t7, d_negativo	# caso d[i] < 0 
	
	j d_positivo		# caso d[i] > 0







# subrotina de multiplicação de 2 elementos...		
mult:
	
	add $s3, $s3, $t1	# parcela salva em $s3
	addi $t7, $t7, 1	# itr++
	
	blt $t7, $t2, mult	# itr < d[i]
	
	jr $ra
	





# caso em que d[i] < 0 ...
d_negativo:
	
	sub $t2, $t7, $t2	# d[i] = 0 - d[i] ( d[i] *= -1)
	
	jal mult
	
	xor $t7, $t7, $t7
	
	blt $t1, $t7, arruma_soma
	
	sub $s0, $s0, $s3	# c[i] > 0 e d[i] < 0 => soma negativa
	
	j avanca
	






# caso em que d[i] > 0 ...	
d_positivo:
	
	jal mult	
	
	add $s0, $s0, $s3	# c[i] > 0 e d[i] > 0 => soma positiva
	
	j avanca






# avança nos vetores...
avanca:
	
	addi $t0, $t0, 1	# i++
	addi $t3, $t3, 4	# c++
	addi $t4, $t4, 4	# d++
	
	blt $t0, $s1, produto_escalar
	
	j end






arruma_soma:
	
	sub $s0, $s0, $s3	# caso c[i] < 0, a soma deve ser positiva pois d[i] < 0

	j avanca





	
end:	
	la $s3, pe
	sw $s0, 0($s3)





fim: j fim
	
	
	
	
	
