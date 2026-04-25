import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/create_listing_top_app_bar.dart';
import '../widgets/create_listing_photos_section.dart';
import '../widgets/create_listing_vehicle_details_section.dart';
import '../widgets/create_listing_description_section.dart';
import '../widgets/create_listing_review_pay_section.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class CreateListingScreen extends StatefulWidget {
  const CreateListingScreen({super.key});

  @override
  State<CreateListingScreen> createState() => _CreateListingScreenState();
}

class _CreateListingScreenState extends State<CreateListingScreen> {
  late Map<String, dynamic> _listingData = {
    'photos': [],
    'brand': '',
    'model': '',
    'year': '',
    'fuelType': 'Petrol',
    'transmission': 'Automatic',
    'mileage': '',
    'price': '',
    'description': '',
  };

  void _handleDetailsChanged(Map<String, dynamic> details) {
    setState(() {
      _listingData.addAll(details);
    });
  }

  void _handleDescriptionChanged(String description) {
    setState(() {
      _listingData['description'] = description;
    });
  }

  void _handlePublish() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Listing published successfully!'),
        backgroundColor: AppTheme.primaryContainer,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: CreateListingTopAppBar(
        onBackPressed: () {
          Navigator.of(context).pop();
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 2, // Sell tab
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
              // Photos Section
              CreateListingPhotosSection(
                onMainImageTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Main image upload tapped')),
                  );
                },
                onAddImage1: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Add image 1 tapped')),
                  );
                },
                onAddImage2: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Add image 2 tapped')),
                  );
                },
              ),
              const SizedBox(height: 48),

              // Vehicle Details Section
              CreateListingVehicleDetailsSection(
                onDetailsChanged: _handleDetailsChanged,
              ),
              const SizedBox(height: 48),

              // Description Section
              CreateListingDescriptionSection(
                onDescriptionChanged: _handleDescriptionChanged,
              ),
              const SizedBox(height: 48),

              // Review & Pay Section
              CreateListingReviewPaySection(
                onPublish: _handlePublish,
              ),
              const SizedBox(height: 120), // Bottom padding for nav bar
            ],
          ),
        ),
      ),
    );
  }
}
