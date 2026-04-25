import 'package:flutter/material.dart';
import 'package:garagehub/screens/search_results_screen.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class SearchFiltersScreen extends StatefulWidget {
  const SearchFiltersScreen({Key? key}) : super(key: key);

  @override
  State<SearchFiltersScreen> createState() => _SearchFiltersScreenState();
}

class _SearchFiltersScreenState extends State<SearchFiltersScreen> {
  int _selectedBottomNavIndex = 1;

  // Filter states
  String _selectedCategory = 'car';
  String? _selectedBrand;
  String? _selectedModel;
  String _selectedBodyType = 'sedan';
  RangeValues _priceRange = const RangeValues(45000, 120000);
  double _maxMileage = 30000;
  String _selectedFuelType = 'electric';
  String _selectedTransmission = 'automatic';
  Map<String, bool> _selectedFeatures = {
    'Panoramic Sunroof': true,
    'Heated Leather Seats': false,
    'Adaptive Cruise Control': true,
  };
  TextEditingController _minYearController = TextEditingController(
    text: '2020',
  );
  TextEditingController _maxYearController = TextEditingController(
    text: '2024',
  );

  final List<Map<String, dynamic>> categories = [
    {
      'id': 'car',
      'label': 'Carro',
      'icon': Icons.directions_car,
      'filled': false,
    },
    {
      'id': 'motorcycle',
      'label': 'Mota',
      'icon': Icons.two_wheeler,
      'filled': false,
    },
    {
      'id': 'rv',
      'label': 'Auto-caravana',
      'icon': Icons.rv_hookup,
      'filled': false,
    },
    {
      'id': 'boat',
      'label': 'Barco',
      'icon': Icons.directions_boat,
      'filled': false,
    },
    {
      'id': 'truck',
      'label': 'Pesado',
      'icon': Icons.local_shipping,
      'filled': false,
    },
  ];

  final List<String> brands = [
    'Any Brand',
    'Tesla',
    'Porsche',
    'BMW',
    'Mercedes-Benz',
  ];

  final List<Map<String, dynamic>> bodyTypes = [
    {'id': 'suv', 'label': 'SUV', 'icon': Icons.directions_car_filled},
    {'id': 'coupe', 'label': 'Coupe', 'icon': Icons.sports_motorsports},
    {'id': 'sedan', 'label': 'Sedan', 'icon': Icons.directions_car},
    {'id': 'wagon', 'label': 'State', 'icon': Icons.airport_shuttle},
    {'id': 'cabrio', 'label': 'Cabrio', 'icon': Icons.set_meal},
  ];

  final List<String> fuelTypes = ['Electric', 'Petrol', 'Hybrid'];
  final List<String> transmissions = ['Manual', 'Automatic'];

  void _resetAllFilters() {
    setState(() {
      _selectedCategory = 'car';
      _selectedBrand = null;
      _selectedModel = null;
      _selectedBodyType = 'sedan';
      _priceRange = const RangeValues(45000, 120000);
      _maxMileage = 30000;
      _selectedFuelType = 'electric';
      _selectedTransmission = 'automatic';
      _selectedFeatures = {
        'Panoramic Sunroof': true,
        'Heated Leather Seats': false,
        'Adaptive Cruise Control': true,
      };
      _minYearController.text = '2020';
      _maxYearController.text = '2024';
    });
  }

