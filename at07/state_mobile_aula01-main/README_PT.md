# 🚀 State Management em Flutter - Atividade de Favoritos

**Um projeto educacional completo para aprender três padrões de gerenciamento de estado em Flutter: Provider, Riverpod e BLoC.**

## ⚡ Quick Start

```bash
# Clone ou abra o projeto
cd state_mobile_aula01-main

# Instale dependências
flutter pub get

# Execute o app
flutter run
```

## 📱 O que Você Vai Ver

Uma aplicação com:
- ✅ Lista de 6 produtos
- ✅ Sistema de favoritos interativo
- ✅ **3 implementações diferentes** (Provider, Riverpod, BLoC)
- ✅ Atualização automática de UI
- ✅ Contador de favoritos em tempo real

## 🎯 Objetivo da Atividade

Aprender como o estado controla a interface através de **três abordagens práticas de gerenciamento de estado**.

```
│ User │ → [Click] → │ State Management │ → [Notify] → │ UI │
                             ↓
                    [ Provider | Riverpod | BLoC ]
```

## 📚 Documentação Completa

| Documento | Objetivo | Tempo |
|-----------|----------|-------|
| **[INDICE.md](INDICE.md)** | 🗂️ Índice de navegação completo | 5 min |
| **[RESUMO_VISUAL.md](RESUMO_VISUAL.md)** | 📊 Estrutura visual e fluxos | 5 min |
| **[ATIVIDADE_FAVORITOS.md](ATIVIDADE_FAVORITOS.md)** | 🎮 Como executar passo a passo | 10 min |
| **[README_FAVORITOS.md](README_FAVORITOS.md)** | 📖 Guia completo da atividade | 15 min |
| **[GUIA_TECNICO.md](GUIA_TECNICO.md)** | 🔧 Análise profunda de cada padrão | 30 min |
| **[TROUBLESHOOTING.md](TROUBLESHOOTING.md)** | 🐛 Resolução de problemas | Consulta |

## 🎓 Começar Agora

### Passo 1: Leia o Resumo Visual
Abra [RESUMO_VISUAL.md](RESUMO_VISUAL.md) para entender o projeto em 5 minutos.

### Passo 2: Execute o App
Siga as instruções em [ATIVIDADE_FAVORITOS.md](ATIVIDADE_FAVORITOS.md).

### Passo 3: Teste as 3 Abordagens
- Clique em **"Produtos - Provider"** 
- Clique em **"Produtos - Riverpod"**
- Clique em **"Produtos - BLoC"**

