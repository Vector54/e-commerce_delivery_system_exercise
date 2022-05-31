# README

Este projeto trata-se de uma atividade de estudo e avaliação do Treinadev8, nela estou a aprender sobre ferramentas do ruby e rails, e suas aplicações na construção e manutenção de uma aplicação web.

O projeto se define por uma plataforma de comunicação entre empresas *delivery* e clientes no geral. Nela várias empresas podem ser associadas, e cada uma terá acesso a funcionalidades como cadastro de veículos, atualização de OS's e designação de preços. Cada empresa terá um domínio de e-mail do qual funcionários possuirão acesso. Estes então, após confirmação no seu e-mail, irão poder acessar a plataforma para executar as funcionalidades da transportadora atrelada (sendo assim, o usuário só possuirá acesso às informações desta).

Do outro lado temos administradores que irão confirmar sua conta e logar com o domínio "sistemadefrete.com", diferenciando este usuário dos demais. Estes terão acesso as informações de todas as empresas, assim como também poderão inscrever estas na plataforma. Não só isso, eles são os responsáveis por criar as OS's e desativar ou reativar empresas cadastradas.

Por fim, tem-se uma funcionalidade para o visitante não autenticado, o qual pode pesquisar uma OS a partir de um código alfanumérico provido por seu *e-commerce*.

Algumas informações básicas sobre a aplicação:

* Versão do Ruby: 3.0.0

* Versão do Bundler: 2.2.3

