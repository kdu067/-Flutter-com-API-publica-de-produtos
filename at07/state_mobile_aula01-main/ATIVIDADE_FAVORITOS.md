# 🎯 Atividade: Sistema de Favoritos em Lista de Produtos

## O que foi implementado

Este projeto agora contém uma **atividade prática completa** para aprender State Management em Flutter através de um sistema de favoritos.

## 📂 Estrutura do Projeto

```
lib/
├── models/
│   └── product.dart                    # ← Modelo Product criado
├── state/
│   ├── provider/
│   │   ├── counter_provider.dart       (existente)
│   │   └── products_provider.dart      # ← NOVO: Provider para favoritos
│   ├── riverpod/
│   │   ├── counter_riverpod.dart       (existente)
│   │   └── products_riverpod.dart      # ← NOVO: Riverpod para favoritos
│   └── bloc/
│       ├── counter_bloc.dart           (existente)
│       ├── counter_event.dart          (existente)
│       ├── counter_state.dart          (existente)
│       ├── products_bloc.dart          # ← NOVO: BLoC para favoritos
│       ├── products_event.dart         # ← NOVO: Eventos do BLoC
│       └── products_state.dart         # ← NOVO: Estados do BLoC
└── presentation/
    └── pages/
        ├── home_page.dart                    (atualizado)
        ├── provider_page.dart               (existente)
        ├── riverpod_page.dart               (existente)
        ├── bloc_page.dart                   (existente)
        ├── products_provider_page.dart      # ← NOVO: UI com Provider
        ├── products_riverpod_page.dart      # ← NOVO: UI com Riverpod
        └── products_bloc_page.dart          # ← NOVO: UI com BLoC
```

## 🎮 Como Executar

### 1. Abra o projeto no VS Code/Android Studio

```bash
cd state_mobile_aula01-main
flutter pub get
flutter run
```

### 2. Na tela inicial, você verá:

```
┌─────────────────────────────────────┐
│  State Management Examples          │
├─────────────────────────────────────┤
│                                     │
│  Exemplos de Contadores             │
│  ☐ Provider Example                 │
│  ☐ Riverpod Example                 │
│  ☐ BLoC Example                     │
│                                     │
│  ─────────────────────────────      │
│                                     │
│  Exemplos de Lista de Produtos      │
│  ☐ Produtos - Provider              │
│  ☐ Produtos - Riverpod              │
│  ☐ Produtos - BLoC                  │
│                                     │
└─────────────────────────────────────┘
```

### 3. Clique em uma das opções de Produtos

## 💡 O que você verá

### Tela de Produtos (em qualquer abordagem)

```
┌──────────────────────────────────────┐
│ Produtos - [Provider/Riverpod/BLoC]  │
├──────────────────────────────────────┤
│                                      │
│ Total de favoritos: 0  [Ver Favoritos]
│                                      │
│ ┌──────────────────────────────────┐ │
│ │ Notebook - R$ 3500.00      [☆]  │ │
│ └──────────────────────────────────┘ │
│                                      │
│ ┌──────────────────────────────────┐ │
│ │ Mouse - R$ 120.00          [☆]  │ │
│ └──────────────────────────────────┘ │
│                                      │
│ ┌──────────────────────────────────┐ │
│ │ Teclado - R$ 250.00        [★]  │ │  ← Favoritado!
│ └──────────────────────────────────┘ │
│                                      │
│ ┌──────────────────────────────────┐ │
│ │ Monitor - R$ 900.00        [☆]  │ │
│ └──────────────────────────────────┘ │
│                                      │
│ ... mais produtos                    │
│                                      │
└──────────────────────────────────────┘
```

## 🎮 Interação

**Toque no ícone** ☆ (coração vazio) para marcar como favorito  
→ O ícone muda para ★ (coração preenchido) em vermelho  
→ O contador "Total de favoritos" aumenta

**Toque novamente** ★ para remover dos favoritos  
→ Volta para ☆  
→ O contador diminui

## 📝 Dados de Exemplo

O sistema vem com 6 produtos pré-carregados:

| Produto  | Preço   | Favorito |
|----------|---------|----------|
| Notebook | R$ 3500 | ☆        |
| Mouse    | R$ 120  | ☆        |
| Teclado  | R$ 250  | ☆        |
| Monitor  | R$ 900  | ☆        |
| Webcam   | R$ 180  | ☆        |
| Headset  | R$ 450  | ☆        |

## 🔍 Comparar as Abordagens

A melhor forma de aprender é **implementar a mesma funcionalidade em cada abordagem** e ver como elas diferem.

### Tarefa 1: Entender a Estrutura
Abra cada arquivo de Provider, Riverpod e BLoC lado a lado e compare.

### Tarefa 2: Modificar a UI
Adicione um filtro para mostrar apenas favoritos em cada abordagem.

### Tarefa 3: Nova Funcionalidade
Implemente um "Limpar Favoritos" que remove todos.

## 🎓 O que Aprender

### Com Provider
```dart
// 1. Consumir dados
final products = context.watch<ProductsProvider>();

// 2. Chamar métodos
products.toggleFavorite(productId);

// 3. Vantagens: Simples, fácil de entender
```

### Com Riverpod
```dart
// 1. Consumir dados
final products = ref.watch(productsProvider);

// 2. Chamar métodos
ref.read(productsProvider.notifier).toggleFavorite(productId);

// 3. Vantagens: Moderno, sem context, testável
```

### Com BLoC
```dart
// 1. Consumir dados
BlocBuilder<ProductsBloc, ProductState>(
  builder: (context, state) {
    if (state is ProductLoadedState) {
      return List(state.products);
    }
  }
)

// 2. Chamar métodos
_bloc.add(ToggleFavoriteEvent(productId));

// 3. Vantagens: Muito explícito, grande lógica
```

## 📚 Próximos Passos

### Desafio 1: Implementar Filtro
Adicione um botão "Ver Favoritos" funcional que filtra a lista.

### Desafio 2: Persistência
Salve os favoritos usando SharedPreferences.

### Desafio 3: Animações
Adicione uma animação ao coração ao marcar favorito.

### Desafio 4: Busca
Implemente um campo de busca para filtrar produtos.

### Desafio 5: Contador Avançado
Mostre estatísticas: % de favoritos, produto mais favoritado, etc.

## 📖 Estrutura de Aprendizado Recomendada

1. **Dia 1**: Entender o modelo Product
2. **Dia 2**: Aprender Provider e marcar favoritos
3. **Dia 3**: Aprender Riverpod e replicar
4. **Dia 4**: Aprender BLoC e replicar
5. **Dia 5**: Implementar Desafios Opcionais
6. **Dia 6**: Escolher qual padrão usar em seu projeto

---

## ✅ Checklist da Atividade

- [ ] Entendo como funciona o modelo Product
- [ ] Consigo ver a lista de produtos na tela
- [ ] Consigo marcar um produto como favorito
- [ ] Consigo desmarcar um produto
- [ ] O ícone muda de cor (cinza para vermelho)
- [ ] O contador de favoritos atualiza
- [ ] Consigo fazer isso em Provider
- [ ] Consigo fazer isso em Riverpod
- [ ] Consigo fazer isso em BLoC
- [ ] Entendo as diferenças entre as três abordagens
- [ ] Consigo implementar uma novo recurso em todas as três

---

**Atividade concluída! Agora é hora de aprender e explorar cada padrão. 🚀**
