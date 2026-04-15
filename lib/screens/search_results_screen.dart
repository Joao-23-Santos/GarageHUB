import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import '../models/car_model.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class SearchResultsScreen extends StatefulWidget {
  final int totalResults;
  
  const SearchResultsScreen({
    Key? key,
    this.totalResults = 2482,
  }) : super(key: key);

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  int _selectedBottomNavIndex = 0;
  String _selectedSort = 'price_high';
  bool _isSortDropdownOpen = false;

  final List<Car> searchResults = [
    Car(
      id: '1',
      brand: 'Porsche',
      year: 2023,
      model: '911 GT3 RS',
      color: 'Silver',
      price: 264900,
      priceLabel: 'MSRP',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuB8Hl5WJYD-JM7ZQmKyoDJA_yN3pPpN4HOGF9DK1ZKAw8VbrOgs7C6t9IYwelUtbP5E5YwCM9JrWZ02odGz4GzMOS02XC05mZjuRx_7oKGD3lJW24qX2G-f0R2EQ3gGfyVnrEMauI_XxYDvOfelCFqEMKcZuKCzHHDjnxiSnCwO9SAznXamn3AdM2gzklCnsY4kY2__sqNJF5J4mQRwCSJYKQXqEurarQHKnK83saZ0c8v9BDF3Qeq_8-gbya5SvTRzGPufNifvwCA',
      imageAlt: 'Side profile of a sleek silver Porsche 911 GT3',
      mileage: 1240,
      mileageLabel: '1,240 Mi',
      fuelType: 'Petrol',
      transmission: 'PDK',
    ),
    Car(
      id: '2',
      brand: 'BMW',
      year: 2024,
      model: 'M4 Competition',
      color: 'Dark Grey',
      price: 94500,
      priceLabel: 'Market Value',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBegBL4xoazUgU13Dswqpcfhiiuug6RA9buTh6yFSrzznrW90RuEZSoIVM5ewlQPLFqeai4JDhV_izHUUeb6NLHo81LjGKycxWXWmf_tc_KxjZxCkJDlHqblqz-dTRZnqRPqhyTe6jCUZrMe3uoqz5Axu-obGEMDwQdjNGIWIDbfxZlZc6j2x_cEuLLrcUc58TATfIJ7phRwIZWSJe3I2KEhphP-zap9FVzjjo6oPByyuYX6D-oV1bCK7fzIcuekwhC90Tr6whGQUE',
      imageAlt: 'Modern dark grey BMW M4 Competition',
      mileage: 850,
      mileageLabel: '850 Mi',
      fuelType: 'Petrol',
      transmission: 'AWD',
    ),
    Car(
      id: '3',
      brand: 'Audi',
      year: 2023,
      model: 'RS e-tron GT',
      color: 'Matte Black',
      price: 148000,
      priceLabel: 'Market Value',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCp0HgWLuDe7Co6yFjaWQpKd5ckLlIS_H653ILrqBGC8wN53ioR1oejz1BfnU9eJL7Wt1g4fyynjPKLK5kf9VOQH6_Pmy92uIV6X3ZXx_W7kB1SBHB2_EF9AFFJLOW68t9j-RYw9C1Mp0VGE5Qc7QKvY0-9ZPfkjWwz6nfuo28hTIfZAFl_gRXdOMiSNndr6E3-HlX5vHsFcyx2m3qgkrtfOqYur9ZA_-p3XYv8tg2X8_jcbYsGomhcGqsEpgx_lLzhHcLI2E5stA4',
      imageAlt: 'Matte black Audi RS e-tron GT',
      mileage: 3420,
      mileageLabel: '3,420 Mi',
      fuelType: 'Electric',
      transmission: 'AWD',
    ),
  ];

  Map<String, bool> _favorites = {};

  @override
  void initState() {
    super.initState();
    // Initialize favorites
    for (var car in searchResults) {
      _favorites[car.id] = false;
    }
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
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  children: [
                    // Results List
                    Column(
                      children: List.generate(
                        searchResults.length,
                        (index) => Padding(
                          padding: index < searchResults.length - 1
                              ? const EdgeInsets.only(bottom: 24)
                              : EdgeInsets.zero,
                          child: _buildResultCard(searchResults[index]),
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
        selectedIndex: _selectedBottomNavIndex,
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
          child: Icon(
            icon,
            color: AppTheme.primaryContainer,
            size: 24,
          ),
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
                Icon(
                  Icons.sort,
                  color: AppTheme.onSurfaceVariant,
                  size: 16,
                ),
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
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Search saved!')),
                );
              },
              borderRadius: BorderRadius.circular(24),
              splashColor: AppTheme.primaryContainer.withOpacity(0.2),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                                color: AppTheme.outlineVariant.withOpacity(0.15),
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
                        value: car.fuelType == 'Electric' ? '637 HP' : car.fuelType,
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
            Icon(
              icon,
              color: AppTheme.primaryContainer,
              size: 14,
            ),
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
        // Showroom - already here
        break;
      case 1:
        // Saved
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Opening saved cars...')),
        );
        break;
      case 2:
        // Sell
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Opening sell section...')),
        );
        break;
      case 3:
        // Profile
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Opening profile...')),
        );
        break;
    }
  }
}
