import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import '../models/car_model.dart';
import '../API/supabase_api.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class SearchResultsScreen extends StatefulWidget {
  final int totalResults;
  final Map<String, dynamic> filters;

  const SearchResultsScreen({
    super.key,
    this.totalResults = 2482,
    required this.filters,
  });

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  int _selectedBottomNavIndex = 0;
  final String _selectedSort = 'price_high';
  bool _isSortDropdownOpen = false;

  List<Car> _results = [];
  bool _isLoading = true;

  final Map<String, bool> _favorites = {};

  @override
  void initState() {
    super.initState();
    _fetchResultsFromDb();
  }

  Future<void> _fetchResultsFromDb() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final raw = await SupabaseApi.searchCars(widget.filters);
      final mapped = raw.map<Car>((m) {
        return _mapToCar(Map<String, dynamic>.from(m));
      }).toList();

      if (mapped.isEmpty) {
        // No matches: fetch all available cars and show them ordered
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No listings matched your filters. Showing all available listings.')),
        );

        final allCars = await SupabaseApi.getAllCars();
        final allMapped = allCars.map<Car>((m) {
          return _mapToCar(Map<String, dynamic>.from(m));
        }).toList();

        setState(() {
          _results = allMapped;
          _favorites.clear();
          for (var car in _results) {
            _favorites[car.id] = false;
          }
        });
      } else {
        setState(() {
          _results = mapped;
          _favorites.clear();
          for (var car in _results) {
            _favorites[car.id] = false;
          }
        });
      }
    } catch (e) {
      // keep _results empty on error
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Car _mapToCar(Map<String, dynamic> m) {
    final mileage = (m['mileage'] is num) ? (m['mileage'] as num).toInt() : int.tryParse((m['mileage'] ?? '').toString()) ?? 0;
    return Car(
      id: (m['id'] ?? '').toString(),
      brand: (m['brand'] ?? '').toString(),
      year: (m['year'] is num) ? (m['year'] as num).toInt() : int.tryParse((m['year'] ?? '').toString()) ?? 0,
      model: (m['model'] ?? '').toString(),
      color: (m['color'] ?? '').toString(),
      price: (m['price'] is num) ? (m['price'] as num).toDouble() : double.tryParse((m['price'] ?? '').toString()) ?? 0.0,
      priceLabel: (m['price_label'] ?? '').toString(),
      imageUrl: (m['image_url'] ?? '').toString(),
      imageAlt: (m['image_alt'] ?? '').toString(),
      mileage: mileage,
      mileageLabel: '${_formatPrice(mileage)}',
      fuelType: (m['fuel_type'] ?? '').toString(),
      transmission: (m['transmission'] ?? '').toString(),
      isCertified: m['is_certified'] == true,
      isTopDeal: m['is_top_deal'] == true,
      badge: (m['badge'] != null) ? m['badge'].toString() : null,
      galleryImages: (m['gallery_images'] is List) ? List<String>.from(m['gallery_images'] as List) : null,
      technicalSpecs: null,
      sellerDescription: (m['seller_description'] ?? '').toString(),
    );
  }

  void _toggleFavorite(String carId) {
    setState(() {
      _favorites[carId] = !(_favorites[carId] ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          // Sort/Filter Section
          _buildSortFilterSection(),
          // Results Feed
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
                child: Column(
                  children: [
                    // Results List
                    if (_isLoading)
                      const SizedBox(
                        height: 200,
                        child: Center(child: CircularProgressIndicator()),
                      )
                    else
                      Column(
                        children: List.generate(
                          _results.length,
                          (index) => Padding(
                            padding: index < _results.length - 1
                                ? const EdgeInsets.only(bottom: 24)
                                : EdgeInsets.zero,
                            child: _buildResultCard(_results[index]),
                          ),
                        ),
                      ),
                    const SizedBox(height: 32),
                    // Load More Button
                    _buildLoadMoreButton(),
                    const SizedBox(height: 100), // Space for bottom nav
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 1,
        onTap: (index) {
          setState(() => _selectedBottomNavIndex = index);
          _handleBottomNavigation(index);
        },
      ),
    );
  }

  PreferredSize _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(64),
      child: Container(
        color: AppTheme.surface,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _buildIconButton(Icons.arrow_back, () {
                    Navigator.pop(context);
                  }),
                  const SizedBox(width: 16),
                  Text(
                    '${widget.totalResults} RESULTS',
                    style: const TextStyle(
                      fontFamily: 'Space Grotesk',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.primaryContainer,
                      letterSpacing: -0.02,
                    ),
                  ),
                ],
              ),
              _buildIconButton(Icons.home, () {
                Navigator.popUntil(context, (route) => route.isFirst);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onPressed) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(24),
        splashColor: AppTheme.primaryContainer.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(icon, color: AppTheme.primaryContainer, size: 24),
        ),
      ),
    );
  }

  Widget _buildSortFilterSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppTheme.outlineVariant.withOpacity(0.3),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Sort Dropdown
          GestureDetector(
            onTap: () {
              setState(() => _isSortDropdownOpen = !_isSortDropdownOpen);
            },
            child: Row(
              children: [
                Icon(Icons.sort, color: AppTheme.onSurfaceVariant, size: 16),
                const SizedBox(width: 8),
                Text(
                  _getSortLabel(),
                  style: const TextStyle(
                    fontFamily: 'Space Grotesk',
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.onSurfaceVariant,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.expand_more,
                  color: AppTheme.onSurfaceVariant,
                  size: 16,
                ),
              ],
            ),
          ),
          // Save Search Button
          Material(
            color: AppTheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(24),
            child: InkWell(
              onTap: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Search saved!')));
              },
              borderRadius: BorderRadius.circular(24),
              splashColor: AppTheme.primaryContainer.withOpacity(0.2),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.bookmark_add,
                      color: AppTheme.primaryContainer,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'SAVE SEARCH',
                      style: TextStyle(
                        fontFamily: 'Space Grotesk',
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.primaryContainer,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultCard(Car car) {
    bool isFavorited = _favorites[car.id] ?? false;

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image with Favorite Button
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  car.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppTheme.surfaceContainer,
                      child: const Center(
                        child: Icon(
                          Icons.directions_car,
                          color: AppTheme.onSurfaceVariant,
                          size: 48,
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Gradient Overlay
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppTheme.surface.withOpacity(0),
                        AppTheme.surface.withOpacity(0.6),
                      ],
                    ),
                  ),
                ),
              ),
              // Favorite Button
              Positioned(
                top: 16,
                right: 16,
                child: GestureDetector(
                  onTap: () => _toggleFavorite(car.id),
                  child: ClipOval(
                    child: BackdropFilter(
                      filter: ui.ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppTheme.surface.withOpacity(0.6),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isFavorited ? Icons.favorite : Icons.favorite_border,
                          color: isFavorited
                              ? AppTheme.primaryContainer
                              : Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Car Details
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category and Price Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${car.year} ${car.brand} ${car.model.split(' ')[0]}',
                            style: const TextStyle(
                              fontFamily: 'Space Grotesk',
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.onSurfaceVariant,
                              letterSpacing: 0.2,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            car.model,
                            style: const TextStyle(
                              fontFamily: 'Space Grotesk',
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: -0.02,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '\$${_formatPrice(car.price.toInt())}',
                          style: const TextStyle(
                            fontFamily: 'Space Grotesk',
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.primaryContainer,
                            letterSpacing: -0.02,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'EST. \$${_formatMonthlyPayment(car.price)}/MO',
                          style: const TextStyle(
                            fontFamily: 'Space Grotesk',
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.onSurfaceVariant,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Specs Grid
                Container(
                  padding: const EdgeInsets.only(top: 16),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: AppTheme.outlineVariant.withOpacity(0.15),
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      _buildSpecItem(
                        icon: Icons.speed,
                        label: 'MILEAGE',
                        value: car.mileageLabel,
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: AppTheme.outlineVariant.withOpacity(
                                  0.15,
                                ),
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: _buildSpecItem(
                            icon: Icons.settings_input_component,
                            label: 'DRIVETRAIN',
                            value: car.transmission,
                          ),
                        ),
                      ),
                      _buildSpecItem(
                        icon: car.fuelType == 'Electric'
                            ? Icons.electric_car
                            : Icons.settings_input_component,
                        label: car.fuelType == 'Electric' ? 'POWER' : 'ENGINE',
                        value: car.fuelType == 'Electric'
                            ? '637 HP'
                            : car.fuelType,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Space Grotesk',
            fontSize: 8,
            fontWeight: FontWeight.w700,
            color: AppTheme.onSurfaceVariant,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(icon, color: AppTheme.primaryContainer, size: 14),
            const SizedBox(width: 6),
            Text(
              value,
              style: const TextStyle(
                fontFamily: 'Manrope',
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLoadMoreButton() {
    return Material(
      color: AppTheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Loading more results...')),
          );
        },
        borderRadius: BorderRadius.circular(24),
        splashColor: AppTheme.primaryContainer.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          child: Text(
            'LOAD MORE RESULTS',
            style: TextStyle(
              fontFamily: 'Space Grotesk',
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: AppTheme.onSurface,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }

  String _getSortLabel() {
    switch (_selectedSort) {
      case 'price_high':
        return 'SORT BY: PRICE (HIGH)';
      case 'price_low':
        return 'SORT BY: PRICE (LOW)';
      case 'newest':
        return 'SORT BY: NEWEST';
      case 'mileage':
        return 'SORT BY: MILEAGE';
      default:
        return 'SORT BY: PRICE (HIGH)';
    }
  }

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  String _formatMonthlyPayment(double price) {
    // Simple calculation: price / 60 months
    int monthly = (price / 60).toInt();
    return monthly.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  void _handleBottomNavigation(int index) {
    switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/');
              break;
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
  }
}
