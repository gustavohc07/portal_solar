[![Build Status](https://travis-ci.com/gustavohc07/portal_solar.svg?branch=master)](https://travis-ci.com/gustavohc07/portal_solar)

# Portal Solar - Dev Test

## Como executar?

Este projeto utiliza:

- Ruby versão `2.6.3`
- Rails versão `5.2`

Deve-se ter o postgres instalado no seu sistema. Após isso, execute:

`$ bundle exec rails db:create db:migrate db:seed`

Após isso, execute `bundle install` para instalar as gems necessárias para o projeto.

Você pode acessar o projeto aqui:

[Link do Heroku](https://ancient-wildwood-10268.herokuapp.com/)

## Funcionalidades implementadas

```
#### Requisitos Principais
 
 * Implementar uma funcionalidade de recomendação geradores de energia para o usuário utilizando os campos que existem no modelo de PowerGenerator. Em outras palavras, o usuário poderá informar alguns dados que possa ser utilizado para recomendar estes geradores de energia. Não se prenda a quantos e quais informações o usuário poderá informar. O algoritmo de escolha é livre, fique a vontade.
 
 * Implementar função para consultar o custo do frete (modelo Freight) baseado no CEP informado. Ao clicar no produto deve ser abrir uma modal, uma nova tela ou uma partial para tal função.
 Dica: Utilize alguma API pública para descobrir cidade e estado através do CEP, irá ajudar no processo de precificação do frete. 
 
 #### Requisitos Secundários
 
 * Implementar um filtro simples que ordene por preço na tela inicial, trazendo os resultados ordenados por nome e adicionando paginação para mostrar somente 6 itens por página.
 
 * Aplicar um segundo filtro baseado no anterior, ordenando por KWP.
 
 * Implementar função para calcular o peso cubado do produto e persistir isso no banco.
 Dica: [Cálculo para o peso cubado](https://blog.cargobr.com/cubagem-sem-misterio/) -> `Comprimento x Largura x Altura x Fator cubagem (300)`
 
 * Modificar consulta do custo do frete afim de trazer o valor com o PESO MENOR do produto, ou seja, o valor do frete não importa e sim o peso do produto.
 Dica: Verifique o valor baseado no peso do produto ou no peso cubado. (menor = melhor)
 
 * Fazer ao menos testes unitários para serviços e métodos criados para a recomendação de geradores, consulta de CEP e a busca simples por nome, mas não se limitando, testes são sempre bem vindos.
 
```

O projeto consistia em implementar 2 funcionalidades principais e
4 secundárias.

Foram implementadas as 2 funcionalidades principais e as 4 secundárias no projeto.

### Funcionalidades principais

A primeira funcionalidade consiste no usuário receber recomendações de geradores de acordo
com os inputs que foram selecionados. Para testas essa funcionalidade na prática, basta acessar
a página inicial, selecionar pesquisa avançada e fornecer os dados.
 
Não foram escolhidos dados técnicos de mais para o usuário a fim de não confundi-lo. 
Dados: 
- Capital Disponível - O quanto o usuário está disposto a gasta;
- Fabricante - Fabricantes disponíveis no site;
- Tipo de fixação - Onde as placas solares serão fixadas.

Não é necessário fornecer todosos dados.

A segunda funcionalidade consistia em pegar o CEP do usuário, cruzar
os dados obtidos com uma tabela de fretes da plataforma e mostrar o custo
final para o usuário, baseado no estado e no peso do gerador.

Para testá-la basta acessar a página inicial, clicar no nome de um gerador e
fornecer um CEP. O CEP fornecido irá bater em uma API pública de consulta
de frete e irá retornar um json com os dados para o CEP fornecido. Foi pego,
para esta funcionalidade em questão, apenas o estado do CEP, sendo que este
ajudava a determinar a faixa de valores para aquele estado.

Caso o usuário entre com um valor inválido de CEP, será renderizado na tela
uma mensagem dizendo que o CEP é inválido.

### Funcionalidades secundárias

As duas primeiras funcionalidades de implementar um filtro simples, uma para
o preço dos geradores e outra para o KWP, podem ser testadas, na prática, acessando
a página inicial, selecionar no menu dropdown por preço ou KWP e clicar em filtrar.

Essa funcionalidade pode ser aprimorada determinando se o usuário quer lista-los em ordem
crescente ou decrescente. Pode-se, ainda, acumular filtros. Nesse projeto me baseei em um filtro
simples, não cumulativo e sem a opção de ordenar por ordem crescente ou decrescente.

A terceira e a quarta funcionalidade não podem ser testadas de maneira visual. A funcionalidade de
calcular o peso cubado do produto foi realizado no `model` `PowerGenerator`. Essa funcionalidade,
para ser colocada em todos os objetos criados, foi criado uma função dentro do seed que popula a variável
`cubic_weight`.

A quarta funcionalidade consistia em utilizar o menor valor entre `weight` e `cubic_weight` para
calcular o valor do frete.


Em relação aos testes unitários, que seria uma quinta funcionalidade, já ia sendo implementado conforme o
desenvolvimento. Eram escritos os testes primeiro e depois o código de cada funcionalidade.

## Gems adicionais

Para este projeto foram adicionadas as seguintes gems:


`gem faraday` - para consumir API de CEP

`gem kaminari` - para paginação

`gem pg_search` - para minimizar o número de linhas ao buscar por termos nos geradores cadastrados

`gem factory_bot_rails` para facilitar na criação de dados para os testes

`gem rspec_rails` para escrever e executar os testes

`gem rubocop` e `gem rubocop-rails` para manter o mínimo
de qualidade de código.

`gem simplecov` para verificar a cobertura de testes.

## Outras informações

Durante todo o desenvolvimento foi utilizado o Travis para verificar se algum commit havia quebrado o código com
o que foi previamente estabelecido.