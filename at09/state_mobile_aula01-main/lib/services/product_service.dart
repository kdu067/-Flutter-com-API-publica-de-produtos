import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product.dart';

class ProductService {
  static const String _baseUrl = 'https://fakestoreapi.com/products';

  /// Busca todos os produtos da API
  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList
            .map((json) => Product.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Falha ao carregar produtos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao buscar produtos: $e');
    }
  }

  /// Busca um produto específico pelo ID
  Future<Product> fetchProductById(String id) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/$id'));

      if (response.statusCode == 200) {
        return Product.fromJson(json.decode(response.body));
      } else {
        throw Exception('Produto não encontrado: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao buscar produto: $e');
    }
  }

  /// Busca produtos por categoria
  Future<List<Product>> fetchProductsByCategory(String category) async {
    try {
      final response =
          await http.get(Uri.parse('$_baseUrl/category/$category'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList
            .map((json) => Product.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Erro ao buscar categoria: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao buscar produtos por categoria: $e');
    }
  }

  /// Cria um novo produto (POST)
  Future<Product> addProduct(Product product) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(product.toJson()),
      );

      if (response.statusCode == 201) {
        return Product.fromJson(json.decode(response.body));
      } else {
        throw Exception('Falha ao criar produto: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao adicionar produto: $e');
    }
  }

  /// Atualiza um produto existente (PUT)
  Future<Product> updateProduct(Product product) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/${product.id}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(product.toJson()),
      );

      if (response.statusCode == 200) {
        return Product.fromJson(json.decode(response.body));
      } else {
        throw Exception('Falha ao atualizar produto: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao atualizar produto: $e');
    }
  }

  /// Deleta um produto (DELETE)
  Future<void> deleteProduct(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('$_baseUrl/$id'),
      );

      if (response.statusCode != 200) {
        throw Exception('Falha ao deletar produto: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao deletar produto: $e');
    }
  }

  /// Busca produtos com limite especificado
  Future<List<Product>> fetchProductsWithLimit(int limit) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl?limit=$limit'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList
            .map((json) => Product.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception(
            'Falha ao carregar produtos limitados: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao buscar produtos com limite: $e');
    }
  }

  /// Busca produtos ordenados (sort: 'asc' ou 'desc')
  Future<List<Product>> fetchProductsSorted(
      {String sort = 'asc', int limit = 10}) async {
    try {
      final response =
          await http.get(Uri.parse('$_baseUrl?sort=$sort&limit=$limit'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList
            .map((json) => Product.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception(
            'Falha ao carregar produtos ordenados: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao buscar produtos ordenados: $e');
    }
  }
}
