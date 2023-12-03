#include <stdlib.h>
#include <stdio.h>

void somaArray(int * c, int * a, int * b, int n){
	int i = 0;								//Declaração de inteiro que será o index
	while(i < n){							//Laço que ocorre enquanto 'i' for menor que 'n'
		*(c + i) = *(a + i) + *(b + i);		//Utilizando operação arimétrica de ponteiro pra 
		i++;								//Incrementando o index em +1
	}
}

int inverteSinal(int s){
	int aux = 0;						//Um auxiliar pra guardar o valor que recebe na função
	aux = 0 - s;						//Inverte o sinal do S e atribui para Aux
	return aux;							//Retorna Aux com o sinal invertido de S
}

void subtraiArray(int * d, int * a, int * b, int n){
	int i = 0;							//Declaração de inteiro que será o index
	while(i < n){						//Laço que ocorre enquanto 'i' for menor que 'n'
		*(d+i) = *(a+i) - *(b+i);		//Utilizando operação arimétrica de ponteiro pra 
		i++;							//Incrementando o index em +1
	}
}

int multiplica(int c, int d){			//Função para executar a multiplicação
	int i = d;							//Declaração de uma variável de index que tá sendo atribuindo o valor do "vezes"
	int a = 0;							//Variável que será usada pra guardar a multiplicação

	//----------------------------------------------------------------------
	//Meramente pra visualização
	if(c >= 0)
		printf(" %d*", c);
	else 	printf(" (%d)*", c);
	
	if(d >= 0)
		printf("%d +", d);
	else	printf("(%d) +", d);

	//----------------------------------------------------------------------		
	
	if(i == 0) return 0;				//Se o valor do multiplicador for "0", será retornado o inteiro 0
	if(i < 0) i = inverteSinal(i);		//Caso o valor do multiplicador seja abaixo de 0, invertemos o sinal usando a função

	while(i != 0){						//Enquanto o "vezes" não for igual a 0, continuará o processo de multiplicação abaixo
		a = a + c;						//O Auxiliar é igual a ele somado ao valor C
		i = i - 1;						//Reduz o "vezes", para não ser um laço infinito
	}

	if(d < 0)							//Se o valor do multiplicador for negativo (vezes), então iremos inverter o valor do Aux
		a = inverteSinal(a); 			//Auxiliar = Auxiliar com valor contrário

	return a;							//Retornar o 'a' com sinal correto e multiplicação correta
}

int somatorio(int * c, int * d, int n){
	int soma = 0;									//Variável pra guardar o somatório
	int i = 0;										//Valor de Index

	while(i < n){									//Laço enquanto 'i' for menor que o número de elementos
		soma = soma + multiplica( *(c+i), *(d+i));	//Operação de soma = ela somado a multiplicação de c[i]*d[i];
		i++;										//Incremento do index
	}

	return soma;									//Retorna o Somatório
}

int main(){
	
	//------------------------------------------------------------------------------------------------------------------------
	//Espaço dedicado a declaração de variáveis

	int n = 10;												//Nosso valor de N
	int a[10] = {2, 4, 6, -8, 9, 10, 12, -2, 0, 11};	//Nosso array de 'a'
	int b[10] = {1, 3, 5, -7, 9, 11, -13, 0, 0, 11};	//Nosso array de 'b'
	int c[10]={};											//Array de 7 espaços de 'c'
	int d[10]={};											//Array de 7 espaços de 'd'
	int pe = 0;												//Variável pra guardar o Produto de C*E
	
	//------------------------------------------------------------------------------------------------------------------------
	//Espaço abaixo meramente pra visualização de variáveis como se fosse pra ser em Mips

	printf(".data\n");
	printf("	PE:	.word	%d\n", pe);
	printf("	n:	.word	%d\n", n);
	printf("	A:	.word	");

	for(int i = 0; i < n; i++)
		printf("%d ", *(a+i));

	printf("\n");
	printf("	B:	.word	");	

	for(int i = 0; i < n; i++)
		printf("%d ", *(b+i));

	printf("\n");
	printf("	C:	.word	");

	for(int i = 0; i < n; i++){
		*(c+i) = 0;				//Aproveitando durante a impressão para já zerar os elementos do array de C
		printf("%d ", *(c+i));
	}

	printf("\n");
	printf("	D:	.word	");

	for(int i = 0; i < n; i++){
		*(d+i) = 0;				//Aproveitando durante a impressão para já zerar os elementos do array de D
		printf("%d ", *(d+i));
	}

	printf("\n");

	//------------------------------------------------------------------------------------------------------------------------
	
	somaArray(c,a,b,n);					//Soma do Array a+b em 'c'
	subtraiArray(d,a,b,n);				//Subtração do Array a-b em 'd'

	//------------------------------------------------------------------------------------------------------------------------
	//Espaço abaixo visualização dos elementos de C e D

	printf("\nC = {");
	for(int i = 0; i < n; i++){
		if(i + 1 == n){ printf(" %d}\n", *(c+i));	}
		else{	printf(" %d,", *(c+i));	}
	}
	
	printf("\nD = {");
	for(int i = 0; i < n; i++){
		if(i + 1 == n){ printf(" %d}\n", *(d+i));	}
		else{	printf(" %d,", *(d+i));	}
	}

	//------------------------------------------------------------------------------------------------------------------------
	//Execução da operação de Somatório abaixo enquanto no método tem a impressão do que ocorre

	printf("PE =");						//Visualização
	pe = somatorio(c,d, n);				//Atribuição do resultado do somatório de C*D em PE.

	printf(" 	= %d\n", pe);			//Imprime o valor de PE
	
	return 0;
}