  @override
  void dispose() {
    _minYearController.dispose();
    _maxYearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Horizontal Category Selection
                _buildCategoryScroll(),

                // Brand & Model Selection
                _buildBrandModelSection(),

                // Body Type Section
                _buildBodyTypeSection(),

                // Range Sliders
                _buildRangeSliders(),

                // Fuel Type & Transmission
                _buildFuelTransmissionSection(),

                // High-End Features
                _buildFeaturesSection(),

                // Year Range
                _buildYearRangeSection(),

                // More Filters
                _buildMoreFiltersLink(),

                // Spacer for fixed footer
                const SizedBox(height: 100),
              ],
            ),
          ),

          // Sticky Action Footer
          Positioned(
            bottom: 17,
            left: 0,
            right: 0,
            child: _buildActionFooter(),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedBottomNavIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/create_listing');
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/messages');
              break;
            case 4:
              Navigator.pushReplacementNamed(context, '/profile');
              break;
          }

          setState(() {
            _selectedBottomNavIndex = index;
          });
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppTheme.surface,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppTheme.primaryContainer),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        'Search Filters',
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          color: AppTheme.primaryContainer,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.0,
        ),
      ),
      actions: [
        TextButton(
          onPressed: _resetAllFilters,
          child: Text(
            'Reset All',
            style: const TextStyle(
              fontFamily: 'Manrope',
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
              color: AppTheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryScroll() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: categories.map((category) {
          final isSelected = _selectedCategory == category['id'];
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategory = category['id'];
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppTheme.secondaryContainer
                      : AppTheme.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(12),
                  border: isSelected
                      ? Border.all(
                          color: AppTheme.primaryContainer.withOpacity(0.2),
                          width: 1,
                        )
                      : null,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      category['icon'],
                      size: 24,
                      color: isSelected
                          ? AppTheme.primaryContainer
                          : AppTheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      category['label'],
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.0,
                        color: isSelected
                            ? AppTheme.primaryContainer
                            : AppTheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBrandModelSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Brand & Identity',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppTheme.onSurfaceVariant,
              letterSpacing: 2.0,
              fontSize: 10,
            ),
          ),
          const SizedBox(height: 16),
          // Brand Dropdown
          Container(
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButton<String>(
              value: _selectedBrand,
              hint: const Text('Select Brand'),
              isExpanded: true,
              underline: const SizedBox.shrink(),
              style: const TextStyle(
                fontFamily: 'Manrope',
                fontSize: 14,
                color: AppTheme.onSurface,
              ),
              dropdownColor: AppTheme.surfaceContainerHigh,
              items: brands.map((brand) {
                return DropdownMenuItem(
                  value: brand,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(brand),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedBrand = value;
                });
              },
            ),
          ),
          const SizedBox(height: 12),
          // Model Dropdown
          Container(
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButton<String>(
              value: _selectedModel,
              hint: const Text('Select Model'),
              isExpanded: true,
              underline: const SizedBox.shrink(),
              style: const TextStyle(
                fontFamily: 'Manrope',
                fontSize: 14,
                color: AppTheme.onSurface,
              ),
              dropdownColor: AppTheme.surfaceContainerHigh,
              items: ['Model 1', 'Model 2', 'Model 3'].map((model) {
                return DropdownMenuItem(
                  value: model,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(model),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedModel = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBodyTypeSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Body Type',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppTheme.onSurfaceVariant,
              letterSpacing: 2.0,
              fontSize: 10,
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: bodyTypes.map((type) {
              final isSelected = _selectedBodyType == type['id'];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedBodyType = type['id'];
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppTheme.secondaryContainer
                        : AppTheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(12),
                    border: isSelected
                        ? Border(
                            bottom: BorderSide(
                              color: AppTheme.primaryContainer,
                              width: 2,
                            ),
                          )
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        type['icon'],
                        size: 24,
                        color: AppTheme.primaryContainer,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        type['label'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                          color: AppTheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRangeSliders() {
    String formatPrice(double value) {
      return '\$${(value / 1000).toStringAsFixed(0)}k';
    }

    String formatMileage(double value) {
      return 'Under ${(value / 1000).toStringAsFixed(0)}k mi';
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          // Price Range
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Price Range',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                      letterSpacing: 2.0,
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    '${formatPrice(_priceRange.start)} — ${formatPrice(_priceRange.end)}',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppTheme.primaryContainer,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              RangeSlider(
                values: _priceRange,
                min: 0,
                max: 200000,
                activeColor: AppTheme.primaryContainer,
                inactiveColor: AppTheme.surfaceContainerHighest,
                onChanged: (RangeValues values) {
                  setState(() {
                    _priceRange = values;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 40),
          // Mileage
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Max Mileage',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                      letterSpacing: 2.0,
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    formatMileage(_maxMileage),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppTheme.primaryContainer,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Slider(
                value: _maxMileage,
                min: 0,
                max: 200000,
                activeColor: AppTheme.primaryContainer,
                inactiveColor: AppTheme.surfaceContainerHighest,
                onChanged: (double value) {
                  setState(() {
                    _maxMileage = value;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFuelTransmissionSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
        children: [
          // Fuel Type
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Fuel Type',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppTheme.onSurfaceVariant,
                letterSpacing: 2.0,
                fontSize: 10,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: fuelTypes.map((fuel) {
              final isSelected = _selectedFuelType == fuel.toLowerCase();
              return FilterChip(
                label: Text(fuel),
                selected: isSelected,
                onSelected: (bool value) {
                  setState(() {
                    if (value) {
                      _selectedFuelType = fuel.toLowerCase();
                    }
                  });
                },
                side: BorderSide(
                  color: isSelected
                      ? AppTheme.primaryContainer
                      : Colors.transparent,
                  width: 1,
                ),
                backgroundColor: isSelected
                    ? AppTheme.secondaryContainer
                    : AppTheme.surfaceContainerHigh,
                labelStyle: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: isSelected
                      ? AppTheme.primaryContainer
                      : AppTheme.onSurfaceVariant,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 32),
          // Transmission
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Transmission',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppTheme.onSurfaceVariant,
                letterSpacing: 2.0,
                fontSize: 10,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTransmission = transmissions[0].toLowerCase();
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color:
                          _selectedTransmission ==
                              transmissions[0].toLowerCase()
                          ? AppTheme.secondaryContainer
                          : AppTheme.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(12),
                      border:
                          _selectedTransmission ==
                              transmissions[0].toLowerCase()
                          ? Border.all(
                              color: AppTheme.primaryContainer,
                              width: 1,
                            )
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        transmissions[0],
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color:
                              _selectedTransmission ==
                                  transmissions[0].toLowerCase()
                              ? AppTheme.primaryContainer
                              : AppTheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTransmission = transmissions[1].toLowerCase();
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color:
                          _selectedTransmission ==
                              transmissions[1].toLowerCase()
                          ? AppTheme.secondaryContainer
                          : AppTheme.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(12),
                      border:
                          _selectedTransmission ==
                              transmissions[1].toLowerCase()
                          ? Border.all(
                              color: AppTheme.primaryContainer,
                              width: 1,
                            )
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        transmissions[1],
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color:
                              _selectedTransmission ==
                                  transmissions[1].toLowerCase()
                              ? AppTheme.primaryContainer
                              : AppTheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'High-End Features',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppTheme.onSurfaceVariant,
              letterSpacing: 2.0,
              fontSize: 10,
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: _selectedFeatures.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        entry.key,
                        style: const TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.onSurface,
                        ),
                      ),
                      Checkbox(
                        value: entry.value,
                        onChanged: (bool? value) {
                          setState(() {
                            _selectedFeatures[entry.key] = value ?? false;
                          });
                        },
                        activeColor: AppTheme.primaryContainer,
                        fillColor: WidgetStateProperty.resolveWith((states) {
                          if (states.contains(WidgetState.selected)) {
                            return AppTheme.primaryContainer;
                          }
                          return AppTheme.surfaceContainerHighest;
                        }),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildYearRangeSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Year Range',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppTheme.onSurfaceVariant,
              letterSpacing: 2.0,
              fontSize: 10,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: _minYearController,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 14,
                      color: AppTheme.onSurface,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Container(width: 4, height: 2, color: AppTheme.onSurfaceVariant),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: _maxYearController,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 14,
                      color: AppTheme.onSurface,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMoreFiltersLink() {
    return Center(
      child: TextButton(
        onPressed: () {
          // Handle more filters
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'More Filters',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppTheme.onSurfaceVariant,
                letterSpacing: 2.0,
                fontSize: 10,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.expand_more, color: AppTheme.onSurfaceVariant),
          ],
        ),
      ),
    );
  }

  Widget _buildActionFooter() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            AppTheme.surface,
            AppTheme.surface.withOpacity(0.9),
            AppTheme.surface.withOpacity(0),
          ],
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: GestureDetector(
        onTap: () {
          // Handle show results, transfer selected filters to results screen
          final filters = {
            'category': _selectedCategory,
            'brand': _selectedBrand,
            'model': _selectedModel,
            'bodyType': _selectedBodyType,
            'priceRange': _priceRange,
            'maxMileage': _maxMileage,
            'fuelType': _selectedFuelType,
            'transmission': _selectedTransmission,
            'features': _selectedFeatures,
            'minYear': _minYearController.text,
            'maxYear': _maxYearController.text,
          };
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SearchResultsScreen(
                totalResults: 242, // or calculate based on filters
                filters: filters,
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.primaryContainer,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryContainer.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Show 242 Results',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppTheme.onPrimaryContainer,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.0,
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: AppTheme.onPrimaryContainer,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
