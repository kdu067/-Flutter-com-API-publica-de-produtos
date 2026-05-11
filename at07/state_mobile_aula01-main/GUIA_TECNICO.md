# 📖 Guia Técnico Detalhado - Sistema de Favoritos

## 🏗️ Arquitetura

A atividade segue um padrão de separação entre:
- **Modelos (Models)** - Definição de dados
- **Estado (State)** - Lógica de negócio
- **Apresentação (Presentation)** - Interface do usuário

```
Models (Dados)
    ↓
State Management (Lógica)
    ↓
Presentation (UI)
```

## 1️⃣ Modelo de Dados (Product)

### Arquivo: `lib/models/product.dart`

```dart
class Product {
  final String id;              // Identificador único
  final String name;            // Nome do produto
  final double price;           // Preço
  bool favorite;                // Status de favorito (mutável!)

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.favorite = false,      // Padrão: não é favorito
  });
}
```

**Conceitos-chave:**
- `final` para dados imutáveis (id, name, price)
- `bool favorite` é mutável (pode mudar)
- `this.favorite = false` valor padrão

---

## 2️⃣ Provider

### Arquivo: `lib/state/provider/products_provider.dart`

```dart
class ProductsProvider extends ChangeNotifier {
  final List<Product> _products = [
    // Lista com 6 produtos pré-definidos
  ];

  List<Product> get products => _products;
  
  void toggleFavorite(String productId) {
    final product = _products.firstWhere((p) => p.id == productId);
    product.favorite = !product.favorite;
    notifyListeners();  // ← Notifica subscribers sobre a mudança
  }
}
```

### Conceitos-chave:

**1. ChangeNotifier**
```dart
class ProductsProvider extends ChangeNotifier
```
- Mixin que permite notificar listeners sobre mudanças

**2. Mutação direta do estado**
```dart
product.favorite = !product.favorite;
```
- Os objetos são modificados in-place

**3. notifyListeners()**
```dart
notifyListeners();
```
- Notifica todos os widgets que escutam este provider

**4. Getters**
```dart
List<Product> get products => _products;
```
- Acesso de leitura dos dados

### Uso na UI: `lib/presentation/pages/products_provider_page.dart`

```dart
class ProductsProviderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 1. Obter o provider
    final productsProvider = context.watch<ProductsProvider>();
    
    // 2. Usar os dados
    return ListView.builder(
      itemCount: productsProvider.products.length,
      itemBuilder: (context, index) {
        final product = productsProvider.products[index];
        
        // 3. Chamar métodos
        IconButton(
          onPressed: () {
            productsProvider.toggleFavorite(product.id);
          },
          icon: Icon(
            product.favorite ? Icons.favorite : Icons.favorite_border,
          ),
        );
      },
    );
  }
}
```

**Fluxo:**
```
User clica → onPressed → toggleFavorite() 
→ notifyListeners() → context.watch() detecta mudança 
→ rebuild da UI
```

---

## 3️⃣ Riverpod

### Arquivo: `lib/state/riverpod/products_riverpod.dart`

```dart
class ProductsNotifier extends StateNotifier<List<Product>> {
  ProductsNotifier() : super([
    // Lista inicial de produtos
  ]);

  void toggleFavorite(String productId) {
    state = [
      for (final product in state)
        if (product.id == productId)
          Product(
            id: product.id,
            name: product.name,
            price: product.price,
            favorite: !product.favorite,  // ← Criar novo Product
          )
        else
          product,
    ];
  }
}

// Provider Riverpod
final productsProvider =
    StateNotifierProvider<ProductsNotifier, List<Product>>((ref) {
  return ProductsNotifier();
});

// Provider derivado para contador
final favoriteCountProvider = Provider<int>((ref) {
  final products = ref.watch(productsProvider);
  return products.where((p) => p.favorite).length;
});
```

### Conceitos-chave:

