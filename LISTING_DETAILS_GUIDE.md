# Página de Anúncio de Carro - Guia de Uso

## Visão Geral

A página de anúncio (`ListingDetailsScreen`) é uma implementação completa em Flutter do design HTML fornecido. Mantém exatamente as mesmas funcionalidades, design visual e organização de conteúdo.

## Componentes Criados

### 1. **Modelo de Dados Expandido** (`car_model.dart`)
```dart
class Car {
  // ... campos existentes ...
  
  // Novos campos para listagem de anúncio
  final List<String>? galleryImages;           // Múltiplas imagens
  final Map<String, String>? technicalSpecs;   // Especificações técnicas
  final String? sellerDescription;              // Descrição do vendedor
  final SellerInfo? sellerInfo;                 // Informações do vendedor
  final List<Car>? similarCars;                 // Carros similares
}

class SellerInfo {
  final String name;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final String location;
  final String trustedSince;
}
```

### 2. **Widgets Específicos**

#### `GalleryWithIndicators` 
- Galeria de imagens com indicadores animados
- Suporta múltiplas imagens e navegação por página
- Gradient overlay no topo

#### `SellerProfileCard`
- Card sticky do vendedor
- Informações de classificação e confiança
- Botões de ação (Contact, Message)
- Responsivo (desktop e mobile)

#### `TechSpecsGrid` e `QuickSpecsBar`
- Grid de especificações técnicas em 2 colunas
- Quick specs bar em 3 colunas (Mileage, Drivetrain, Engine)
- Design bento-style com bordas customizadas

### 3. **Screen Principal** (`listing_details_screen.dart`)

A screen implementa:
- **AppBar** fixo com botões de voltar e share
- **Galeria** com indicadores
- **Título e Preço** com badges
- **Quick Specs Bar** (3 colunas)
- **Especificações Técnicas** detalhadas
- **Descrição do Vendedor** com borda especial
- **Card do Vendedor** (sticky em desktop)
- **Carrossel de Carros Similares**
- **Bottom Sheet** (mobile) com botões de ação
- **FAB Flutuante** (desktop) que aparece ao scroll
- **Layout responsivo** (mobile e desktop)

## Como Usar

### Navegação Básica
```dart
// Navegar para a página de anúncio
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => ListingDetailsScreen(car: myCar),
  ),
);

// Ou usando rota nomeada
Navigator.pushNamed(
  context,
  '/listing_details',
  arguments: myCar,
);
```

### Criar um Anúncio Completo
```dart
final myListing = Car(
  // Campos básicos
  id: 'porsche-911-gt3-rs',
  brand: 'Porsche',
  year: 2023,
  model: '911 GT3 RS',
  color: 'Shark Blue',
  price: 264900,
  priceLabel: 'Listed Price',
  imageUrl: 'https://...',
  imageAlt: 'Car description',
  mileage: 1240,
  mileageLabel: '1,240 mi',
  fuelType: 'Premium Unleaded',
  transmission: '7-Speed PDK',
  isCertified: true,
  badge: 'New Listing',
  
  // Novos campos para anúncio completo
  galleryImages: [
    'https://image1.jpg',
    'https://image2.jpg',
    'https://image3.jpg',
  ],
  
  technicalSpecs: {
    'Horsepower': '518 HP',
    '0-60 mph': '3.0s',
    'Exterior Color': 'Shark Blue',
    'Interior Color': 'Black/Guards Red',
    'Fuel Type': 'Premium Unleaded',
    'Transmission': '7-Speed PDK',
  },
  
  sellerDescription: 'Exquisite condition, track-ready yet road-legal...',
  
  sellerInfo: SellerInfo(
    name: 'Apex Performance Motors',
    imageUrl: 'https://...',
    rating: 4.9,
    reviewCount: 128,
    location: 'Scottsdale, AZ',
    trustedSince: '8',
  ),
  
  similarCars: [
    Car(...), // Carros similares
    Car(...),
    Car(...),
  ],
);

// Navegar
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => ListingDetailsScreen(car: myListing),
  ),
);
```

## Dados de Exemplo

Um arquivo de dados de exemplo está disponível em `lib/data/sample_listing_data.dart`:

```dart
import '../data/sample_listing_data.dart';

// Usar no seu código
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => ListingDetailsScreen(car: porsche911GT3RSListing),
  ),
);
```

## Design & Tema

A página usa exatamente as cores e tipografia do tema da aplicação:

### Cores Principais
- **Primária**: `#FFCC00` (Amarelo vibrante)
- **Fundo**: `#131313` (Preto profundo)
- **Texto**: `#E5E2E1` (Branco quente)
- **Secundária**: `#DFC47A` (Dourado)

### Tipografia
- **Títulos**: Space Grotesk (700 bold)
- **Corpo**: Manrope (400 regular)
- **Labels**: Manrope (600 semi-bold)

## Responsividade

### Mobile (< 1024px)
- Layout vertical com coluna única
- Bottom sheet com botões de ação
- Quick specs em 3 colunas
- Tech specs em 2 colunas

### Desktop (≥ 1024px)
- Layout em 2 colunas (conteúdo + sidebar)
- Sidebar sticky com seller profile
- FAB flutuante com hover effect
- Sem bottom sheet

## Features Implementadas

✅ Galeria com indicadores deslizáveis
✅ Múltiplas imagens de produtos
✅ Grid de especificações técnicas
✅ Descrição do vendedor com destaque
✅ Card de perfil do vendedor
✅ Badges de novo anúncio / verificado
✅ Preço e estimativa mensal
✅ Quick specs bar (bento style)
✅ Carrossel de carros similares
✅ Bottom sheet mobile com ações
✅ FAB flutuante para desktop
✅ AppBar sticky
✅ Layout responsivo completo
✅ Animações suaves
✅ Tema escuro integrado

## Estrutura de Arquivos

```
lib/
├── models/
│   └── car_model.dart           # Modelo Car expandido
├── screens/
│   └── listing_details_screen.dart    # Screen principal
├── widgets/
│   ├── gallery_with_indicators.dart   # Galeria
│   ├── seller_profile_card.dart       # Card vendedor
│   ├── tech_specs_grid.dart           # Specs
│   └── ... (outros widgets existentes)
├── data/
│   └── sample_listing_data.dart       # Dados de exemplo
└── theme/
    └── app_theme.dart           # Tema da app
```

## Customizações Possíveis

### Alterar número de colunas no desktop
```dart
// Em tech_specs_grid.dart
crossAxisCount: 3, // ao invés de 2
```

### Ajustar altura da galeria
```dart
// Em listing_details_screen.dart
height: MediaQuery.of(context).size.width * 0.6, // ajustar multiplicador
```

### Mudar cores dos elementos
```dart
// Em app_theme.dart
static const Color primaryContainer = Color(0xFFFFCC00);
```

## Performance

- Lazy loading de imagens
- Scroll performance otimizado
- SingleChildScrollView apenas onde necessário
- NeverScrollableScrollPhysics para grids internos

## Acessibilidade

- Ícones com labels semânticos
- Contraste adequado de cores
- Tamanhos de toque adequados (min 48x48)
- Navegação com teclado suportada

---

## Próximos Passos (Opcionais)

- [ ] Implementar funcionalidade real de compartilhamento
- [ ] Integrar com backend para dados dinâmicos
- [ ] Adicionar funcionalidade de favoritos
- [ ] Implementar formulário de contato
- [ ] Adicionar zoom na galeria
- [ ] Implementar visualização em 3D (se disponível)
