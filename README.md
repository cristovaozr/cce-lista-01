# Lista 01 - Códigos Corretores de Erro

Este repositótio contém as soluções que eu fiz para as questões da Lista 01 da disciplina de Códigos Corretores de Erro da UFPE 2023.2.

As soluções estão escritas nas seguintes linguages de programação
* Octave/Matlab

## Execução das soluções disponíveis

Ao rodar o `octave-cli` uma das possibilidades é fazer
```bash
octave:1> source questao-3.09.m
# A saída da execução será colocada aqui
```

## Resumo das soluções das questões

### Questão 3.09
O arquivo `questao-3.09.m` contém um código que ajudou a determinar os pesos de todas as palavras-código do código sugerido na questão 3.1.

A saída da execução é o peso de cada uma das palavras-código do código C(8, 4)

### Questão 3.10
O arquivo `questao-3.10.m` gera todo o arranjo padrão do código da questão 3.1, além da tabela de decodificação de síndrome.

### Questão 3.12
O arquivo `questao-3.12.m` fornece uma função que causa a decodificação de uma palavra-código que pertence ao código da questão 3.1. Um exemplo de uso segue:

```bash
octave:1> source questao-3.12.m

octave:2> decode(v(13,:), H, syndrome_list, nibble_list)
Decodificando codeword 10011100
ans = 1100

octave:3> decode(v(13,:)+[0 0 1 0 0 0 0 0], H, syndrome_list, nibble_list)
Decodificando codeword 10111100
Codeword enviado com síndrome não-nula (2)! Corrigindo para a codeword mais provável...
Padrão de erro mais provável: 00100000
Codeword mais provável: 10011100
ans = 1100
```

Para mais informações sobre as variáveis usadas na entrade `decode()` ler os comentários do arquivo `questao-3.12.m`