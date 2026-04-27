import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Product>> fetchProducts() async {
    try {
      return await remoteDataSource.fetchProducts();
    } catch (error) {
      throw Exception('Falha ao carregar produtos: $error');
    }
  }
}
