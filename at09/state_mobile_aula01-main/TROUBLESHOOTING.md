# ⚡ Guia de Resolução de Problemas

## 🔴 Problemas Comuns e Soluções

### Problema 1: "The member 'watch' isn't defined"

**Causa:** Você está tentando usar `context.watch()` fora de um widget

**❌ Errado:**
```dart
void someFunction() {
  final provider = context.watch<ProductsProvider>();  // ❌ context não disponível
}
```

**✅ Correto:**
```dart
@override
Widget build(BuildContext context) {
  final provider = context.watch<ProductsProvider>();  // ✅ Agora funciona
  return Container();
}
```

---

### Problema 2: "This class cannot extend or implement Bloc"

**Causa:** Você não importou a classe Bloc

**❌ Errado:**
```dart
// Sem import
class ProductsBloc extends Bloc<ProductEvent, ProductState> {
}
```

**✅ Correto:**
```dart
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsBloc extends Bloc<ProductEvent, ProductState> {
}
```

---

### Problema 3: "Error: The parameter 'required_parameter' is required"

**Causa:** Falta passagem de parâmetro requerido

**❌ Errado:**
```dart
// Falta de parâmetro
const LoadProductsEvent();  // Se requer parâmetro
```

**✅ Correto:**
```dart
// Verifique o construtor
abstract class ProductEvent {
  const ProductEvent();
}

class LoadProductsEvent extends ProductEvent {
  const LoadProductsEvent();  // Sem parâmetros
}
```

---

### Problema 4: "NoSuchMethodError: The getter 'products' was called on null"

**Causa:** Provider não está configurado na árvore de widgets

**❌ Errado:**
```dart
// main.dart sem provider
void main() {
  runApp(const MyApp());  // ❌ Sem ProviderScope ou Provider
}
```

**✅ Correto:**
```dart
// main.dart com provider
void main() {
  runApp(
    ProviderScope(  // ✅ Riverpod
      child: provider.ChangeNotifierProvider(  // ✅ Provider
        create: (_) => ProductsProvider(),
        child: const MyApp(),
      ),
    ),
  );
}
```

---

### Problema 5: "type 'Product' is not a subtype of type 'Product'"

**Causa:** Importação de Product de lugares diferentes

**❌ Errado:**
```dart
// products_provider.dart
import '../models/product.dart';

// products_page.dart  
import '../../models/product.dart';  // Mesma classe mas import diferente?

// Pode parecer igual mas podem ser tipos diferentes se o IDE resolver diferente
```

**✅ Correto:**
```dart
// Sempre use o mesmo import path
import 'package:seu_app/models/product.dart';
```

---

### Problema 6: "setState() called after dispose()"

**Causa:** Tentativa de modificar estado após widget ser destruído

**❌ Errado:**
```dart
class _ProductsBlocPageState extends State<ProductsBlocPage> {
  late ProductsBloc _bloc;

  @override
  void initState() {
    _bloc = ProductsBloc();
    // Sem chamar close()
  }

  @override
  void dispose() {
    // Falta fechar o BLoC
    super.dispose();
  }
}
```

**✅ Correto:**
```dart
class _ProductsBlocPageState extends State<ProductsBlocPage> {
  late ProductsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = ProductsBloc();
  }

  @override
  void dispose() {
    _bloc.close();  // ✅ Fechar recursos
    super.dispose();
  }
}
```

---

### Problema 7: "LateInitializationError: Field '_bloc' has not been initialized"

**Causa:** Usar `_bloc` antes de inicializar no initState

**❌ Errado:**
```dart
class _ProductsBlocPageState extends State<ProductsBlocPage> {
  late ProductsBloc _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc.add(LoadProductsEvent());  // ❌ Pode não estar inicializado ainda
    return Container();
  }
}
```

**✅ Correto:**
```dart
class _ProductsBlocPageState extends State<ProductsBlocPage> {
  late ProductsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = ProductsBloc();  // ✅ Inicializa aqui
    _bloc.add(const LoadProductsEvent());  // ✅ Agora é seguro
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductState>(
      bloc: _bloc,
      builder: (context, state) {
        return Container();
      },
    );
  }
}
```

---

### Problema 8: "The method 'firstWhere' isn't defined for the type 'List<dynamic>'"

**Causa:** Tipo não está sendo inferido corretamente

**❌ Errado:**
```dart
final _products = [
  Product(id: '1', name: 'Notebook', price: 3500),
];
_products.firstWhere(...)  // Tipo não é claro
```

**✅ Correto:**
```dart
final List<Product> _products = [
  Product(id: '1', name: 'Notebook', price: 3500),
];
_products.firstWhere(...)  // ✅ Tipo explícito
```

---

### Problema 9: "The class 'ProductsProvider' doesn't extend 'StateNotifier'"

**Causa:** Usando Provider ou BLoC syntax errado

**❌ Errado:**
```dart
// BLoC syntax em Provider
class ProductsProvider extends StateNotifier {
  // ...
}
```

