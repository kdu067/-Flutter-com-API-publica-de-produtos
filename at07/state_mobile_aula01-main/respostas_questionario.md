# Respostas do Questionário - Flutter com Múltiplas Telas

**1. Qual era a estrutura do seu projeto antes da inclusão das novas telas?**
O projeto original possuía apenas uma tela principal (`HomePage`) que servia como um menu listando diferentes exemplos de gerenciamento de estado (Provider, Riverpod, BLoC). A listagem de produtos com seus respectivos estados ficava concentrada em telas únicas de demonstração, como a `ProductsProviderPage`, utilizando dados "mockados" localmente sem detalhes aprofundados (apenas id, nome e preço).

**2. Como ficou o fluxo da aplicação após a implementação da navegação?**
O fluxo agora segue um padrão linear de 3 níveis:
`Tela Inicial (HomePage)` → `Tela de Produtos (ProductsProviderPage)` → `Tela de Detalhes do Produto (ProductDetailsPage)`.
O usuário inicia na `HomePage` e, ao clicar em "Ver Produtos", é levado à lista carregada via API. Ao clicar em um item específico da lista, ele avança para a `ProductDetailsPage`, que exibe todos os dados daquele produto.

**3. Qual é o papel do Navigator.push() no seu projeto?**
O `Navigator.push()` é utilizado para adicionar uma nova rota (tela) ao topo da pilha de navegação. Ele foi usado na `HomePage` para navegar até a `ProductsProviderPage` e, em seguida, na `ProductsProviderPage` para navegar até a `ProductDetailsPage` quando um produto é selecionado.

**4. Qual é o papel do Navigator.pop() no seu projeto?**
O `Navigator.pop()` é responsável por remover a tela atual do topo da pilha de navegação, retornando o usuário para a tela anterior. Ele é chamado automaticamente pelo Flutter ao utilizarmos a seta de voltar na `AppBar` da `ProductDetailsPage` e da `ProductsProviderPage`.

**5. Como os dados do produto selecionado foram enviados para a tela de detalhes?**
Os dados foram passados via construtor. A classe `ProductDetailsPage` foi definida para receber um objeto do tipo `Product` como parâmetro obrigatório (`required this.product`). Assim, na listagem, ao chamar o `Navigator.push()`, a página foi instanciada injetando o produto correspondente: `ProductDetailsPage(product: product)`.

**6. Por que a tela de detalhes depende das informações da tela anterior?**
A tela de detalhes é genérica, ela apenas sabe *como* exibir as informações de um produto, mas não sabe *qual* produto exibir de forma autônoma. Ela depende que a tela anterior (a lista) informe qual foi o item clicado para que possa renderizar as informações corretas (imagem, descrição, preço e título) pertencentes especificamente àquele item.

**7. Quais foram as principais mudanças feitas no projeto original?**
- Adição da dependência `http` para consumir a FakeStoreAPI.
- Atualização do modelo `Product` para suportar novos campos (`description` e `image`) e um método `fromJson` para realizar o parse dos dados da API.
- Refatoração da classe `ProductsProvider` para substituir os dados mockados por uma requisição HTTP real `fetchProducts()`, incluindo tratamento de estado de carregamento e erro.
- Criação da tela `ProductDetailsPage` para exibição aprofundada dos produtos.
- Simplificação da `HomePage` para atuar puramente como ponto de entrada da aplicação.
- Implementação de navegação e passagem de parâmetros através do `Navigator` na lista de produtos.

**8. Quais dificuldades você encontrou durante a adaptação do projeto para múltiplas telas?**
A principal adaptação foi reestruturar o consumo de dados da API mantendo o projeto consistente. Substituir um modelo fixo por dados dinâmicos exigiu o tratamento de estados de carregamento (`isLoading`) para não mostrar uma lista vazia ou quebrar a tela antes de a API retornar. Além disso, foi necessário lidar com a passagem do objeto complexo `Product` através das rotas e garantir a adaptação dos tipos de dados (como converter adequadamente os IDs e prever campos opcionais do JSON).
