# Guia de Configuração - APIs e Gerenciamento de Estado

## Configurações de APIs Populares

### 1. Fake Store API (E-commerce Real)
```dart
// lib/services/product_service.dart
static const String baseUrl = 'https://fakestoreapi.com/products';

// Adapte Product.fromJson():
factory Product.fromJson(Map<String, dynamic> json) {
  return Product(
    id: json['id'].toString(),
    name: json['title'] ?? 'Sem nome',
    price: (json['price'] as num?)?.toDouble() ?? 0.0,
    description: json['description'] ?? '',
    imageUrl: json['image'],
  );
}
```

### 2. DummyJSON (Dados Realistas)
```dart
static const String baseUrl = 'https://dummyjson.com/products';

factory Product.fromJson(Map<String, dynamic> json) {
  return Product(
    id: json['id'].toString(),
    name: json['title'] ?? 'Sem nome',
    price: (json['price'] as num?)?.toDouble() ?? 0.0,
    description: json['description'] ?? '',
    imageUrl: json['thumbnail'],
  );
}
```

### 3. JSONPlaceholder (Para Testes)
```dart
static const String baseUrl = 'https://jsonplaceholder.typicode.com/posts';

// Nota: Este é um serviço de teste, adapte conforme necessário
factory Product.fromJson(Map<String, dynamic> json) {
  return Product(
    id: json['id'].toString(),
    name: json['title'] ?? 'Post ${json['id']}',
    price: (json['userId'] as num?)?.toDouble() ?? 0.0,
    description: json['body'] ?? '',
    imageUrl: null,
  );
}
```

---

## Gerenciamento de Estado com Provider

### 1. Instalar Provider
```yaml
# pubspec.yaml
dependencies:
  provider: ^6.0.0
```

### 2. Criar um ChangeNotifier
```dart
// lib/providers/product_provider.dart
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/product_service.dart';

class ProductProvider extends ChangeNotifier {
  final ProductService _productService = ProductService();
  
  List<Product> _products = [];
  bool _isLoading = false;
  String? _error;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchProducts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      _products = await _productService.fetchProducts();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      final newProduct = await _productService.addProduct(product);
      _products.add(newProduct);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      rethrow;
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      final updatedProduct = await _productService.updateProduct(product);
      final index = _products.indexWhere((p) => p.id == product.id);
      if (index >= 0) {
        _products[index] = updatedProduct;
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      rethrow;
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      await _productService.deleteProduct(id);
      _products.removeWhere((p) => p.id == id);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      rethrow;
    }
  }
}
```

### 3. Configurar no main.dart
```dart
import 'package:provider/provider.dart';
import 'providers/product_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: MaterialApp(
        title: 'Gerenciador de Produtos',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const ProductListScreen(),
      ),
    );
  }
}
```

### 4. Usar Provider em Telas
```dart
// lib/screens/product_list_screen_with_provider.dart
import 'package:provider/provider.dart';

class ProductListScreen extends StatefulWidget {
  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    // Carrega ao iniciar
    context.read<ProductProvider>().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Produtos')),
      body: Consumer<ProductProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.error != null) {
            return Center(child: Text('Erro: ${provider.error}'));
          }
          return ListView.builder(
            itemCount: provider.products.length,
            itemBuilder: (context, index) {
              return ProductCard(product: provider.products[index]);
            },
          );
        },
      ),
    );
  }
}
```

---

## Gerenciamento de Estado com Bloc

### 1. Instalar Bloc
```yaml
dependencies:
  flutter_bloc: ^8.0.0
  bloc: ^8.0.0
```

### 2. Criar um Bloc
```dart
// lib/bloc/product_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product.dart';
import '../services/product_service.dart';

// Eventos
abstract class ProductEvent {}
class FetchProductsEvent extends ProductEvent {}
class AddProductEvent extends ProductEvent {
  final Product product;
  AddProductEvent(this.product);
}

// Estados
abstract class ProductState {}
class ProductInitial extends ProductState {}
class ProductLoading extends ProductState {}
class ProductLoaded extends ProductState {
  final List<Product> products;
  ProductLoaded(this.products);
}
class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}

// Bloc
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductService _productService;

  ProductBloc(this._productService) : super(ProductInitial()) {
    on<FetchProductsEvent>(_onFetchProducts);
    on<AddProductEvent>(_onAddProduct);
  }

  Future<void> _onFetchProducts(
    FetchProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      final products = await _productService.fetchProducts();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onAddProduct(
    AddProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    try {
      await _productService.addProduct(event.product);
      add(FetchProductsEvent());
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
```

### 3. Usar Bloc em Telas
```dart
BlocBuilder<ProductBloc, ProductState>(
  builder: (context, state) {
    if (state is ProductLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is ProductLoaded) {
      return ListView.builder(
        itemCount: state.products.length,
        itemBuilder: (context, index) {
          return ProductCard(product: state.products[index]);
        },
      );
    } else if (state is ProductError) {
      return Center(child: Text('Erro: ${state.message}'));
    }
    return Container();
  },
);
```

---

## Comparação: setState vs Provider vs Bloc

| Aspecto | setState | Provider | Bloc |
|--------|----------|----------|------|
| **Complexidade** | Simples | Média | Complexa |
| **Melhor para** | Projetos pequenos | Projetos médios | Projetos grandes |
| **Reatividade** | Local | Global | Global |
| **Testes** | Difícil | Fácil | Muito fácil |
| **Curva de Aprendizado** | Rápida | Média | Lenta |
| **Performance** | Boa | Excelente | Excelente |

---

## Recomendações

- **Projeto Simples**: Use `setState` conforme implementado
- **Projeto Médio**: Migre para `Provider`
- **Projeto Grande/Profissional**: Use `Bloc`
- **Projeto com Muitos Estados**: `Riverpod` é uma alternativa ao Provider

---

**Próximas Etapas**:
1. Escolha sua API
2. Adapte `Product.fromJson()`
3. Altere `baseUrl` em `ProductService`
4. Escolha seu gerenciador de estado preferido
5. Execute `flutter pub get` e teste!
