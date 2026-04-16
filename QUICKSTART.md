# 🚀 Quick Start - Página de Anúncio

## 5 Minutos para Começar

### 1️⃣ Abra o Projeto
```bash
cd "C:\Users\Gonçalo Oliveira\Desktop\GarageHUB"
```

### 2️⃣ Execute o App
```bash
flutter run
```

### 3️⃣ Teste a Página de Anúncio
1. Abra o app
2. Clique no **primeiro carro** (Porsche) na seção "Featured Listings"
3. Veja a página de anúncio completa! 🎉

---

## 📸 O que Verá

✅ Galeria com múltiplas imagens  
✅ Indicadores deslizáveis  
✅ Título do carro em destaque  
✅ Preço e estimativa mensal  
✅ Quick specs (Mileage, Drivetrain, Engine)  
✅ Especificações técnicas detalhadas  
✅ Descrição do vendedor  
✅ Card do vendedor com rating  
✅ Botões de Contact e Message  
✅ Carrossel de carros similares  
✅ Bottom sheet em mobile  
✅ FAB flutuante em desktop  

---

## 🎨 Design

- **100% Fidelidade** ao HTML fornecido
- **Tema escuro** integrado
- **Responsivo** (mobile + desktop)
- **Animações** suaves

---

## 📁 Novos Arquivos

```
lib/
├── data/sample_listing_data.dart          # Dados de exemplo
├── screens/listing_details_screen.dart     # Screen principal
├── widgets/gallery_with_indicators.dart    # Galeria
├── widgets/seller_profile_card.dart        # Card vendedor
└── widgets/tech_specs_grid.dart            # Especificações
```

---

## 🔧 Como Usar com Seus Dados

### Opção 1: Dados Simples
```dart
import 'screens/listing_details_screen.dart';

final myCar = Car(
  id: 'meu-carro',
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
);

Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => ListingDetailsScreen(car: myCar),
  ),
);
```

### Opção 2: Dados Completos
```dart
final myCar = Car(
  // ... dados acima ...
  technicalSpecs: {
    'Horsepower': '518 HP',
    '0-60 mph': '3.0s',
    'Exterior Color': 'Shark Blue',
    // ... mais specs ...
  },
  sellerDescription: 'Exquisite condition, track-ready...',
  sellerInfo: SellerInfo(
    name: 'Apex Performance Motors',
    imageUrl: 'https://...',
    rating: 4.9,
    reviewCount: 128,
    location: 'Scottsdale, AZ',
    trustedSince: '8',
  ),
  similarCars: [
    Car(...),
    Car(...),
    Car(...),
  ],
);

Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => ListingDetailsScreen(car: myCar),
  ),
);
```

---

## 📱 Testar Responsividade

### Mobile
```bash
# Simular iPhone 13
flutter run -d "iphone-13"

# Simular Android
flutter run -d "pixel-5"
```

### Web
```bash
flutter run -d chrome

# Em modo desktop
flutter run -d windows
```

---

## ✅ Checklist de Verificação

- [ ] App abre sem erros
- [ ] Clico no primeiro carro e abre a página
- [ ] Galeria funciona (desliza)
- [ ] Indicadores animam
- [ ] Layout é responsivo
- [ ] Botões funcionam
- [ ] FAB aparece ao scroll (desktop)
- [ ] Bottom sheet funciona (mobile)

---

## 🆘 Troubleshooting

### Erro: "Target of URI doesn't exist"
**Solução**: Execute `flutter pub get`

### Erro: "The getter 'black' isn't defined"
**Solução**: Este erro já foi corrigido (use `FontWeight.w900`)

### App não abre
**Solução**: 
```bash
flutter clean
flutter pub get
flutter run
```

### Página branca
**Solução**: Verifique as URLs das imagens (deve ser HTTPS)

---

## 📚 Documentação Completa

- **[LISTING_DETAILS_GUIDE.md](LISTING_DETAILS_GUIDE.md)** - Guia detalhado
- **[INTEGRATION_GUIDE.md](INTEGRATION_GUIDE.md)** - Como integrar com backend
- **[IMPLEMENTATION_SUMMARY.md](IMPLEMENTATION_SUMMARY.md)** - O que foi criado

---

## 💡 Dicas

1. **Performance**: Use `cached_network_image` para imagens
2. **Erros**: Sempre trate erros em FutureBuilder
3. **Dados**: Valide dados antes de navegar
4. **UX**: Adicione loading states

---

## 🎯 Próximas Features

- [ ] Compartilhamento de anúncio
- [ ] Adicionar aos favoritos
- [ ] Formulário de contato
- [ ] Chat com vendedor
- [ ] Visualização em 3D

---

## 📞 Suporte

Precisa de ajuda?

1. Verifique os arquivos `.md` de documentação
2. Olhe os exemplos em `lib/data/sample_listing_data.dart`
3. Execute `flutter analyze` para erros
4. Use `flutter doctor` para verificar ambiente

---

## 🎉 Pronto!

Sua página de anúncio está funcionando! 

Divirta-se customizando e adaptando para seus dados! 🚀

**Qualquer dúvida**: Veja a documentação ou os exemplos de código.
