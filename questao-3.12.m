# Questão 3.12 da lista de exercícios
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

# Monta a lista de síndromes com o erro mais provável associado. Cada
# elemento da lista é o padrão de erro associado à síndrome.
syndrome_list = zeros(16, 8);
for i = 1:length(coset)
    synd = mod(coset(i,:)*H', 2);
    synd_idx = synd*[8 4 2 1]';
    syndrome_list(synd_idx + 1, :) = coset(i,:);
endfor

nibble_list = ones(1, 256) * -1;
for i = 1:length(v)
    idx = v(i,:)*[128 64 32 16 8 4 2 1]';
    nibble_list(idx + 1) = i - 1;
endfor

# Função para fazer a decodificação de um codeword recebido
function bytes = decode(codeword, H, syndrome_list, nibble_list)
    printf("Decodificando codeword %s\n", codeword+'0'*1);
    synd = mod(codeword*H', 2);
    err = zeros(1, 8);
    synd_idx = synd*[8 4 2 1]';
    if (synd_idx != 0)
        printf("Codeword enviado com síndrome não-nula (%d)! Corrigindo para a codeword mais provável...\n", synd_idx);
        err = syndrome_list(synd_idx + 1,:);
        printf("Padrão de erro mais provável: %s\n", err+'0'*1);
        codeword = mod(codeword + err, 2);
        printf("Codeword mais provável: %s\n", codeword+'0'*1);
    endif

    bytes = dec2bin(nibble_list(codeword*[128 64 32 16 8 4 2 1]' + 1), 4);
endfunction