**1. StateNotifier**
```dart
class ProductsNotifier extends StateNotifier<List<Product>>
```
- Gerencia estado imutável
- Estende StateNotifier<T> onde T é o tipo do estado

**2. Imutabilidade**
```dart
state = [
  for (final product in state)
    if (product.id == productId)
      Product(...)  // ← Novo objeto, não modifica o antigo
    else
      product,
];
```
- Cria uma NOVA lista ao invés de modificar a antiga
- Cada mudança é detectável (novo estado ≠ estado antigo)

**3. Providers derivados**
```dart
final favoriteCountProvider = Provider<int>((ref) {
  final products = ref.watch(productsProvider);
  return products.where((p) => p.favorite).length;
});
```
- Providers que dependem de outros providers
- Recalculam automaticamente quando dependências mudam

**4. StateNotifierProvider**
```dart
final productsProvider =
    StateNotifierProvider<ProductsNotifier, List<Product>>
```
- Provider que gerencia um StateNotifier
- Tipos: `<NotifierType, StateType>`

### Uso na UI: `lib/presentation/pages/products_riverpod_page.dart`

```dart
class ProductsRiverpodPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Obter dados
    final products = ref.watch(productsProvider);
    final favoriteCount = ref.watch(favoriteCountProvider);
    
    // 2. Usar dados
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        
        // 3. Chamar métodos via notifier
        IconButton(
          onPressed: () {
            ref.read(productsProvider.notifier)
              .toggleFavorite(product.id);
          },
          icon: Icon(
            product.favorite ? Icons.favorite : Icons.favorite_border,
          ),
        );
      },
    );
  }
}
```

**Fluxo:**
```
User clica → onPressed → ref.read(notifier) → toggleFavorite()
→ state = [...] → ref.watch() detecta mudança 
→ rebuild da UI
```

---

## 4️⃣ BLoC

### Arquivos:

#### A. Events: `lib/state/bloc/products_event.dart`

```dart
abstract class ProductEvent {
  const ProductEvent();
}

class ToggleFavoriteEvent extends ProductEvent {
  final String productId;
  const ToggleFavoriteEvent(this.productId);
}
```

**Conceito:** Eventos são ações que o usuário deseja fazer

#### B. States: `lib/state/bloc/products_state.dart`

```dart
abstract class ProductState {
  const ProductState();
}

class ProductLoadedState extends ProductState {
  final List<Product> products;
  const ProductLoadedState(this.products);
}
```

**Conceito:** Estados representam situações da aplicação

#### C. BLoC: `lib/state/bloc/products_bloc.dart`

```dart
class ProductsBloc extends Bloc<ProductEvent, ProductState> {
  final List<Product> _products = [...];

  ProductsBloc() : super(const ProductInitialState()) {
    // Registra handlers para eventos
    on<ToggleFavoriteEvent>(_onToggleFavorite);
  }

  Future<void> _onToggleFavorite(
    ToggleFavoriteEvent event,
    Emitter<ProductState> emit,
  ) async {
    try {
      final product = _products.firstWhere(
        (p) => p.id == event.productId
      );
      product.favorite = !product.favorite;
      emit(ProductLoadedState(List.from(_products)));
    } catch (e) {
      emit(ProductErrorState('Erro: $e'));
    }
  }
}
```

### Conceitos-chave:

**1. Herança de Bloc**
```dart
class ProductsBloc extends Bloc<ProductEvent, ProductState>
```
- Tipo 1: `ProductEvent` - eventos entrada
- Tipo 2: `ProductState` - estado saída

**2. Registro de event handlers**
```dart
on<ToggleFavoriteEvent>(_onToggleFavorite);
```
- Mapeia cada tipo de evento para seu handler

**3. Handlers de eventos**
```dart
Future<void> _onToggleFavorite(
  ToggleFavoriteEvent event,
  Emitter<ProductState> emit,
) async {
  // Lógica
  emit(ProductLoadedState(...)); // Emite novo estado
}
```
- Recebem o evento e um emissor (emitter)
- Podem ser async
- Emitem novo estado quando pronto

