import 'package:flutter/material.dart';
import 'provider_page.dart';
import 'riverpod_page.dart';
import 'bloc_page.dart';
import 'products_provider_page.dart';
import 'products_riverpod_page.dart';
import 'products_bloc_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("State Management Examples")),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Exemplos de Contadores",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            title: const Text("Provider Example"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProviderPage()),
              );
            },
          ),
          ListTile(
            title: const Text("Riverpod Example"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RiverpodPage()),
              );
            },
          ),
          ListTile(
            title: const Text("BLoC Example"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const BlocPage()),
              );
            },
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Exemplos de Lista de Produtos com Favoritos",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            title: const Text("Produtos - Provider"),
            subtitle: const Text("Sistema de favoritos com Provider"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProductsProviderPage()),
              );
            },
          ),
          ListTile(
            title: const Text("Produtos - Riverpod"),
            subtitle: const Text("Sistema de favoritos com Riverpod"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProductsRiverpodPage()),
              );
            },
          ),
          ListTile(
            title: const Text("Produtos - BLoC"),
            subtitle: const Text("Sistema de favoritos com BLoC"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProductsBlocPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
