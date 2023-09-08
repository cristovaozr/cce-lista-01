# Questão 3.09 da lista de exercícios
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

# Função peso de Hamming
w = @(x) x*ones(8,1);

printf("Pesos de C(8, 4):\n");
for i = 1:16
    printf("w(%s) == %d\n", v(i,:) + '0'*1, w(v(i,:)))
endfor
