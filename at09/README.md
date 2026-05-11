# Gerenciador de Produtos com Flutter

Uma aplicação Flutter bem estruturada para gerenciar produtos através de uma API REST. Implementa operações CRUD completas (Create, Read, Update, Delete).

## Estrutura do Projeto

```
lib/
├── main.dart                    # Ponto de entrada da aplicação
├── models/
│   └── product.dart            # Modelo da classe Product com fromJson/toJson
├── services/
│   └── product_service.dart    # Serviço centralizado de chamadas de API
├── screens/
│   ├── product_list_screen.dart      # Tela de listagem de produtos
│   ├── product_form_screen.dart      # Tela de formulário (criar/editar)
│   └── product_detail_screen.dart    # Tela de detalhes do produto
└── widgets/
    ├── product_card.dart            # Widget reutilizável para cartão
    └── product_form_field.dart      # Widget reutilizável para campo de formulário
```

## Funcionalidades

- ✅ **Listagem**: Visualizar todos os produtos com FutureBuilder
- ✅ **Criar**: Adicionar novo produto via formulário
- ✅ **Editar**: Modificar informações de um produto existente
- ✅ **Deletar**: Remover produtos com confirmação
- ✅ **Detalhes**: Visualizar informações completas de um produto
- ✅ **Validação**: Validação de dados em formulários
- ✅ **Tratamento de erros**: Feedback ao usuário em caso de falhas
- ✅ **Loading states**: Indicadores de carregamento

## Componentes Principais

### 1. Modelo (Product)
```dart
class Product {
  final String? id;
  final String name;
  final double price;
  final String description;
  final String? imageUrl;
  
  // Métodos para conversão JSON
  factory Product.fromJson(Map<String, dynamic> json) { ... }
  Map<String, dynamic> toJson() { ... }
}
```

### 2. Serviço de API (ProductService)
Centraliza todas as requisições HTTP:
- `fetchProducts()` - GET lista completa
- `fetchProductById(String id)` - GET um produto específico
- `addProduct(Product product)` - POST novo produto
- `updateProduct(Product product)` - PUT atualização
- `deleteProduct(String id)` - DELETE produto

### 3. Telas

#### ProductListScreen
- Listagem com FutureBuilder
- Botão FAB para novo produto
- Ações diretas: editar, deletar
- Tratamento de carregamento e erros

#### ProductFormScreen
- Formulário reutilizável para criar ou editar
- Validação de campos obrigatórios
- Confirmação de sucesso/erro
- Imagem opcional

#### ProductDetailScreen
- Exibição completa das informações
- Imagem em destaque
- Botões para editar ou voltar

### 4. Widgets Reutilizáveis

#### ProductCard
- Exibição de produto em card
- Imagem com fallback
- Informações essenciais
- Botões de ação

#### ProductFormField
- Campo de entrada padronizado
- Validação integrada
- Suporte para múltiplas linhas
- Tipos de teclado diferentes

## Instalação

### 1. Clonar/Configurar o Projeto
```bash
cd seu-projeto-flutter
flutter pub get
```

### 2. Configurar a API

Abra `lib/services/product_service.dart` e altere a URL base:

```dart
static const String baseUrl = 'https://sua-api.com/produtos';
```

### Exemplos de APIs Públicas para Testar

#### Usando JSONPlaceholder (para testes rápidos)
```dart
// Adapte o endpoint em product_service.dart
static const String baseUrl = 'https://jsonplaceholder.typicode.com/posts';
```

#### Usando uma API de E-commerce Real
- **Fake Store API**: https://fakestoreapi.com/products
- **DummyJSON**: https://dummyjson.com/products

### 3. Adaptar o Modelo (se necessário)

Se sua API retorna campos diferentes, adapte `Product.fromJson()`:

```dart
factory Product.fromJson(Map<String, dynamic> json) {
  return Product(
    id: json['id'].toString(),
    name: json['title'] ?? json['name'] ?? 'Sem nome',
    price: (json['price'] as num?)?.toDouble() ?? 0.0,
    description: json['description'] ?? '',
    imageUrl: json['image'] ?? json['imageUrl'],
  );
}
```

## Como Usar

### Iniciar a Aplicação
```bash
flutter run
```

### Fluxo Típico

1. **Home (ProductListScreen)**
   - Exibe lista de produtos
   - Clique em um produto → **Detalhes**
   - Botão Editar → **Formulário (edição)**
   - Ícone Deletar → Confirma exclusão
   - FAB (+) → **Formulário (criação)**

2. **Criar/Editar (ProductFormScreen)**
   - Preencha os campos
   - Clique em "Criar" ou "Atualizar"
   - Sucesso/Erro → Retorna para lista

3. **Detalhes (ProductDetailScreen)**
   - Visualiza todas as informações
   - Botão "Editar Produto" → vai para formulário
   - Botão "Voltar" → retorna à lista

## Gerenciamento de Estado

Este projeto usa **setState** para simplicidade. Para projetos maiores, considere:

### Usar Provider
```dart
// pubspec.yaml
dependencies:
  provider: ^6.0.0
```

### Usar Bloc
```dart
// pubspec.yaml
dependencies:
  flutter_bloc: ^8.0.0
  bloc: ^8.0.0
```

Exemplos podem ser adicionados em um futuro update.

## Tratamento de Erros

A aplicação trata:
- ✅ Erros de conexão
- ✅ Timeouts
- ✅ Respostas inválidas
- ✅ Validação de formulário
- ✅ Feedback ao usuário via SnackBar

## Melhorias Futuras

- [ ] Paginação na listagem
- [ ] Busca/filtro de produtos
- [ ] Cache local com Hive
- [ ] Gerenciamento com Provider/Bloc
- [ ] Testes unitários e de widget
- [ ] Autenticação (se necessária)
- [ ] Ordenação e categorização

## Dependências

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0           # Requisições HTTP
  provider: ^6.0.0       # Gerenciamento de estado (opcional)
```

## Testes

Para testar a aplicação:

```bash
# Rodar a aplicação
flutter run

# Build para release
flutter build apk    # Android
flutter build ios    # iOS
```

## Dúvidas Comuns

**P: Como conectar com minha API?**
R: Altere `baseUrl` em `ProductService` e adapte `Product.fromJson()` conforme necessário.

**P: Como adicionar autenticação?**
R: Adicione headers na requisição:
```dart
headers: {
  'Authorization': 'Bearer seu-token',
  'Content-Type': 'application/json',
}
```

**P: Como fazer cache?**
R: Use a biblioteca `hive` ou `sqflite` para persistência local.

**P: Como usar Bloc ao invés de setState?**
R: Crie BloCs para cada tela e injete via `context.read()`.

---

**Autor**: Seu Nome  
**Versão**: 1.0.0  
**Last Updated**: 2024
