# Estrutura do Projeto Flutter - CRUD de Produtos

## 📁 Organização de Pastas

```
lib/
├── models/
│   └── product.dart                 # Modelo de Produto (com fromJson/toJson)
├── services/
│   └── product_service.dart         # Centraliza chamadas HTTP (CRUD completo)
├── presentation/
│   └── pages/
│       ├── product_screens.dart     # Screens: ListScreen, FormScreen, DetailScreen
│       └── [outras páginas...]
├── widgets/
│   ├── product_card.dart            # Card reutilizável para produtos
│   ├── product_form_field.dart      # Campo de formulário personalizado
│   ├── product_image_widget.dart    # Widget para exibir imagens com fallback
│   └── index.dart                   # Exportação centralizada
├── state/
│   ├── provider/                    # Gerenciamento com Provider
│   ├── riverpod/                    # Gerenciamento com Riverpod
│   └── bloc/                        # Gerenciamento com BLoC
└── main.dart
```

## 🔧 Componentes Implementados

### 1. **models/product.dart**
- ✅ Classe `Product` completa
- ✅ Método `fromJson()` para converter dados da API
- ✅ Método `toJson()` para enviar dados ao servidor
- ✅ Método `copyWith()` para criar cópias modificadas
- ✅ Campos: id, name, price, description, image, favorite

### 2. **services/product_service.dart**
Centraliza todas as chamadas HTTP com a API (https://fakestoreapi.com/products)

**Métodos disponíveis:**
- ✅ `fetchProducts()` - GET todas os produtos
- ✅ `fetchProductById(id)` - GET um produto específico
- ✅ `fetchProductsByCategory(category)` - GET por categoria
- ✅ `addProduct(product)` - POST novo produto
- ✅ `updateProduct(product)` - PUT atualizar produto
- ✅ `deleteProduct(id)` - DELETE produto
- ✅ `fetchProductsWithLimit(limit)` - GET com limite
- ✅ `fetchProductsSorted({sort, limit})` - GET ordenado

**Tratamento de erros:**
- Captura exceções e retorna mensagens claras
- Status HTTP validados (200, 201, etc.)

### 3. **presentation/pages/product_screens.dart**
Três screens completas e integradas:

#### **ProductListScreen**
- FutureBuilder para carregar produtos
- RefreshIndicator para recarregar
- ListTile/ProductCard para cada item
- Botões de ação (Editar, Deletar, Favoritar)
- FloatingActionButton para novo produto
- Tratamento de erros e loading

#### **ProductFormScreen**
- Form validado com GlobalKey<FormState>
- Reutiliza a mesma tela para Criar e Editar
- Campos: Nome, Preço, Descrição, Imagem
- Validadores customizados
- Integração com ProductService (POST/PUT)

#### **ProductDetailScreen**
- Exibe informações completas do produto
- Imagem em tamanho maior
- Botões de ação (Editar, Deletar, Favoritar)
- Navegação entre telas
- Atualização de estado local

### 4. **widgets/index.dart**
Componentes reutilizáveis:

#### **ProductCard**
- Exibe imagem do produto
- Informações principais (nome, descrição, preço)
- Botão de favorito com feedback visual
- Callbacks para ações (editar, deletar)
- Elevação e sombra para profundidade

#### **ProductFormField**
- Campo de texto personalizado
- Suporta múltiplas linhas
- Validação integrada
- Estilos consistentes (border, fill, focus)

#### **ProductImageWidget**
- Carrega imagens de URL
- Fallback quando URL vazia
- Tratamento de erro (imagem quebrada)
- Loading indicator durante download
- Opções de BoxFit e dimensões

## 🚀 Como Usar

### Exemplo 1: Listar Produtos
```dart
import 'presentation/pages/product_screens.dart';

// Usar a ProductListScreen
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const ProductListScreen()),
);
```

### Exemplo 2: Criar/Editar Produto
```dart
// Criar novo
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const ProductFormScreen()),
);

// Editar existente
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => ProductFormScreen(product: myProduct),
  ),
);
```

### Exemplo 3: Usar ProductService diretamente
```dart
import 'services/product_service.dart';

final service = ProductService();

// Buscar todos
final products = await service.fetchProducts();

// Buscar por ID
final product = await service.fetchProductById('1');

// Adicionar
final newProduct = await service.addProduct(Product(...));

// Atualizar
await service.updateProduct(product);

// Deletar
await service.deleteProduct(productId);
```

### Exemplo 4: Usar um Widget
```dart
import 'widgets/index.dart';

// Card de produto
ProductCard(
  product: myProduct,
  onTap: () { /* ação */ },
  onEdit: () { /* editar */ },
  onDelete: () { /* deletar */ },
);

// Campo de formulário
ProductFormField(
  label: 'Nome',
  controller: nameController,
  validator: (value) => value?.isEmpty ?? true ? 'Obrigatório' : null,
);
```

## 📋 Padrões Utilizados

### Gerenciamento de Estado
- **Screens simples**: Usam `setState()` e `FutureBuilder`
- **Projetos maiores**: Integração com Provider, Riverpod ou BLoC (pastas em `lib/state/`)

### Navegação
- MaterialPageRoute para transições padrão
- Passing data via constructor
- Pop com resultado para sincronizar estado

### Tratamento de Erros
- Try-catch em métodos async
- SnackBar para feedback do usuário
- AlertDialog para confirmações

### Validação
- GlobalKey<FormState> com validators
- Mensagens de erro específicas
- Desabilitação de botão durante envio

## 🔄 Fluxo CRUD Completo

```
ProductListScreen
├── FutureBuilder → ProductService.fetchProducts()
├── Exibe ProductCards
│   ├── Botão Editar → ProductFormScreen(product)
│   │   └── Submit → ProductService.updateProduct()
│   ├── Botão Deletar → Dialog
│   │   └── Confirmar → ProductService.deleteProduct()
│   └── Botão Detalhes → ProductDetailScreen
├── FloatingActionButton → ProductFormScreen()
│   └── Submit → ProductService.addProduct()
└── RefreshIndicator → Recarrega lista
```

## ⚠️ Notas Importantes

1. **API Base**: `https://fakestoreapi.com/products`
2. **Campos mapeados**: 
   - `title` (API) → `name` (Model)
   - `image` (API) → `image` (Model)
3. **Inicializar state em initState()** para FutureBuilder
4. **Sempre usar dispose()** para controllers de TextEditingController
5. **Validação em FormField** antes de submitir
6. **Feedback visual** durante operações assíncronas (loading, snackbar)

## 🎨 Componentes Visuais

- **Card**: Elevation 4 com margem
- **AppBar**: Sem elevation por padrão
- **Buttons**: ElevatedButton para ações principais
- **Icons**: Material icons padrão (edit, delete, favorite, etc.)
- **Cores**: Verde para preço, vermelho para favorito, cinza para erros

## 🧪 Próximos Passos (Opcional)

1. **Provider Integration**: Migrar estado das screens para ChangeNotifier
2. **Riverpod Hooks**: Usar flutter_riverpod com hooks
3. **BLoC Pattern**: Implementar ProductBloc para CRUD
4. **Paginação**: Adicionar infinite scroll na listagem
5. **Filtros**: Search, ordenação, filtros por categoria
6. **Imagens Locais**: Cache de imagens com cached_network_image
7. **Testes**: Unit tests para ProductService, Widget tests para screens

---

**Estrutura pronta para produção com todas as melhores práticas Flutter! 🚀**
