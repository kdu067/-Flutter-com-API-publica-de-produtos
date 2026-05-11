# Exemplos de Integração - APIs Públicas

## Teste Rápido com Fake Store API

### 1. Configurar para Fake Store API

Edite `lib/services/product_service.dart`:

```dart
class ProductService {
  static const String baseUrl = 'https://fakestoreapi.com/products';
  // ... resto do código permanece igual
}
```

Edite `lib/models/product.dart` - método `fromJson`:

```dart
factory Product.fromJson(Map<String, dynamic> json) {
  return Product(
    id: json['id'].toString(),
    name: json['title'] as String? ?? 'Sem nome',
    price: (json['price'] as num?)?.toDouble() ?? 0.0,
    description: json['description'] as String? ?? '',
    imageUrl: json['image'] as String?,
  );
}
```

### 2. Rodar a Aplicação

```bash
flutter pub get
flutter run
```

### 3. Testar Funcionalidades

- **Visualizar lista**: Produtos reais da Fake Store API
- **Adicionar novo**: Nota - não persiste (API de teste)
- **Editar**: Funciona normalmente
- **Deletar**: Retorna 200 (API simula sucesso)
- **Detalhes**: Mostra todas as informações

---

## Endpoint de Teste - Estrutura de Resposta

### GET /products
```json
[
  {
    "id": 1,
    "title": "Fjallraven - Backpack",
    "price": 109.95,
    "description": "Your perfect pack...",
    "category": "electronics",
    "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
    "rating": {
      "rate": 3.9,
      "count": 120
    }
  }
]
```

### POST /products
```json
{
  "title": "Novo Produto",
  "price": 99.99,
  "description": "Descrição do produto",
  "image": "https://example.com/image.jpg"
}
```

---

## Alternativa: DummyJSON API

### Configuração
```dart
// lib/services/product_service.dart
static const String baseUrl = 'https://dummyjson.com/products';
```

### Adaptar Product.fromJson()
```dart
factory Product.fromJson(Map<String, dynamic> json) {
  return Product(
    id: json['id'].toString(),
    name: json['title'] as String? ?? 'Sem nome',
    price: (json['price'] as num?)?.toDouble() ?? 0.0,
    description: json['description'] as String? ?? '',
    imageUrl: json['thumbnail'] as String?,
  );
}
```

### Endpoint de Teste
```
GET https://dummyjson.com/products
GET https://dummyjson.com/products/1
POST https://dummyjson.com/products/add
PUT https://dummyjson.com/products/1
DELETE https://dummyjson.com/products/1
```

---

## Configuração com API Real (Exemplo)

### 1. Sua API com Autenticação

```dart
class ProductService {
  static const String baseUrl = 'https://sua-api.com/api/v1/products';
  static const String apiKey = 'sua-chave-secreta';
  
  static const Duration timeout = Duration(seconds: 30);

  Map<String, String> _getHeaders() {
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
      // Adicione outros headers conforme necessário
    };
  }

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: _getHeaders(),
      ).timeout(timeout);

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body)['data'];
        return jsonData.map((item) => Product.fromJson(item as Map<String, dynamic>)).toList();
      } else {
        throw Exception('Erro: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro de conexão: $e');
    }
  }
  
  // Outros métodos...
}
```

### 2. Tratamento de Erros Avançado

```dart
class ProductService {
  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: _getHeaders(),
      ).timeout(timeout);

      switch (response.statusCode) {
        case 200:
          return _parseProducts(response.body);
        case 401:
          throw Exception('Não autorizado - verifique suas credenciais');
        case 403:
          throw Exception('Acesso proibido');
        case 404:
          throw Exception('Recurso não encontrado');
        case 500:
          throw Exception('Erro no servidor');
        default:
          throw Exception('Erro ${response.statusCode}: ${response.reasonPhrase}');
      }
    } on TimeoutException {
      throw Exception('Timeout - a requisição demorou muito');
    } on SocketException {
      throw Exception('Erro de conexão - verifique sua internet');
    } catch (e) {
      throw Exception('Erro desconhecido: $e');
    }
  }

  List<Product> _parseProducts(String body) {
    try {
      List<dynamic> jsonData = jsonDecode(body);
      return jsonData
          .map((item) => Product.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Erro ao processar dados: $e');
    }
  }
}
```

---

## Testing - Exemplo com Mockito

```dart
// pubspec.yaml
dev_dependencies:
  mockito: ^5.0.0

// test/product_service_test.dart
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

void main() {
  group('ProductService', () {
    test('fetchProducts retorna lista de produtos', () async {
      final client = MockClient();

      when(client.get(any)).thenAnswer((_) async =>
          http.Response('[{"id":"1","title":"Produto","price":99.99}]', 200));

      // Teste aqui...
    });
  });
}
```

---

## Executar em Diferentes Plataformas

### Android
```bash
flutter run -d android
# ou para build release
flutter build apk
```

### iOS
```bash
flutter run -d ios
# ou para build release
flutter build ios
```

### Web
```bash
flutter run -d chrome
flutter build web
```

### Desktop (Windows/Mac/Linux)
```bash
flutter run -d windows
flutter build windows
```

---

## Troubleshooting

### Erro: "Connection refused"
**Solução**: Verifique se a API está online e a URL está correta

### Erro: "Failed host lookup"
**Solução**: Verifique sua conexão com a internet

### Erro: "CERTIFICATE_VERIFY_FAILED"
**Solução**: Se for HTTPS, verifique o certificado SSL da API

### Layout overflow
**Solução**: Produtos com descrições longas são truncados com `overflow: TextOverflow.ellipsis`

### Imagens não carregam
**Solução**: O widget `ProductCard` tem fallback para casos onde a imagem não está disponível

---

## Dicas de Performance

1. **Paginação**: Para listas grandes, implemente paginação
```dart
Future<List<Product>> fetchProducts({int page = 1, int limit = 20}) async {
  final response = await http.get(
    Uri.parse('$baseUrl?page=$page&limit=$limit'),
  ).timeout(timeout);
  // ...
}
```

2. **Cache Local**: Use `hive` ou `sqflite` para cache
```yaml
dependencies:
  hive: ^2.0.0
  hive_flutter: ^1.1.0
```

3. **Lazy Loading**: Carregue imagens apenas quando visíveis
```dart
Image.network(
  product.imageUrl,
  cacheHeight: 256,
  cacheWidth: 256,
)
```

4. **Compressão**: Solicite imagens em tamanho apropriado
```dart
// API deve suportar query params
'${product.imageUrl}?size=medium'
```

---

## Próximos Passos

1. ✅ Configure sua API no `baseUrl`
2. ✅ Adapte `Product.fromJson()` conforme sua resposta
3. ✅ Teste com `flutter run`
4. ✅ Implemente tratamento de erros adicional conforme necessário
5. ✅ Considere migrar para Provider/Bloc para maiores complexidades

Bom desenvolvimento! 🚀