* Versão do Rails: 7.0.3
* [Inicialização e demais processos.](#inicialização)
* [Serviços da aplicação.](#serviços)
* [Apêndice](#apêndice)

# Inicialização:
* Execute o bundle install para instalar as demais dependências;

* Para realizar as migrações necessárias, rode o comando:
```
$ rails db:migrate
```
* A gem de testes é RSpec, que pode ser acionada pelo comando:
```
$ rspec
```
* Para rodar a aplicação na sua máquina, rode o seguinte comando e acesse no seu browser o link do localhost:3000.
```
$ rails server
```
* Para confirmar os Admins e usuários acesse o rails console e digite o seguinte:
```
$ rails console
3.0.0 :001 > a = Admin.last
3.0.0 :002 > a.confirm 

```
# Serviços:

  ## 1.Transportadora
  ### 1.1 Atributos:
  * Nome: este é obrigatório
  * Razão social: este é obrigatório.
  * Domínio de e-mail: este será usado para validar o login dos usuários. É obrigatório e tem de estar formatado assim: "domínio.extensão.ext.ext..."
  * CNPJ: é obrigatório e tem de estar formatado.
  * Endereço para faturamento: é obrigatório.
  * Ativo: booleana que restringe funcionamento da empresa na plataforma.
  ### 1.2 Ações do model:
  * Define seu próprio status e preço mínimo inicial (PS: define mais coisas comentadas no [apêndice](#apêndice))     
  * Possui vários usuários.
  * Demais dependentes: veículos, linhas de preço, linhas de prazo e ordens de serviço.

  ## 2. Administradores (DEVISE)
  ### 2.1 Alterações no model:
  * Valida o formato do domínio de e-mail: tem de ser "email@sistemadefrete.com"

  ## 3. Usuários (DEVISE)
  ### 3.1 Alterações no model:
  * Pertencem a uma transportadora.
  * Quando criado, faz-se a atribuição a sua empresa a partir da leitura do domínio.

  ## 4. Ordens de serviço
  ### 4.1 Atributos
  * Status: define 4 estados da ordem que são pendete, ativa, finalizada e negada, respectivamente.
  * Admin responsável: a os guarda o admin responsável por sua criação.
  * Data de entrega: calculada pela distância no ato de criação.
  * Código: código alfanumérico de 15 caracteres em caixa alta que identifica cada OS. Este também é feito automaticamente.
  * Transportadora: transportadora atrelada.
  * Distância: distância total da entrega. Tem de ser calculada pelo Admin.
  * Endereço de entrega: obrigatório.
  * Endereço de retirada: obrigatório.
  * Dimensões: largura, altura, profundidade e peso. São usadas no cálculo de preço.
  * CPF: CPF do destinatário.
  * Valoŕ: preço total da operação. Calculado automaticamente.
  * Veículo.
  ### 4.2 Ações no model:
  * Pertencem a um Admin e a uma transportadora.
  * Possui muitas linhas de atualização.
  * Possui 4 estados como definido anteriormente:
    1. Pendente: OS foi feita e está para ser aceita ou negada pela transportadora.
    2. Ativa: OS foi aceita, possui um veículo atrelado e recebe atualizações.
    3. Finalizada: pedido foi concluído com sucesso.
    4. Cancelada: quando o pedido é negado pela transportadora.
  * Na criação é configurado o status (pendente), o código de rastreio, a data de entrega e o valor total.
    * No valor total é incluído o cálculo com o valor mínimo. Isto é, se o volume ou o peso forem menores do que qualquer definição da lista, o valor total será calculado com o valor mínimo por Km.
  * É feita a validação da transportadora por seu booleano de ativação.
  * Também é feita a validação do veículo que divide em:
    1. Ser obrigatório a presença do veículo quando a OS está ativa.
    2. O veículo não pode estar em outra ordem ativa, pois só fará uma entrega de cada vez.
  
  ## 5. Veículos
  ### 5.1 Atributos:
  * Placa: obrigatório.
  * Modelo de marca: obrigatório.
  * Ano de fabricação.
  * Capacidade de carga: obrigatório.
  ### 5.2 Ações no model:
  * Pertence a transportadora.
  * Validações simples de presença (ver comentário do [apêndice](#apêndice)).
  ### 5.3 Mais umas coisas:
  * Possui CRUD completo.

  ## 6. Linhas de preço:
  ### 6.1 Atributos
  * Volume máximo e mínimo.
  * Peso máximo e mínimo.
  * Valor por Km.
  * Preço mínimo pode ser atualizado pelo usuário.
  * Todos obrigatórios.
  ### 6.2 Ações no model:
  * Possui validações que não permitem cadastro de mínimos com valores maiores que máximos.
  * Possui validação de intersecção de dados. No caso, pode-se cadastrar várias linhas com volumes interseccionados, desde que os *ranges* de pesos dessas não o façam tambem, e vice-versa. Isso impede o sistema de consulta e cálculo de preços de encontrar ambiguidades, e assim não deixar passar algumas linhas.
    * Para essa validação a comparação é feita com cada linha, permitindo cadastro futuro de linhas intermedárias.

  ## 7. Linhas de prazo:
  ### 7.1 Atributos: 
  * Distância inicial e final.
  * Prazo útil de entrega.
  * Todos obrigatórios.
  ### 7.2 Ações no model:
  * Validações similares às de [linhas de preço](#62-ações-no-model), onde a distância mínima não pode ser maior que a máxima e o *range* não pode interseccionar com outras linhas.

  ## 8. Linhas de Atualização:
  ### 8.1 Atributos:
  * Coordenadas e data/hora de criação.
  * Coordenadas são obrigatórias e devem estar formatadas, enquanto que a data/hora é gerado automaticamente.

  ## 9. Queries:
  ### 9.1 Consulta de OS:
  * Pode ser acessada por qualquer pessoa e, a partir do código escrito corretamente, trás a página da OS com seus respectivos detalhes.
  ### 9.2 Consulta de Orçamento:
  * Disponível apenas para Admins, esta, a partir de informações necessárias para cálculo de preço e prazo (largura, altura, profundidade, peso e distância), trás uma lista de transportadoras com seus respectivos preços e prazos associados. O nome de cada empresa é um link para sua página, onde o Admin pode então fazer sua OS.

  ## 10. Autenticações:
  ### 10.1 Admin:
  * Pode acessar consulta de OS, consulta de orçamento, lista e cadastro de tranportadoras e OS's, e demais páginas (embora não haja links para estas ainda).
  ### 10.2 Usuário:
  * Pode acessar consulta de OS, sua transportadora, suas OS's, seus veículos e seus preços e prazos. Incluindo páginas de CRUD.
  * Não pode acessar consulta de orçamento, lista e cadastro de transportadoras e cadastro de OS's.
  ### 10.3 Visitante:
  * Não autenticado.
  * Só pode acessar a consulta de OS's (e as páginas de *Login*).


# Apêndice:
## Sobre as tabelas de preço e prazo
No momento de criação destas, eu estava no começo e não me toquei que não havia necessidade. Mas após notar o trabalho a mais que isso me custou, resolvi deixar permanecer, e desenvolver o resto das funções a redor disto.
## Sobre os veículos
Eu imagino que a inclusão do campo "capacidade de carga" venha da necessidade da restrição de escolha de veículos para a OS, já que, a depender da carga alguns caminhões não vão poder levar. Por enquanto não implementei, mas vou pensar nisso.
## Sobre endereços e coordenadas
Pela descrição do projeto, imaginei que as *features* de localização, como *input* de endereços e cáculo de distância, fossem planejadas para serem feitas por API do Google ou algo do tipo. Infelizmente não soube fazer nem tive tempo de encaixar a API na aplicação, por isso fiz do jeito mais "cru". 
## Comentário pessoal

Após vários dias de desventuras e desistências, consegui me levantar e desenvolver a aplicação. Aprendi muito, me frustrei muito e adorei a experiência. Agradeço muito à equipe e a turma do Treinadev8, e também minha família, pela assistência e suporte na feitura desse projeto. Espero poder continuar no curso e, adiante, no trabalho de developer.