**4. Tratamento de erros**
```dart
try {
  // Lógica
} catch (e) {
  emit(ProductErrorState('Erro: $e'));
}
```
- Captura erros e emite estado de erro

### Uso na UI: `lib/presentation/pages/products_bloc_page.dart`

```dart
class ProductsBlocPage extends StatefulWidget {
  @override
  State<ProductsBlocPage> createState() => _ProductsBlocPageState();
}

class _ProductsBlocPageState extends State<ProductsBlocPage> {
  late ProductsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = ProductsBloc();
    _bloc.add(const LoadProductsEvent()); // Inicia carregamento
  }

  @override
  void dispose() {
    _bloc.close(); // Libera recursos
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductState>(
      bloc: _bloc,
      builder: (context, state) {
        if (state is ProductLoadedState) {
          return ListView.builder(
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              final product = state.products[index];
              
              // Enviar evento ao BLoC
              IconButton(
                onPressed: () {
                  _bloc.add(ToggleFavoriteEvent(product.id));
                },
                icon: Icon(
                  product.favorite ? Icons.favorite : Icons.favorite_border,
                ),
              );
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
```

**Fluxo:**
```
User clica → _bloc.add(Event) 
→ BLoC processa evento 
→ emit(State) 
→ BlocBuilder vê mudança 
→ rebuild da UI
```

---

## 📊 Comparação Detalhada

| Aspecto | Provider | Riverpod | BLoC |
|---------|----------|----------|------|
| **Curva de aprendizado** | Baixa | Média | Alta |
| **Código necessário** | Pouco | Médio | Muito |
| **Testabilidade** | Boa | Excelente | Excelente |
| **Escalabilidade** | Média | Alta | Muito Alta |
| **Documentação** | Boa | Excelente | Excelente |
| **Performance** | Boa | Muito Boa | Excelente |
| **Context necessário** | Sim | Não | Sim |
| **Mutation** | Direta | Imutável | Explícita |
| **Quando usar** | Simples | Médio | Complexo |

---

## 🔍 Rastreando o Fluxo de Dados

### Cenário: Usuário marca "Notebook" como favorito

#### Com Provider:
```
1. User toca coração do Notebook
2. IconButton.onPressed() executa
3. context.read<ProductsProvider>().toggleFavorite('1')
4. ProductsProvider.toggleFavorite() executa
5. Product.favorite muda de false para true
6. notifyListeners() chamado
7. context.watch() detecta mudança
8. ProductsProviderPage rebuild
9. ListView rebuild
10. Ícone muda para vermelho (Icons.favorite)
11. Contador atualiza
```

#### Com Riverpod:
```
1. User toca coração do Notebook
2. IconButton.onPressed() executa
3. ref.read(productsProvider.notifier).toggleFavorite('1')
4. ProductsNotifier.toggleFavorite() executa
5. state = [...novo estado com favorite = true...]
6. ref.watch() detecta que state mudou
7. ProductsRiverpodPage rebuild
8. ListView rebuild
9. Ícone muda para vermelho
10. favoriteCountProvider recalcula
11. Contador atualiza
```

#### Com BLoC:
```
1. User toca coração do Notebook
2. IconButton.onPressed() executa
3. _bloc.add(ToggleFavoriteEvent('1'))
4. Evento adicionado ao stream de eventos
5. ProductsBloc._onToggleFavorite() executa
6. Product.favorite muda de false para true
7. emit(ProductLoadedState([...]))
8. BlocBuilder vê novo estado
9. ProductsBlocPage rebuild
10. ListView rebuild
11. Ícone muda para vermelho
12. Contador atualiza (extraído de state.products)
```

---

## 🎯 Padrões Observáveis

