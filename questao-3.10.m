# Questão 3.10 da lista de exercícios
# Autor: Cristóvão Zuppardo Rufino <cristovao.rufino@ufpe.br>
#
# Para informações sobre a licença, ver o arquivo LICENSE

# Matriz de paridade
P = [1 1 1 0;
     0 1 1 1;
     1 1 0 1;
     1 0 1 1];

# G = [P, I]
G = horzcat(P, eye(4));

# H = [I, P']
H = horzcat(eye(4), P');

# "u" são todos os 2^4 vetores possíveis de 4 bits em GF(2)
u = zeros(16, 4);
for i = 0:15
    u(i+1,:) = mod(dec2bin(i, 4)*1, '0'*1);
endfor

# "v" são todos os 2^4 vetores possíveis de C(8, 4)
# que são obtidos pela aplicação de cada "u" à matriz G
v = zeros(16, 8);
for i = 1:16
    v(i,:) = mod(u(i,:)*G, 2);
endfor

# Os 2^(8-4) coset leaders são feitos com a palavra toda nula
# erros únicos de um bit em todas as 8 posições da palavra-código
# e algumas palavras-código com dois bits de erro em posições
# adjacentes. Exemplo 11000000 e 01100000
coset = vertcat(zeros(1, 8), eye(8));
for i = 0:5
    coset = vertcat(coset, circshift([1 1 0 0 0 0 0 0], [0, i]));
endfor
# Esse último não é 00000011 porque esse erro tem a mesma síndrome
# de 01100000
coset = vertcat(coset, [0 1 0 1 0 0 0 0]);

printf("Arranjo padrão do código C(8,4)\n");
printf("Coset    | Vetores\n");
printf("---------+------------------------------------------\n");
for i=1:length(coset)
    printf("%s | ", coset(i,:)+'0'*1);
    for j = 2:length(v)
        printf("%s ", mod(coset(i,:) + v(j,:), 2)+'0'*1);
    endfor
    printf("\n");
endfor

printf("\nDecodificação de síndrome\n");
printf("Síndrome | Padrão de erro\n");
printf("---------+---------------\n");
for i = 2:length(coset)
    printf("%s     | %s\n", mod(coset(i,:)*H', 2) + '0'*1, coset(i,:) + '0'*1);
endfor