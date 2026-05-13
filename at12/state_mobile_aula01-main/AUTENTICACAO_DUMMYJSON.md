# Implementação de Autenticação com DummyJSON

## Resumo das Alterações

Este documento descreve as alterações realizadas para implementar um fluxo de autenticação com DummyJSON no projeto Flutter.

### 1. Dependências Adicionadas
- `shared_preferences: ^2.2.2` - Para armazenar token e dados de usuário

### 2. Novos Arquivos Criados

#### Modelos
- **lib/models/user.dart** - Modelo de usuário com serialização JSON

#### Serviços
- **lib/services/auth_service.dart** - Serviço de autenticação com DummyJSON
- **lib/services/session_service.dart** - Gerenciamento de sessão com SharedPreferences

#### State Management
- **lib/state/provider/auth_provider.dart** - Provider para autenticação

#### Páginas
- **lib/presentation/pages/login_page.dart** - Tela de login com validação

### 3. Arquivos Modificados

#### lib/pubspec.yaml
- Adicionada dependência `shared_preferences`

#### lib/main.dart
- Adicionado `AuthProvider` ao MultiProvider
- Criado `AuthWrapper` para roteamento baseado em autenticação
- Adicionadas rotas nomeadas

#### lib/models/product.dart
- Atualizado método `fromJson()` para suportar campo `thumbnail` (DummyJSON)

#### lib/services/product_service.dart
- Alterada URL base para `https://dummyjson.com/products`
- Atualizado método `fetchProducts()` para trabalhar com estrutura DummyJSON

#### lib/presentation/pages/products_provider_page.dart
- Adicionado suporte ao `AuthProvider`
- Exibição do nome do usuário autenticado no AppBar
- Botão de logout no menu

## Fluxo de Autenticação

1. **Inicialização**: O app verifica se existe um usuário autenticado em cache
2. **Login**: Se não autenticado, usuário é direcionado para LoginPage
3. **Validação**: Campos são validados (usuário e senha obrigatórios)
4. **Autenticação**: POST para `/auth/login` da DummyJSON
5. **Armazenamento**: Token e dados do usuário são salvos em SharedPreferences
6. **Redirecionamento**: Usuário é redirecionado para ProductsProviderPage
7. **Logout**: Ao clicar em logout, sessão é limpa e usuário retorna para LoginPage

## Credenciais de Teste (DummyJSON)

O aplicativo vem pré-configurado com credenciais de teste:

| Usuário | Senha |
|---------|-------|
| emilys | emilyspass |
| kminchelle | 0lelplR |

Outras credenciais disponíveis em: https://dummyjson.com/users

## Estrutura de Diretórios

```
lib/
├── models/
│   ├── product.dart
│   └── user.dart (NOVO)
├── services/
│   ├── product_service.dart (MODIFICADO)
│   ├── auth_service.dart (NOVO)
│   └── session_service.dart (NOVO)
├── state/
│   └── provider/
│       ├── auth_provider.dart (NOVO)
│       ├── products_provider.dart
│       └── counter_provider.dart
└── presentation/
    └── pages/
        ├── login_page.dart (NOVO)
        └── products_provider_page.dart (MODIFICADO)
```

## Como Usar

1. Execute `flutter pub get` para instalar as dependências
2. Execute `flutter run` para iniciar o app
3. Na tela de login, utilize uma das credenciais de teste
4. Após login bem-sucedido, a lista de produtos será exibida
5. Clique no menu (três pontos) no AppBar para fazer logout

## Endpoints da API

### DummyJSON Autenticação
- POST `/auth/login` - Realiza login
  - Body: `{ "username": "string", "password": "string" }`
  - Response: Retorna objeto User com token

### DummyJSON Produtos
- GET `/products` - Lista todos os produtos
- GET `/products/{id}` - Obtém detalhes de um produto
- GET `/products/category/{category}` - Produtos por categoria

## Segurança

- Token é armazenado localmente em SharedPreferences
- Sessão persiste entre aberturas do app
- Logout limpa completamente a sessão
- Credenciais são enviadas apenas na primeira autenticação

## Próximos Passos (Opcionais)

- Implementar refresh token
- Adicionar autenticação por biometria
- Implementar logout automático por timeout
- Adicionar criptografia para dados em cache
