import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/constants.dart';
import '../../core/error/exceptions.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> fetchProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ProductModel>> fetchProducts() async {
    final response = await client.get(
      Uri.parse(kProductsUrl),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final list = json.decode(response.body) as List<dynamic>;
      return list
          .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    throw ServerException('Status code ${response.statusCode}');
  }
}
