import 'package:http/http.dart' as http;
import 'dart:convert';
import 'product.dart';

/// Serviço centralizado para chamadas de API
/// Exemplo usando JSONPlaceholder (você pode trocar pela sua API real)
class ProductService {
  // URL base da API - ALTERE PARA SUA API REAL
  static const String baseUrl = 'https://api.example.com/products';
  
  // Timeout padrão para requisições
  static const Duration timeout = Duration(seconds: 30);

  /// Busca a lista completa de produtos (GET)
  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
      ).timeout(timeout);

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData.map((item) => Product.fromJson(item as Map<String, dynamic>)).toList();
      } else {
        throw Exception('Falha ao carregar produtos: ${response.statusCode}');
      }
    } on http.ClientException catch (e) {
      throw Exception('Erro de conexão: $e');
    } on FormatException catch (e) {
      throw Exception('Erro ao processar resposta: $e');
    }
  }

  /// Busca um produto específico por ID (GET)
  Future<Product> fetchProductById(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/$id'),
      ).timeout(timeout);

      if (response.statusCode == 200) {
        return Product.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      } else if (response.statusCode == 404) {
        throw Exception('Produto não encontrado');
      } else {
        throw Exception('Erro ao carregar produto: ${response.statusCode}');
      }
    } on http.ClientException catch (e) {
      throw Exception('Erro de conexão: $e');
    }
  }

  /// Cria um novo produto (POST)
  Future<Product> addProduct(Product product) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(product.toJson()),
      ).timeout(timeout);

      if (response.statusCode == 201 || response.statusCode == 200) {
        return Product.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        throw Exception('Falha ao criar produto: ${response.statusCode}');
      }
    } on http.ClientException catch (e) {
      throw Exception('Erro de conexão: $e');
    }
  }

  /// Atualiza um produto existente (PUT)
  Future<Product> updateProduct(Product product) async {
    if (product.id == null) {
      throw Exception('Produto deve ter um ID para ser atualizado');
    }

    try {
      final response = await http.put(
        Uri.parse('$baseUrl/${product.id}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(product.toJson()),
      ).timeout(timeout);

      if (response.statusCode == 200) {
        return Product.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        throw Exception('Falha ao atualizar produto: ${response.statusCode}');
      }
    } on http.ClientException catch (e) {
      throw Exception('Erro de conexão: $e');
    }
  }

  /// Remove um produto da base (DELETE)
  Future<void> deleteProduct(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/$id'),
      ).timeout(timeout);

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Falha ao deletar produto: ${response.statusCode}');
      }
    } on http.ClientException catch (e) {
      throw Exception('Erro de conexão: $e');
    }
  }
}