### 1. Mutação vs Imutabilidade

**Provider** - Mutação:
```dart
product.favorite = !product.favorite;  // Modifica objeto
notifyListeners();                     // Avisa sobre mudança
```

**Riverpod** - Imutabilidade:
```dart
state = [
  for (final p in state)
    if (p.id == productId)
      Product(...favorite: !p.favorite)  // Novo objeto
    else
      p
];
```

**BLoC** - Explícito:
```dart
product.favorite = !product.favorite;  // Modifica
emit(ProductLoadedState(List.from(_products)));  // Novo estado
```

### 2. Acesso aos Dados

**Provider** - Via Context:
```dart
context.watch<ProductsProvider>()
context.read<ProductsProvider>()
```

**Riverpod** - Via WidgetRef:
```dart
ref.watch(productsProvider)
ref.read(productsProvider)
```

**BLoC** - Via Builder:
```dart
BlocBuilder<ProductsBloc, ProductState>(
  builder: (context, state) {
    // Acesso ao state aqui
  }
)
```

---

## 📚 Padrões de Código

### Pattern 1: Buscar Produto por ID
```dart
final product = _products.firstWhere((p) => p.id == productId);
// Lança exceção se não encontrado

final product = _products.firstWhereOrNull((p) => p.id == productId);
// Retorna null se não encontrado (com extension)
```

### Pattern 2: Toggle Booleano
```dart
// Antes
product.favorite = !product.favorite;

// Alternativa
product.favorite ? product.favorite = false : product.favorite = true;
```

### Pattern 3: Contar Favoritos
```dart
int favoriteCount = _products.where((p) => p.favorite).length;

// ou
int favoriteCount = _products.whereType<Product>()
    .where((p) => p.favorite)
    .length;
```

### Pattern 4: Filtrar Favoritos
```dart
List<Product> favorites = _products.where((p) => p.favorite).toList();
```

---

## 🐛 Erros Comuns

### Provider

**❌ Errado:**
```dart
context.watch<ProductsProvider>().toggleFavorite(id);
// Cada rebuild cria novo listener
```

**✅ Correto:**
```dart
final provider = context.read<ProductsProvider>();
provider.toggleFavorite(id);
// Pega referência uma vez
```

### Riverpod

**❌ Errado:**
```dart
ref.watch(productsProvider.notifier).toggleFavorite(id);
// Você quer usar notifier, não watch
```

**✅ Correto:**
```dart
ref.read(productsProvider.notifier).toggleFavorite(id);
// read para leitura única
```

### BLoC

**❌ Errado:**
```dart
ProductsBloc bloc = ProductsBloc();
// Cria nova instância cada rebuild
```

**✅ Correto:**
```dart
late ProductsBloc _bloc;
@override
void initState() {
  _bloc = ProductsBloc();
}
@override
void dispose() {
  _bloc.close();  // Importante!
}
```

---

## 🧪 Como Testar Cada Abordagem

### Provider - Unit Test
```dart
test('toggleFavorite deve alterar favorite', () {
  final provider = ProductsProvider();
  provider.toggleFavorite('1');
  expect(provider.products[0].favorite, isTrue);
});
```

### Riverpod - Unit Test
```dart
test('toggleFavorite deve alterar favorite', () {
  final container = ProviderContainer();
  container.read(productsProvider.notifier).toggleFavorite('1');
  final products = container.read(productsProvider);
  expect(products[0].favorite, isTrue);
});
```

### BLoC - Unit Test
```dart
test('ToggleFavoriteEvent deve emitir ProductLoadedState', () {
  final bloc = ProductsBloc();
  bloc.add(const ToggleFavoriteEvent('1'));
  
  expectLater(
    bloc.stream,
    emits(isA<ProductLoadedState>()),
  );
});
```

---

Este guia fornece uma compreensão profunda de como cada padrão funciona e como escolher o melhor para seu caso de uso.
