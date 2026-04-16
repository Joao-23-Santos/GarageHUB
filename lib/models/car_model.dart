class Car {
  final String id;
  final String brand;
  final int year;
  final String model;
  final String color;
  final double price;
  final String priceLabel;
  final String imageUrl;
  final String imageAlt;
  final int mileage;
  final String mileageLabel;
  final String fuelType;
  final String transmission;
  final bool isCertified;
  final bool isTopDeal;
  final String? badge;
  
  // Listing details
  final List<String>? galleryImages;
  final Map<String, String>? technicalSpecs;
  final String? sellerDescription;
  final SellerInfo? sellerInfo;
  final List<Car>? similarCars;

  Car({
    required this.id,
    required this.brand,
    required this.year,
    required this.model,
    required this.color,
    required this.price,
    required this.priceLabel,
    required this.imageUrl,
    required this.imageAlt,
    required this.mileage,
    required this.mileageLabel,
    required this.fuelType,
    required this.transmission,
    this.isCertified = false,
    this.isTopDeal = false,
    this.badge,
    this.galleryImages,
    this.technicalSpecs,
    this.sellerDescription,
    this.sellerInfo,
    this.similarCars,
  });

  String get fullName => '$year $brand $model';
  String get subtitle => '$model • $color';
}

class SellerInfo {
  final String name;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final String location;
  final String trustedSince;

  SellerInfo({
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.location,
    required this.trustedSince,
  });
}

class RecommendationCar {
  final String id;
  final String brand;
  final int year;
  final String model;
  final double price;
  final String description;
  final String imageUrl;
  final String imageAlt;
  final Map<String, String> specs;

  RecommendationCar({
    required this.id,
    required this.brand,
    required this.year,
    required this.model,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.imageAlt,
    required this.specs,
  });

  String get fullName => '$year $brand $model';
}
