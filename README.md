# BookHub - Clube de Assinatura de Livros

## 1: Cenário

### Cenário: Clube de Assinatura de Livros

O "BookHub" é um clube de assinatura que oferece aos seus membros uma seleção personalizada de livros todo mês. Os membros pagam uma taxa mensal para receber livros baseados em suas preferências de gênero, autor, e histórico de leitura. Além disso, eles podem comprar livros adicionais com desconto.

Para gerenciar todas as operações do BookHub, é necessário um sistema de banco de dados que atenda às seguintes necessidades:

#### Membros:

- Cada membro possui um ID único, nome, email, endereço (composto por rua, número, cidade, estado e CEP), número de telefone e data de nascimento.
- Os membros podem ter múltiplos endereços de entrega e números de telefone.
- A data de adesão ao clube é derivada da data de registro.

#### Livros:

- Cada livro tem um ID único, título, autor (composto por primeiro nome e sobrenome), gênero, data de publicação e preço.
- Cada livro pode pertencer a múltiplos gêneros.

#### Assinaturas:

- Cada membro tem uma assinatura que define o plano (ID único, tipo de plano e valor mensal).
- Um membro pode mudar de plano e a data de início e término do plano atual é registrada.
- Cada plano é único para um membro em um dado momento.

#### Pedidos:

- Cada pedido possui um ID único, data do pedido, status do pedido (processado, enviado, entregue), e total do pedido.
- Um pedido pode incluir múltiplos livros e cada livro pode ser parte de múltiplos pedidos (relação muitos-para-muitos).
- A quantidade de cada livro no pedido é registrada.

#### Preferências:

- Cada membro pode selecionar seus gêneros preferidos.
- As preferências ajudam a personalizar a seleção de livros mensal.

### Resumindo as entidades e seus relacionamentos:

**Entidades:** Membros, Livros, Assinaturas, Pedidos, Preferências.

**Relacionamentos:**
- Um membro pode ter uma ou mais assinaturas (1).
- Um membro pode ter múltiplos endereços (1).
- Um membro pode fazer múltiplos pedidos (1).
- Um pedido pode conter múltiplos livros e cada livro pode estar em múltiplos pedidos (N).
- Cada membro pode selecionar múltiplos gêneros como preferência (N).


