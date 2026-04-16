# Guia de Integração - Página de Anúncio

## Introdução

Este guia mostra como integrar a página de anúncio com dados reais do seu backend.

---

## 1. Estrutura de Dados do Backend

Seu backend deve retornar dados no seguinte formato JSON:

```json
{
  "id": "porsche-911-gt3-rs-001",
  "brand": "Porsche",
  "year": 2023,
  "model": "911 GT3 RS",
  "color": "Shark Blue",
  "price": 264900,
  "priceLabel": "Listed Price",
  "imageUrl": "https://...",
  "imageAlt": "Car description",
  "mileage": 1240,
  "mileageLabel": "1,240 mi",
  "fuelType": "Premium Unleaded",
  "transmission": "7-Speed PDK",
  "isCertified": true,
  "badge": "New Listing",
  "galleryImages": [
    "https://image1.jpg",
    "https://image2.jpg",
    "https://image3.jpg"
  ],
  "technicalSpecs": {
    "Horsepower": "518 HP",
    "0-60 mph": "3.0s",
    "Exterior Color": "Shark Blue",
    "Interior Color": "Black/Guards Red",
    "Fuel Type": "Premium Unleaded",
    "Transmission": "7-Speed PDK"
  },
  "sellerDescription": "Exquisite condition, track-ready yet road-legal...",
  "sellerInfo": {
    "name": "Apex Performance Motors",
    "imageUrl": "https://...",
    "rating": 4.9,
    "reviewCount": 128,
    "location": "Scottsdale, AZ",
    "trustedSince": "8"
  },
  "similarCars": [
    { /* Car object */ },
    { /* Car object */ },
    { /* Car object */ }
  ]
}
```

---

## 2. Serviço de API (Car Service)

Crie um serviço para buscar dados:

```dart
// lib/services/car_service.dart

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/car_model.dart';

class CarService {
  static const String baseUrl = 'https://your-api.com';

  // Buscar detalhes do anúncio
  static Future<Car> getListingDetails(String carId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/listings/$carId'),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return Car.fromJson(jsonData);
      } else {
        throw Exception('Failed to load listing');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Buscar carros similares
  static Future<List<Car>> getSimilarCars(String brand, String model) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/listings/similar?brand=$brand&model=$model'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((item) => Car.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load similar cars');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
```

---

## 3. Estender o Modelo Car

Adicione um método `fromJson` ao seu modelo:

```dart
// lib/models/car_model.dart

class Car {
  // ... campos existentes ...

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'] ?? '',
      brand: json['brand'] ?? '',
      year: json['year'] ?? 0,
      model: json['model'] ?? '',
      color: json['color'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      priceLabel: json['priceLabel'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      imageAlt: json['imageAlt'] ?? '',
      mileage: json['mileage'] ?? 0,
      mileageLabel: json['mileageLabel'] ?? '',
      fuelType: json['fuelType'] ?? '',
      transmission: json['transmission'] ?? '',
      isCertified: json['isCertified'] ?? false,
      isTopDeal: json['isTopDeal'] ?? false,
      badge: json['badge'],
      galleryImages: List<String>.from(json['galleryImages'] ?? []),
      technicalSpecs: Map<String, String>.from(json['technicalSpecs'] ?? {}),
      sellerDescription: json['sellerDescription'],
      sellerInfo: json['sellerInfo'] != null
          ? SellerInfo.fromJson(json['sellerInfo'])
          : null,
      similarCars: (json['similarCars'] as List?)
          ?.map((item) => Car.fromJson(item))
          .toList(),
    );
  }
}

class SellerInfo {
  // ... campos existentes ...

  factory SellerInfo.fromJson(Map<String, dynamic> json) {
    return SellerInfo(
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      reviewCount: json['reviewCount'] ?? 0,
      location: json['location'] ?? '',
      trustedSince: json['trustedSince'] ?? '',
    );
  }
}
```

---

## 4. Usar na Screen com Dados Reais

```dart
// lib/screens/listing_details_screen.dart

import 'package:flutter/material.dart';
import '../services/car_service.dart';
import '../models/car_model.dart';

class ListingDetailsScreen extends StatefulWidget {
  final String? carId; // Se quiser buscar por ID
  final Car? car;       // Ou passar o carro diretamente

  const ListingDetailsScreen({
    Key? key,
    this.carId,
    this.car,
  }) : super(key: key);

  @override
  State<ListingDetailsScreen> createState() => _ListingDetailsScreenState();
}

class _ListingDetailsScreenState extends State<ListingDetailsScreen> {
  late Future<Car> _carFuture;

  @override
  void initState() {
    super.initState();
    
    if (widget.car != null) {
      // Se o carro foi passado diretamente
      _carFuture = Future.value(widget.car!);
    } else {
      // Se precisa buscar do backend
      _carFuture = CarService.getListingDetails(widget.carId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Car>(
      future: _carFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        }

        if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Text('No data available'),
            ),
          );
        }

        final car = snapshot.data!;
        
        // Seu widget de listing aqui
        return _buildListingScreen(car);
      },
    );
  }

  Widget _buildListingScreen(Car car) {
    // Código da screen atual
    // ...
  }
}
```

