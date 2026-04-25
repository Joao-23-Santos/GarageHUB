import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/saved_vehicle_card.dart';
import '../widgets/saved_search_item.dart';
import '../widgets/saved_tab_bar.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/saved_top_app_bar.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  int _selectedTabIndex = 0;

  // Sample saved vehicles data
  final List<Map<String, dynamic>> savedVehicles = [
    {
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCsr3S9ipQ4PwPsmPybq8fuHcFRX3tWxVNTCm_qvsMCrGmDnlrHTnGGNrl5McV_bWuQEMuVRpvtnJWDICAJrU2si4DbaNF55qn-tLJVWbbetj5_HpJq9HhYmnP8zLB_FXXsLzYYdFA-YeGUUF9xppykrNC_3mGmDzMZH6K5eoHLHRZ7zBtyTxHHKK058H1QclkjzYg5DHWC5vjqQXzCH1iRuN7J57UKt_SNhVk6GJJUwmZem7JAyFcABqEqejSZTUaFAnSt9t52x9A',
      'badge': 'Supercar',
      'title': '2023 Porsche 911 GT3 RS',
      'price': 264900.0,
      'mileage': 1240,
      'transmission': 'PDK Auto',
      'driveType': 'RWD',
    },
    {
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBKrvxMzNs_Xo_6dnqC15x3mxEAawzE5kdTw2tHNvSUHVuRoqRsoLkfpwajoZppH_4MGo1-0L-g_15vWoBr3Pza8J7XllTAcZPNgypQYdLewjQ7hT4V7GxAeIcmMaORUGkUNwZKHqCHY3QLE7EYRKhhnPAcu9lnLwPejRgq1DsPtf2qNJ7uywldy-ZcmI9-juE_xi_W3z-BskRgSq8ZwIfYlG2U6TuM3LJEUyxOEbJ1voqyTRR9HA2Q2SRMqhV2cbdbg-Driqc4YJU',
      'badge': 'Sport Sedan',
      'title': '2022 BMW M5 CS',
      'price': 142500.0,
      'mileage': 8100,
      'transmission': '8-Speed Auto',
      'driveType': 'AWD',
    },
    {
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAUyL7lt04zZl2Kxam9rVoqvAa6MxlfaiKhmOV7TfqJ6kyCz5zcwtSnh6JW6dXAnn3CwlMvj2w9HJOUgX2jh6aBJP24ItnHUrHDigvYtokCCtuE-BIj_KSTMkms8su8IMbJvjfpje8M4S3cHJArmxZejwkMzuZRjjoSnDVYcSqQ8jE22r_1xeOEcELLmfwn813CbBwDbMZ-pvFxhsTpXzti4F8yrHeFC5tkfthipHMVmIOsF6u3R8OcLO7bCEw5Xu_UDz8xfFxvcZ8',
      'badge': 'Electric Performance',
      'title': '2024 Audi RS e-tron GT',
      'price': 147000.0,
      'mileage': 50,
      'transmission': 'Electric',
      'driveType': 'Quattro',
    },
  ];

  // Sample saved searches data
  final List<Map<String, dynamic>> savedSearches = [
    {'title': 'Performance Coupes', 'listingCount': 48, 'newListingsToday': 5},
    {
      'title': 'Daily SUVs under \$50k',
      'listingCount': 124,
      'newListingsToday': 12,
    },
  ];

  void _handleDeleteSearch(int index) {
    setState(() {
      savedSearches.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Search removed'),
        backgroundColor: AppTheme.error,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handleFavoriteVehicle(int index) {
    // Handle favorite toggle
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Vehicle saved'),
        backgroundColor: AppTheme.primaryContainer,
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: SavedTopAppBar(
        onMenuPressed: () {
          // Handle menu action
        },
        onProfilePressed: () {
          // Handle profile action
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 4,
        onTap: (index) {
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
              Navigator.pushReplacementNamed(context, '/profile');
              break;
          }
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tab Bar
              SavedTabBar(
                selectedIndex: _selectedTabIndex,
                onTabChanged: (index) {
                  setState(() {
                    _selectedTabIndex = index;
                  });
                },
              ),
              const SizedBox(height: 32),

              // Content based on selected tab
              if (_selectedTabIndex == 0)
                // Vehicles Tab
                Column(
                  children: List.generate(savedVehicles.length, (index) {
                    final vehicle = savedVehicles[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: SavedVehicleCard(
                        imageUrl: vehicle['imageUrl'],
                        imageAlt: vehicle['title'],
                        badge: vehicle['badge'],
                        title: vehicle['title'],
                        price: vehicle['price'],
                        mileage: vehicle['mileage'],
                        transmission: vehicle['transmission'],
                        driveType: vehicle['driveType'],
                        onFavoritePressed: () => _handleFavoriteVehicle(index),
                      ),
                    );
                  }),
                )
              else
                // Searches Tab
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 24),
                      child: Text(
                        'SAVED SEARCHES',
                        style: TextStyle(
                          fontFamily: 'Space Grotesk',
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                          letterSpacing: 1.2,
                          color: AppTheme.primaryContainer,
                        ),
                      ),
                    ),
                    Column(
                      children: List.generate(savedSearches.length, (index) {
                        final search = savedSearches[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: SavedSearchItem(
                            title: search['title'],
                            listingCount: search['listingCount'],
                            newListingsToday: search['newListingsToday'],
                            onDelete: () => _handleDeleteSearch(index),
                          ),
                        );
                      }),
                    ),
                  ],
                ),

              // Bottom Padding for Navigation Bar
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