### Passo 4: Estude o Código
Compare os 3 arquivos lado a lado (veja [INDICE.md](INDICE.md#-arquivos-relacionados)).

### Passo 5: Implemente um Novo Recurso
Use [GUIA_TECNICO.md](GUIA_TECNICO.md) como referência.

## 📁 Estrutura do Projeto

```
lib/
├── models/
│   └── product.dart              ✨ NOVO
├── state/
│   ├── provider/
│   │   └── products_provider.dart ✨ NOVO
│   ├── riverpod/
│   │   └── products_riverpod.dart ✨ NOVO
│   └── bloc/
│       ├── products_bloc.dart     ✨ NOVO
│       ├── products_event.dart    ✨ NOVO
│       └── products_state.dart    ✨ NOVO
└── presentation/pages/
    ├── products_provider_page.dart ✨ NOVO
    ├── products_riverpod_page.dart ✨ NOVO
    └── products_bloc_page.dart    ✨ NOVO
```

[Ver estrutura completa →](INDICE.md#-estrutura-de-pastas)

## 🔄 Fluxo da Atividade

```
┌──────────────────────────────────┐
│   Tela Inicial (Home Page)       │
│  - Exemplos de Contadores        │
│  - Exemplos de Produtos ← NOVO   │
└────────────┬─────────────────────┘
             │
     ┌───────┴────────┬────────────┐
     │                │            │
     ▼                ▼            ▼
┌─────────┐    ┌──────────┐    ┌──────┐
│Provider │    │ Riverpod │    │ BLoC │
│ Page    │    │  Page    │    │ Page │
└────┬────┘    └────┬─────┘    └──┬───┘
     │              │             │
     └──────────────┴─────────────┘
              │
     ┌────────▼────────┐
     │ Lista de Produtos
     │ - Marcar Favorito
     │ - Contar Favoritos
     │ - Atualizar UI
     └─────────────────┘
```

## 💡 Os 3 Padrões Explicados

### 🟦 Provider
**Simples e direto**
- Usar `context.watch()`
- Chamar métodos diretamente
- `notifyListeners()` para atualizar

### 🟪 Riverpod  
**Moderno e reativo**
- Usar `ref.watch()`
- Sem necessidade de context
- Estado imutável

### 🟩 BLoC
**Explícito e escalável**
- Usar `bloc.add(Event)`
- Event → BLoC → State
- Ideal para lógica complexa

[Comparação detalhada →](README_FAVORITOS.md#-comparação-das-abordagens)

## 🎮 Interagindo com a Aplicação

```
┌────────────────────────────────────┐
│  Produtos - [Provider/Riverpod/BLoC]
├────────────────────────────────────┤
│ Total de favoritos: 2 [Ver Favoritos]
│                                    │
│ ┌──────────────────────────────┐   │
│ │ Notebook - R$ 3500    [☆] ←─┼── Toque aqui
│ └──────────────────────────────┘   │
│                                    │
│ ┌──────────────────────────────┐   │
│ │ Mouse - R$ 120        [★] ←─┼── Já favoritado
│ └──────────────────────────────┘   │
│                                    │
│ ... (4 mais produtos)              │
│                                    │
└────────────────────────────────────┘
```

## ✨ Funcionalidades

### Implementadas ✅
- [x] Visualizar lista de produtos
- [x] Marcar como favorito
- [x] Remover dos favoritos
- [x] Contador automático
- [x] Atualização em tempo real
- [x] 3 implementações funcionais

### Desafios Opcionais ⏳
- [ ] Implementar filtro de favoritos
- [ ] Adicionar persistência (SharedPreferences)
- [ ] Criar animações
- [ ] Implementar busca
- [ ] Adicionar testes unitários

[Detalhes dos desafios →](README_FAVORITOS.md#-desafios-opcionais)

## 🚀 Primeiros Passos

### 1. Entender o Projeto
```
1. Leia RESUMO_VISUAL.md (5 min)
2. Execute flutter run (1 min)
3. Teste cada implementação (5 min)
```

### 2. Aprender Provider
```
1. Abra lib/state/provider/products_provider.dart
2. Abra lib/presentation/pages/products_provider_page.dart
3. Leia GUIA_TECNICO.md seção Provider
4. Compare com as outras abordagens
```

### 3. Aprender Riverpod
```
1. Abra lib/state/riverpod/products_riverpod.dart
2. Abra lib/presentation/pages/products_riverpod_page.dart
3. Leia GUIA_TECNICO.md seção Riverpod
4. Compare com Provider
```

### 4. Aprender BLoC
```
1. Abra lib/state/bloc/products_*.dart (3 arquivos)
2. Abra lib/presentation/pages/products_bloc_page.dart
3. Leia GUIA_TECNICO.md seção BLoC
4. Compare com as outras abordagens
```

### 5. Escolher e Usar
```
1. Escolha seu padrão favorito
2. Implemente um novo recurso
3. Teste no seu dispositivo
4. Use em seus próprios projetos
```

## 🐛 Algo Não Funciona?

1. **Erro ao executar?**
   ```bash
   flutter clean
   flutter pub get
   flutter run
   ```

2. **Imports faltando?**
   - Verifique [TROUBLESHOOTING.md](TROUBLESHOOTING.md)

3. **Não consegue marcar favoritos?**
   - Leia [TROUBLESHOOTING.md - Problema 4](TROUBLESHOOTING.md#problema-4-nosuchmethoderror-the-getter-products-was-called-on-null)

4. **Hot reload não funciona?**
   - Use `R` para hot restart
   - Leia [TROUBLESHOOTING.md - Problema 10](TROUBLESHOOTING.md#problema-10-hot-reload-não-funciona)

[Ver todos os problemas →](TROUBLESHOOTING.md)

## 📊 Comparação dos Padrões

| Aspecto | Provider | Riverpod | BLoC |
|---------|----------|----------|------|
| Dificuldade | ⭐ Fácil | ⭐⭐ Médio | ⭐⭐⭐ Difícil |
| Linhas de código | 110 | 135 | 225 |
| Curva de aprendizado | Baixa | Média | Alta |
| Melhor para | Simples | Médio | Complexo |
| Recomendado para | Iniciantes | Intermediário | Avançado |

[Análise completa →](README_FAVORITOS.md#-comparação-das-abordagens)

## 📚 Referências

- [Documentação Provider](https://pub.dev/packages/provider)
- [Documentação Riverpod](https://riverpod.dev/)
- [Documentação BLoC](https://bloclibrary.dev/)
- [Flutter State Management](https://flutter.dev/docs/development/data-and-backend/state-mgmt/intro)

## 🎯 Roteiro de Aprendizado

```
SEMANA 1:
├── Entender o projeto (1 dia)
├── Aprender Provider (2 dias)
├── Aprender Riverpod (2 dias)
└── Aprender BLoC (2 dias)

SEMANA 2:
├── Escolher seu padrão (1 dia)
├── Implementar novo recurso (3 dias)
├── Escrever testes (2 dias)
└── Usar em novo projeto (1 dia)
```

## 📝 Arquivos Importantes

### Documentação
- [INDICE.md](INDICE.md) - Índice completo
- [RESUMO_VISUAL.md](RESUMO_VISUAL.md) - Visão geral
- [ATIVIDADE_FAVORITOS.md](ATIVIDADE_FAVORITOS.md) - Como executar
- [README_FAVORITOS.md](README_FAVORITOS.md) - Guia completo
- [GUIA_TECNICO.md](GUIA_TECNICO.md) - Análise profunda
- [TROUBLESHOOTING.md](TROUBLESHOOTING.md) - Problemas e soluções

### Código
- [lib/models/product.dart](lib/models/product.dart) - Modelo
- [lib/state/provider/products_provider.dart](lib/state/provider/products_provider.dart) - Provider
- [lib/state/riverpod/products_riverpod.dart](lib/state/riverpod/products_riverpod.dart) - Riverpod
- [lib/state/bloc/](lib/state/bloc/) - BLoC (3 arquivos)
- [lib/presentation/pages/](lib/presentation/pages/) - UI (3 páginas)

## ✅ Checklist da Atividade

- [ ] Instalei o Flutter e as dependências
- [ ] Executei o app com sucesso
- [ ] Testei Provider
- [ ] Testei Riverpod
- [ ] Testei BLoC
- [ ] Li toda a documentação
- [ ] Entendi os 3 padrões
- [ ] Escolhi meu padrão favorito
- [ ] Implementei um novo recurso
- [ ] Usei em um projeto meu

## 🎓 Próximos Passos

Depois de dominar esta atividade:

1. **Implemente os desafios opcionais**
   - Filtro de favoritos
   - Persistência de dados
   - Animações

2. **Crie seus próprios projetos**
   - Use um dos padrões
   - Comece simples
   - Vá aumentando a complexidade

3. **Combine múltiplos padrões**
   - Use Provider para simples
   - Use Riverpod para médio
   - Use BLoC para complexo

4. **Ensine outros**
   - Compartilhe seu conhecimento
   - Ajude colegas a aprender
   - Crie seus próprios exemplos

## 💬 Dúvidas Frequentes

**P: Por onde começo?**
→ Leia [RESUMO_VISUAL.md](RESUMO_VISUAL.md)

**P: Qual padrão usar?**
→ Compare em [README_FAVORITOS.md](README_FAVORITOS.md#-comparação-das-abordagens)

**P: Como estudar?**
→ Siga [INDICE.md](INDICE.md#-ordem-de-leitura-recomendada)

**P: Algo não funciona?**
→ Veja [TROUBLESHOOTING.md](TROUBLESHOOTING.md)

**P: Como implementar novo recurso?**
→ Estude [GUIA_TECNICO.md](GUIA_TECNICO.md)

## 🌟 Diferenciais

✨ **Projeto completo** - 3 implementações funcionais
✨ **Documentação abrangente** - 6 arquivos de documentação
✨ **Código limpo** - Bem estruturado e comentado
✨ **Prático** - Execute e teste logo
✨ **Escalável** - Siga o padrão em seus projetos
✨ **Educacional** - Feito para aprender

## 📞 Suporte

Se tiver dúvidas ou problemas:

1. Verifique [TROUBLESHOOTING.md](TROUBLESHOOTING.md)
2. Releia [GUIA_TECNICO.md](GUIA_TECNICO.md)
3. Execute `flutter clean` e `flutter pub get`
4. Faça hot restart com `R` no terminal

## 📄 Licença

Este projeto é fornecido como material educacional.

---

## 🚀 Comece Agora!

```bash
cd state_mobile_aula01-main
flutter pub get
flutter run
```

Depois leia [RESUMO_VISUAL.md](RESUMO_VISUAL.md) →

---

**Desenvolvido com ❤️ para aprendizado de State Management em Flutter**

Última atualização: Abril 2026  
Versão: 1.0  
Status: ✅ Completo e Documentado