---

## 5. Integração na HomeScreen

```dart
// lib/screens/home_screen.dart

import '../services/car_service.dart';

class _HomeScreenState extends State<HomeScreen> {
  // ...

  void _navigateToListing(String carId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListingDetailsScreen(carId: carId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ...
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ...
            GridView.builder(
              itemBuilder: (context, index) {
                return CarCard(
                  car: featuredCars[index],
                  onTap: () => _navigateToListing(featuredCars[index].id),
                );
              },
            ),
            // ...
          ],
        ),
      ),
    );
  }
}
```

---

## 6. Tratamento de Erros

```dart
class ListingDetailsScreen extends StatefulWidget {
  // ...
  @override
  State<ListingDetailsScreen> createState() => _ListingDetailsScreenState();
}

class _ListingDetailsScreenState extends State<ListingDetailsScreen> {
  late Future<Car> _carFuture;

  @override
  void initState() {
    super.initState();
    _carFuture = _loadCar();
  }

  Future<Car> _loadCar() async {
    try {
      if (widget.car != null) {
        return widget.car!;
      }
      return await CarService.getListingDetails(widget.carId!);
    } catch (e) {
      // Log error
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Car>(
      future: _carFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingState();
        }

        if (snapshot.hasError) {
          return _buildErrorState(snapshot.error);
        }

        if (!snapshot.hasData) {
          return _buildEmptyState();
        }

        return _buildListingScreen(snapshot.data!);
      },
    );
  }

  Widget _buildLoadingState() {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildErrorState(Object? error) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error, size: 64, color: Colors.red),
            SizedBox(height: 16),
            Text('Erro ao carregar anúncio'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => setState(() {
                _carFuture = _loadCar();
              }),
              child: Text('Tentar Novamente'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Nenhum anúncio disponível'),
      ),
    );
  }

  Widget _buildListingScreen(Car car) {
    // Seu código aqui
    return Container();
  }
}
```

---

## 7. Exemplos de Chamadas

### Exemplo 1: Buscar por ID
```dart
final car = await CarService.getListingDetails('porsche-911-gt3-rs-001');
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => ListingDetailsScreen(carId: 'porsche-911-gt3-rs-001'),
  ),
);
```

### Exemplo 2: Passar Carro Diretamente
```dart
final car = await CarService.getListingDetails('porsche-911-gt3-rs-001');
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => ListingDetailsScreen(car: car),
  ),
);
```

### Exemplo 3: Com Tratamento de Erro
```dart
try {
  final car = await CarService.getListingDetails('porsche-911-gt3-rs-001');
  if (!mounted) return;
  
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ListingDetailsScreen(car: car),
    ),
  );
} catch (e) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Erro: $e')),
  );
}
```

---

## 8. Testes

```dart
// test/car_service_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:garagehub/services/car_service.dart';

void main() {
  group('CarService', () {
    test('getListingDetails returns a Car', () async {
      // Mock HTTP response
      // Test implementation
    });

    test('getListingDetails throws on error', () async {
      // Test error handling
    });
  });
}
```

---

## ✅ Checklist de Integração

- [ ] Criar serviço de API (`car_service.dart`)
- [ ] Adicionar método `fromJson` aos modelos
- [ ] Instalar package `http`
- [ ] Configurar baseUrl do seu backend
- [ ] Adicionar tratamento de erros
- [ ] Testar com dados reais
- [ ] Implementar loading states
- [ ] Testar em diferentes dispositivos
- [ ] Verificar performance
- [ ] Adicionar cache de imagens

---

## Dicas de Performance

```dart
// Use CachedNetworkImage para melhor performance
import 'package:cached_network_image/cached_network_image.dart';

CachedNetworkImage(
  imageUrl: car.imageUrl,
  placeholder: (context, url) => Container(
    color: AppTheme.surfaceContainerLow,
  ),
  errorWidget: (context, url, error) => Icon(Icons.error),
)
```

---

## Conclusão

Seguindo este guia, você conseguirá integrar dados reais do seu backend na página de anúncio de forma rápida e segura!
