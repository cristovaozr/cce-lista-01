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

# Daqui pra frente os loops calculam as síndromes de todos os padrões de erro
# com peso 2, 3 e 4.
# Dá pra perceber que uma síndrome não-nula cujo padrão de erro tem peso maior ou
# igual a dois é a soma módulo 2 da síndrome do padrão de erro dos erros de peso
# unitário. Por exemplo:
# e = 01000010 = 01000000 + 00000010 = e_1 + e_7
# Então, a síndrome de e, e*H' é dada por:
# e*H' = e_1*H' + e_7*H'
#      = 0100 + 1101
#      = 1001
printf("\nDecodificação de todas as síndromes dos padrões de erro com w(e) == 2\n");
printf("Síndrome | Padrão de erro\n");
printf("---------+---------------\n");
for i = 1:7
    for j = i+1:8
        g = zeros(1, 8);
        g(i) = 1; g(j) = 1;
        s = mod(g*H', 2);
        printf("%s     | %s\n", s + '0'*1, g + '0'*1)
    endfor
endfor

printf("\nDecodificação de todas as síndromes dos padrões de erro com w(e) == 3\n");
printf("Síndrome | Padrão de erro\n");
printf("---------+---------------\n");
for i = 1:6
    for j = i+1:7
        for k = j+1:8
            g = zeros(1, 8);
            g(i) = 1; g(j) = 1; g(k) = 1;
            s = mod(g*H', 2);
            printf("%s     | %s\n", s + '0'*1, g + '0'*1)
        endfor
    endfor
endfor

printf("\nDecodificação de todas as síndromes dos padrões de erro com w(e) == 4\n");
printf("Síndrome | Padrão de erro\n");
printf("---------+---------------\n");
for i = 1:5
    for j = i+1:6
        for k = j+1:7
            for l = k+1:8
                g = zeros(1, 8);
                g(i) = 1; g(j) = 1; g(k) = 1; g(l) = 1;
                s = mod(g*H', 2);
                printf("%s     | %s\n", s + '0'*1, g + '0'*1)
            endfor
        endfor
    endfor
endfor