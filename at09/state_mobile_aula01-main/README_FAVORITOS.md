# Sistema de Favoritos em Lista de Produtos

## 📋 Resumo da Atividade

Este projeto implementa um **sistema de controle de favoritos** em uma lista de produtos usando **três diferentes abordagens de gerenciamento de estado** em Flutter:

- **Provider**
- **Riverpod**
- **BLoC**

## 🎯 Objetivos Alcançados

✅ Compreender como o estado da aplicação controla o comportamento da interface  
✅ Aplicar diferentes estratégias de gerenciamento de estado em Flutter  
✅ Modificar uma aplicação existente  
✅ Observar como mudanças no estado provocam atualização automática da interface

## 📁 Estrutura de Arquivos Criados

### Modelos
```
lib/models/
  └── product.dart          # Modelo de dados para produtos
```

### Estado com Provider
```
lib/state/provider/
  └── products_provider.dart # Provider para gerenciar lista de produtos e favoritos
```

### Estado com Riverpod
```
lib/state/riverpod/
  └── products_riverpod.dart # Providers Riverpod para produtos
```

### Estado com BLoC
```
lib/state/bloc/
  ├── products_bloc.dart     # BLoC para gerenciar produtos
  ├── products_event.dart    # Eventos do BLoC
  └── products_state.dart    # Estados do BLoC
```

### Páginas da Aplicação
```
lib/presentation/pages/
  ├── products_provider_page.dart  # UI com Provider
  ├── products_riverpod_page.dart  # UI com Riverpod
  └── products_bloc_page.dart      # UI com BLoC
```

## 🚀 Como Usar

### 1. Abra a Aplicação
Ao executar o app, você verá uma lista de opções na tela inicial com dois grupos:
- **Exemplos de Contadores** (exemplos originais)
- **Exemplos de Lista de Produtos com Favoritos** (novas implementações)

### 2. Escolha uma Abordagem
Toque em uma das três opções para ver o sistema de favoritos implementado:
- Produtos - Provider
- Produtos - Riverpod
- Produtos - BLoC

### 3. Interaja com os Produtos
- **Visualize** a lista de 6 produtos com nomes e preços
- **Marque como favorito** tocando no ícone de coração
- **Desmarque** tocando novamente no ícone
- **Veja o contador** de favoritos atualizar em tempo real

## 📊 Modelo de Dados

```dart
class Product {
  final String id;
  final String name;
  final double price;
  bool favorite;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.favorite = false,
  });
}
```

## 🔄 Comparação das Abordagens

### Provider
**Características:**
- Simples e direto
- Usa `ChangeNotifier`
- Atualização com `notifyListeners()`
- Consumido com `Consumer` widget

**Quando usar:**
- Projetos pequenos e médios
- Quando você precisa de simplicidade
- Ótimo para iniciantes

```dart
final counter = context.watch<ProductsProvider>();
counter.toggleFavorite(productId);
```

### Riverpod
**Características:**
- Mais moderno que Provider
- Providers são funções
- StateNotifier para estado mutável
- Sem context, usa WidgetRef

**Quando usar:**
- Projetos maiores
- Quando precisa de melhor testabilidade
- Fluxo de dados mais previsível

```dart
ref.read(productsProvider.notifier).toggleFavorite(productId);
```

### BLoC
**Características:**
- Separação clara de responsabilidades
- Events -> BLoC -> States
- Mais verbose mas muito explícito
- Ótimo para lógica complexa

**Quando usar:**
- Aplicações grandes e complexas
- Quando você precisa de máxima separação de conceitos
- Lógica de negócio complexa

```dart
_productsBloc.add(ToggleFavoriteEvent(productId));
```

## ✨ Funcionalidades Implementadas

### Funcionalidades Obrigatórias
✅ Visualizar lista de produtos  
✅ Marcar produto como favorito  
✅ Remover produto dos favoritos  
✅ Atualização automática da interface

### Desafios Opcionais (Partiamente implementados)
⏳ **Contador de produtos favoritos** - Já implementado em todas as abordagens  
⏳ **Destaque visual para produtos favoritados** - Ícone muda de cor (cinza → vermelho)  
⏳ **Filtro para mostrar apenas favoritos** - Estrutura criada (botão "Ver Favoritos")

## 🎓 Como Estudar Este Código

1. **Comece com Provider** - É a mais simples
   - Abra `products_provider.dart`
   - Compare com `products_provider_page.dart`

2. **Passe para Riverpod** - Mais moderno
   - Abra `products_riverpod.dart`
   - Note as diferenças de sintaxe

3. **Aprenda BLoC** - Mais estruturado
   - Abra `products_event.dart`
   - Abra `products_state.dart`
   - Estude `products_bloc.dart`

4. **Compare as UI** - Veja como cada padrão se usa na interface
   - Abra as três páginas paralelas
   - Note as diferenças de acesso aos dados

## 🔧 Próximos Passos (Desafios Opcionais)

Implemente os seguintes melhorias:

### 1. Filtro de Favoritos
Modifique a página para adicionar um botão que filtra apenas os favoritos.

### 2. Contador Visual Melhorado
Adicione um badge ou chips mostrando estatísticas dos favoritos.

### 3. Busca por Produto
Adicione um campo de busca para filtrar produtos pelo nome.

### 4. Persistência de Dados
Implemente SharedPreferences ou Hive para persistir os favoritos.

### 5. Animações
Adicione animações ao marcar/desmarcar favoritos.

## 📚 Recursos de Aprendizado

- [Provider Documentation](https://pub.dev/packages/provider)
- [Riverpod Documentation](https://riverpod.dev/)
- [BLoC Documentation](https://bloclibrary.dev/)
- [Flutter State Management Guide](https://flutter.dev/docs/development/data-and-backend/state-mgmt/intro)

## ✅ Checklist de Aprendizado

- [ ] Entender como Provider funciona
- [ ] Entender como Riverpod funciona
- [ ] Entender como BLoC funciona
- [ ] Implementar uma funcionalidade própria em Provider
- [ ] Implementar a mesma funcionalidade em Riverpod
- [ ] Implementar a mesma funcionalidade em BLoC
- [ ] Comparar qual é mais fácil para seu caso de uso
- [ ] Escolher qual padrão usar em seu próximo projeto

---

**Desenvolvido como material educacional para ensino de State Management em Flutter**