**✅ Correto:**
```dart
// Provider syntax
class ProductsProvider extends ChangeNotifier {
  // ...
}

// Riverpod syntax
class ProductsNotifier extends StateNotifier<List<Product>> {
  // ...
}

// BLoC syntax
class ProductsBloc extends Bloc<ProductEvent, ProductState> {
  // ...
}
```

---

### Problema 10: "Hot reload não funciona"

**Causa:** Mudança requer hot restart

**❌ Não funciona com hot reload:**
```dart
// Mudança em provider setup
void main() {
  runApp(
    ProviderScope(
      child: provider.ChangeNotifierProvider(
        create: (_) => SeuProvider(),  // ← Mudança aqui
      ),
    ),
  );
}
```

**✅ Solução:**
```bash
# Use hot restart ao invés de hot reload
r  # hot reload (tenta)
R  # hot restart (força reinicialização completa)
```

---

## 💡 Dicas Úteis

### Dica 1: Usar const onde possível

```dart
// ✅ Melhor performance
const LoadProductsEvent();

// ❌ Cria nova instância cada vez
LoadProductsEvent();
```

### Dica 2: Usar extension methods para code limpo

```dart
extension ProductListExtension on List<Product> {
  int get favoriteCount => where((p) => p.favorite).length;
  
  List<Product> get favorites => where((p) => p.favorite).toList();
}

// Uso
favoriteCount: productsProvider.products.favoriteCount
```

### Dica 3: Documentar mudanças de estado

```dart
// ✅ Bom
class ProductsProvider extends ChangeNotifier {
  /// Alterna o estado de favorito do produto [productId]
  /// 
  /// Notifica listeners sobre a mudança
  void toggleFavorite(String productId) {
    // ...
    notifyListeners();
  }
}
```

### Dica 4: Usar `assert` para validação

```dart
void toggleFavorite(String productId) {
  assert(productId.isNotEmpty, 'productId não pode ser vazio');
  
  final product = _products.firstWhere((p) => p.id == productId);
  product.favorite = !product.favorite;
  notifyListeners();
}
```

### Dica 5: Usar `?.` para acesso seguro

```dart
// ✅ Seguro
final product = _products.firstWhereOrNull((p) => p.id == productId);
final isFavorite = product?.favorite ?? false;

// ❌ Pode lançar exceção
final product = _products.firstWhere((p) => p.id == productId);
```

---

## 🔍 Debugging

### Método 1: Print para verificar estado

```dart
void toggleFavorite(String productId) {
  print('Alternando favorito: $productId');
  
  final product = _products.firstWhere((p) => p.id == productId);
  print('Produto encontrado: ${product.name}');
  
  product.favorite = !product.favorite;
  print('Novo status: ${product.favorite}');
  
  notifyListeners();
}
```

### Método 2: BLoC Observer para BLoC

```dart
// Adicione em main()
Bloc.observer = MyBlocObserver();

class MyBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    print('Evento: $event');
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print('Transição: $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('Erro: $error');
    super.onError(bloc, error, stackTrace);
  }
}
```

### Método 3: DevTools

```bash
flutter pub global activate devtools
devtools

# Em outro terminal
flutter run
# Procure pela URL DevTools no output
```

---

## 📋 Checklist de Resolução de Problemas

Quando algo não funciona, verifique:

- [ ] Todos os imports estão corretos?
- [ ] O Provider/Riverpod está configurado no main.dart?
- [ ] O BLoC está sendo fechado no dispose()?
- [ ] Você está usando `context` dentro de um Widget?
- [ ] Os tipos estão definidos corretamente?
- [ ] Você chamou `notifyListeners()` em Provider?
- [ ] O app foi relicado ou feito hot restart?
- [ ] Não há erros no console?
- [ ] A estrutura de dados está correta?
- [ ] Os IDs dos produtos são únicos?

---

## 🎯 Performance

### Problema: Rebuild desnecessário

**Sintoma:** Toda a lista reconstrói quando um produto muda

**Solução com Provider:**
```dart
// ❌ Reconstrói tudo
class ProductsProvider extends ChangeNotifier {
  void toggleFavorite(String productId) {
    // ...
    notifyListeners();  // Notifica TODOS
  }
}

// ✅ Rebuild apenas do item
// Considere usar SelectorProvider ou separar em providers menores
```

**Solução com Riverpod:**
```dart
// ✅ Seletores melhoram performance
final productProvider = Provider.family<Product, String>((ref, id) {
  final products = ref.watch(productsProvider);
  return products.firstWhere((p) => p.id == id);
});
```

**Solução com BLoC:**
```dart
// ✅ Use Equatable para comparação inteligente
class ProductLoadedState extends ProductState {
  final List<Product> products;

  const ProductLoadedState(this.products);

  @override
  List<Object?> get props => [products];  // Riverpod compara props
}
```

---

## 🚀 Próximos Passos Quando Funcionar

1. Implemente filtro de favoritos
2. Adicione persistência com SharedPreferences
3. Crie testes unitários
4. Otimize performance com Equatable
5. Implemente busca em tempo real

---

**Se tudo mais falhar:** Reinicie o app com `flutter clean && flutter pub get && flutter run`
