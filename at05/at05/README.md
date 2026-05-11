# mobile_arquitetura_01

Aplicativo Flutter desenvolvido para consumir a API pública de produtos do FakeStore e exibir uma lista de produtos.

## Arquitetura

O código está organizado em camadas:

- `presentation` — UI e widgets de exibição
- `domain` — entidades e contratos de repositório
- `data` — modelos, datasource remoto e implementação do repositório
- `core` — constantes e tratamento de exceções

## Requisitos implementados

- Consome a API pública: `https://fakestoreapi.com/products`
- Converte os dados JSON em objetos da aplicação
- Exibe título, preço e imagem de cada produto
- Organiza o código em camadas com separação de responsabilidades

## Execução

1. Abra o terminal na pasta do projeto
2. Execute `flutter pub get`
3. Execute `flutter run`

## Observações

A requisição é feita pelo `ProductRemoteDataSourceImpl` com `http.Client`.
A `ProductRepositoryImpl` expõe o contrato `ProductRepository` para a camada de apresentação.

ag