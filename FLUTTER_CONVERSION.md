# VehicleMarket Flutter App

Conversão completa do HTML/CSS/JavaScript para Dart/Flutter mantendo o design e funcionalidades originais.

## Estrutura de Ficheiros Criados

### 🎨 Theme
- **`lib/theme/app_theme.dart`** - Tema escuro customizado com Material Design 3
  - Paleta de cores Material Design 3
  - Tipografia customizada (Space Grotesk, Manrope)
  - Estilos de input, buttons e componentes

### 📊 Models
- **`lib/models/car_model.dart`** - Modelos de dados
  - `Car` - modelo para carros das featured listings
  - `RecommendationCar` - modelo para carros das recomendações

### 🎯 Widgets (Componentes Reutilizáveis)
- **`lib/widgets/top_app_bar.dart`** - AppBar superior com logo e ícones
- **`lib/widgets/search_widget.dart`** - Formulário de busca hero section
  - 4 dropdowns (Brand, Model, Year, Price Range)
  - Botão de busca com efeito shadow
- **`lib/widgets/car_card.dart`** - Card individual de carro (featured listings)
  - Imagem com hover scale
  - Badge (Certified/Top Deal)
  - Specs com ícones
  - Botão Explore Specs
- **`lib/widgets/recommendation_card.dart`** - Card de recomendação (horizontal)
  - Layout responsivo (mobile/desktop)
  - Descrição longa
  - Specs em grid
- **`lib/widgets/custom_bottom_nav_bar.dart`** - Bottom navigation bar customizada
  - 5 tabs (Home, Search, Sell, Messages, Favorites)
  - Estados ativos com animação

### 📱 Screens
- **`lib/screens/home_screen.dart`** - Tela principal
  - TopAppBar
  - Hero section com SearchWidget
  - Featured Listings (grid 3 colunas)
  - Recommended section
  - CustomBottomNavBar
  - Dados de exemplo dos carros

### 📝 Main
- **`lib/main.dart`** - Ponto de entrada da app
  - MaterialApp com tema customizado
  - HomeScreen como home

## Funcionalidades Implementadas

✅ Tema escuro (Material Design 3 dark mode)
✅ Paleta de cores customizada (dourado #FFCC00 como primária)
✅ Tipografia customizada (Space Grotesk, Manrope)
✅ Formulário de busca interativo com 4 filtros
✅ Grid de 3 carros featured com imagens
✅ Cards com hover effects e animações
✅ Seção de recomendações com layout responsivo
✅ Bottom navigation bar interativa
✅ Ícones Material Symbols (substituídos por Flutter Icons)
✅ Responsivo (mobile/tablet/desktop)
✅ Sombras e efeitos visuais suaves
✅ Transições animadas

## Como Executar

```bash
# Instalar dependências
flutter pub get

# Executar a app
flutter run

# Para web
flutter run -d chrome

# Para outras plataformas
flutter run -d <device>
```

## Dados de Exemplo

A app vem com dados de exemplo:

### Featured Cars
1. 2023 Porsche 911 (Graphite Black) - $128,500
2. 2024 Tesla Model S (Pearl White) - $89,900
3. 2022 BMW M4 (Isle of Man Green) - $74,200

### Recommended Cars
1. 2021 Audi R8 V10 - $142,000
2. 2024 Mercedes-Benz G 63 - $186,000

## Próximas Melhorias

- Integrar com backend/API real
- Adicionar funcionalidade de favoritos
- Implementar navegação entre screens
- Adicionar filtros avançados
- Implementar página de detalhes do carro
- Adicionar sistema de chat (Messages)
- Sistema de listagem de carros (Sell)
- Persistência local (preferências do utilizador)

## Design Notes

- Mantém 100% do design original do HTML
- Cores exatas do Material Design 3 personalizado
- Espaçamentos e tipografia idênticos
- Hover effects implementados com AnimatedContainer
- Responsividade através de MediaQuery
- Carregamento de imagens da rede
