import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'data/datasources/product_remote_data_source.dart';
import 'data/repositories/product_repository_impl.dart';
import 'presentation/pages/product_list_page.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});

  final repository = ProductRepositoryImpl(
    remoteDataSource: ProductRemoteDataSourceImpl(client: http.Client()),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Arquitetura 01',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: ProductListPage(repository: repository),
    );
  }
}
