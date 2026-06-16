import 'package:flutter/material.dart';
import '../models/car_model.dart';
import '../theme/app_theme.dart';
import '../widgets/top_app_bar.dart';
import '../widgets/search_widget.dart';
import '../widgets/car_card.dart';
import '../widgets/recommendation_card.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../data/sample_listing_data.dart';
import '../API/supabase_api.dart';
import 'search_filters_screen.dart';
import 'search_results_screen.dart';
import 'listing_details_screen.dart';
import 'login_screen.dart';
import 'profile_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedBottomNavIndex = 0;
  String _selectedLanguage = 'en';

  // Search filter state
  final String _selectedBrand = 'All Brands';
  final String _selectedModel = 'Any Model';
  final String _selectedYearRange = '2020 - 2024';
  final String _selectedPriceRange = '\$50k - \$100k';

  final List<Car> featuredCars = [
    Car(
      id: '1',
      brand: 'Porsche',
      year: 2023,
      model: '911',
      color: 'Graphite Black',
      price: 128500,
      priceLabel: 'MSRP New',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCvdSEHW6-6X7AJQhstMyI-nz8YIOF7FPefJVJEZaNVf98I1Xa6LiArkBhz1wpB0_9KpAgpQVK_3aGtpkOPTYjjHXRRWmukuUHG1JpGA8El6pgkuGfwa4uYHusJoZIlBd_9rs5lIfa163-3l3qInN4l3HNfh5ZTMfKXSA_EerQ3VarnWvBT5XpoQGAZwzLUqPJZK_QhTBGgOEapePgc5bi_rn_YF7c2gQPgpZTD-4HDgDxouIs5wlv43_9ZV0MZelvuEjsLhegfrZk',
      imageAlt:
          'sleek black porsche 911 parked on modern concrete architecture',
      mileage: 1250,
      mileageLabel: '1,250 Mi',
      fuelType: 'Petrol',
      transmission: 'Automatic',
      isCertified: true,
      badge: 'Certified',
    ),
    Car(
      id: '2',
      brand: 'Tesla',
      year: 2024,
      model: 'Model S',
      color: 'Pearl White',
      price: 89900,
      priceLabel: 'Fixed Price',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuB9faPs-_ZC7BOA_9nPUuPCXvSTyM0QJDh1Z3Zolfu0wF8aEiHuuadZX8KKgA5E_s6mG8AowcK61IbA3WnMrFFI_hpvW9yyEPC0Nt33LL-zk1QFsZz3aC1fP8GGudzll2sfLPsoGoZXMBFhP-_eWSLUuOTDpHFCYUI0oWcAnjG39N78sTidNpeSJrSsa_Qe66P5pYGUHl6cxk7GgWy3NxAhh2R-izX1a0ZVYpk90R9MN_o2eIjkrZ-X0MQ0T9s7a5y7HW1kdGgfm1Y',
      imageAlt:
          'white tesla model s parked in front of futuristic charging station',
      mileage: 0,
      mileageLabel: '396 Mi Range',
      fuelType: 'Electric',
      transmission: 'Automatic',
      isTopDeal: true,
      badge: 'Top Deal',
    ),
    Car(
      id: '3',
      brand: 'BMW',
      year: 2022,
      model: 'M4',
      color: 'Isle of Man Green',
      price: 74200,
      priceLabel: 'Market Value',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBXEeuVkMH7xUxUzfTesAok-dSNSP7q-ZekTKcmjxdXQd_8E22-1oBNisLinCBkJkmQIvn_XITX61hOlOtH-W8s4hVSAx4g0XwL5NFAoSuTUCJCp8lHFDNQHMHbmyU8FGjxAFs--lXTTTqvyrDl4_2uNUNegZPuOJJJlVBGIAy1GVcFWESu4xfrg-8Lag8Fo8FPaRavu9Y2UA_F7bdY3fiJ7bkYcqY0CsUF92lx26fJj-5v4InvQVJaxthcuRs5DdITHl3XsEWtXVo',
      imageAlt: 'front view of high performance bmw m4 in metallic silver',
      mileage: 12400,
      mileageLabel: '12,400 Mi',
      fuelType: 'Petrol',
      transmission: 'Automatic',
    ),
  ];

  

  // Recommended cars loaded from the backend
  List<RecommendationCar> _recommendedCars = [];
  final Map<String, Car> _recommendedCarDetails = {};
  bool _isLoadingRecommended = true;

  @override
  void initState() {
    super.initState();
    _fetchRecommendedFromDb();
  }

  Future<void> _fetchRecommendedFromDb() async {
    setState(() => _isLoadingRecommended = true);
    try {
      final raw = await SupabaseApi.getAllCars();
      final mapped = raw.map<RecommendationCar>((m) {
        final map = Map<String, dynamic>.from(m);
        final car = Car(
          id: (map['id'] ?? '').toString(),
          brand: (map['brand'] ?? '').toString(),
          year: (map['year'] is num) ? (map['year'] as num).toInt() : int.tryParse((map['year'] ?? '').toString()) ?? 0,
          model: (map['model'] ?? '').toString(),
          color: (map['color'] ?? 'Unknown').toString(),
          price: (map['price'] is num) ? (map['price'] as num).toDouble() : double.tryParse((map['price'] ?? '').toString()) ?? 0.0,
          priceLabel: (map['price_label'] ?? 'N/A').toString(),
          imageUrl: (map['image_url'] ?? '').toString(),
          imageAlt: (map['image_alt'] ?? 'Car image').toString(),
          mileage: (map['mileage'] is num) ? (map['mileage'] as num).toInt() : int.tryParse((map['mileage'] ?? '').toString()) ?? 0,
          mileageLabel: (map['mileage_label'] ?? 'Unknown').toString(),
          fuelType: (map['fuel_type'] ?? 'Unknown').toString(),
          transmission: (map['transmission'] ?? 'Unknown').toString(),
          isCertified: map['is_certified'] == true,
          isTopDeal: map['is_top_deal'] == true,
          badge: map['badge']?.toString(),
          galleryImages: (map['gallery_images'] is List) ? List<String>.from(map['gallery_images'] as List) : null,
          technicalSpecs: (map['technical_specs'] is Map)
              ? Map<String, String>.from((map['technical_specs'] as Map).map((k, v) => MapEntry(k.toString(), v.toString())))
              : null,
          sellerDescription: (map['seller_description'] ?? '').toString(),
        );
        final recommendation = RecommendationCar(
          id: car.id,
          brand: car.brand,
          year: car.year,
          model: car.model,
          price: car.price,
          description: car.sellerDescription ?? '',
          imageUrl: car.imageUrl,
          imageAlt: car.imageAlt,
          specs: car.technicalSpecs ?? {},
        );
        _recommendedCarDetails[car.id] = car;
        return recommendation;
      }).toList();

      setState(() {
        _recommendedCars = mapped;
      });
    } catch (e) {
      // on error keep empty list
      setState(() {
        _recommendedCars = [];
      });
    } finally {
      setState(() => _isLoadingRecommended = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: TopAppBar(
          selectedLanguage: _selectedLanguage,
          onLanguageChanged: (language) {
            setState(() {
              _selectedLanguage = language;
            });
          },
          onMenuPressed: () {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Menu opened')));
          },
          onProfilePressed: () {
            if (SupabaseApi.isUserLoggedIn()) {
              Navigator.pushReplacementNamed(context, '/profile');
            } else {
              Navigator.pushReplacementNamed(context, '/login');
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section with Search
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: SearchWidget(
                onSearch: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SearchResultsScreen(
                        filters: {
                          'brand': _selectedBrand,
                          'model': _selectedModel,
                          'yearRange': _selectedYearRange,
                          'priceRange': _selectedPriceRange,
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            // Featured Listings Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "EDITOR'S CHOICE".toUpperCase(),
                            style: const TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.75,
                              color: AppTheme.primaryContainer,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Featured Listings'.toUpperCase(),
                            style: Theme.of(context).textTheme.headlineLarge
                                ?.copyWith(
                                  fontSize: 32,
                                  color: AppTheme.onSurface,
                                ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.tune,
                          color: AppTheme.onSurfaceVariant,
                          size: 24,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SearchFiltersScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // Cars Grid
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 0.86,
                          mainAxisSpacing: 45,
                        ),
                    // On desktop, show 3 columns
                    semanticChildCount: featuredCars.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: featuredCars.length,
                    itemBuilder: (context, index) {
                      return CarCard(
                        car: featuredCars[index],
                        onTap: () {
                          // Navigate to listing details for first car (Porsche)
                          // with complete sample data
                          if (index == 0) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ListingDetailsScreen(
                                  car: porsche911GT3RSListing,
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Exploring ${featuredCars[index].fullName}',
                                ),
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
            // Recommended Section
            Container(
              width: double.infinity,
              color: AppTheme.surfaceContainerLowest,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TAILORED FOR YOU'.toUpperCase(),
                    style: const TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.75,
                      color: AppTheme.primaryContainer,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Recommended'.toUpperCase(),
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontSize: 28,
                      color: AppTheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 32),
                  if (_isLoadingRecommended)
                    const Center(child: CircularProgressIndicator())
                  else
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _recommendedCars.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 24),
                      itemBuilder: (context, index) {
                        final rc = _recommendedCars[index];
                        return RecommendationCard(
                          car: rc,
                          onTap: () {
                            final car = _recommendedCarDetails[rc.id] ?? Car(
                              id: rc.id.isNotEmpty ? rc.id : 'indefinido',
                              brand: rc.brand.isNotEmpty ? rc.brand : 'Marca indefinida',
                              year: rc.year,
                              model: rc.model.isNotEmpty ? rc.model : 'Modelo indefinido',
                              color: 'Cor indefinida',
                              price: rc.price,
                              priceLabel: 'Preço indefinido',
                              imageUrl: rc.imageUrl.isNotEmpty ? rc.imageUrl : '',
                              imageAlt: rc.imageAlt.isNotEmpty ? rc.imageAlt : 'Imagem do carro',
                              mileage: 0,
                              mileageLabel: 'Quilometragem indefinida',
                              fuelType: 'Combustível indefinido',
                              transmission: 'Transmissão indefinida',
                            );

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ListingDetailsScreen(car: car),
                              ),
                            );
                          },
                        );
                      },
                    ),
                ],
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedBottomNavIndex,
        onTap: (index) {
          switch (index) {
            case 1:
              Navigator.pushReplacementNamed(context, '/search_filters');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/create_listing');
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/messages');
              break;
            case 4:
              Navigator.pushReplacementNamed(context, '/saved');
              break;
          }
          setState(() {
            _selectedBottomNavIndex = index;
          });
        },
      ),
    );
  }
}
