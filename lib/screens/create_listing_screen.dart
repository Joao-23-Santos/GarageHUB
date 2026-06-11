import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../API/supabase_api.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
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
  late final Map<String, dynamic> _listingData = {
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

  Future<void> _pickImage(int slot) async {
    final picker = ImagePicker();
    final XFile? picked = await picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (picked == null) return;

    final path = picked.path;
    setState(() {
      final photos = List<String>.from(_listingData['photos'] as List);
      if (slot < photos.length) {
        photos[slot] = path;
      } else {
        // ensure list has enough length
        while (photos.length <= slot) photos.add('');
        photos[slot] = path;
      }
      _listingData['photos'] = photos;
    });
  }

  void _handleDescriptionChanged(String description) {
    setState(() {
      _listingData['description'] = description;
    });
  }

  void _handlePublish() {
    _publishListing();
  }

  Future<void> _publishListing() async {
    // Basic validation
    if ((_listingData['brand'] ?? '').toString().isEmpty || (_listingData['model'] ?? '').toString().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill brand and model before publishing.')),
      );
      return;
    }

    try {
      final price = double.tryParse((_listingData['price'] ?? '').toString()) ?? 0.0;
      final year = int.tryParse((_listingData['year'] ?? '').toString()) ?? 0;
      final mileage = int.tryParse((_listingData['mileage'] ?? '').toString()) ?? 0;

      await SupabaseApi.createCar(
        brand: (_listingData['brand'] ?? '').toString(),
        model: (_listingData['model'] ?? '').toString(),
        year: year,
        price: price,
        priceLabel: (_listingData['price_label'] ?? '').toString(),
        imageUrl: (_listingData['photos'] is List && (_listingData['photos'] as List).isNotEmpty) ? (_listingData['photos'][0]).toString() : '',
        imageAlt: (_listingData['image_alt'] ?? '').toString(),
        mileage: mileage,
        mileageLabel: (_listingData['mileage_label'] ?? '').toString(),
        fuelType: (_listingData['fuelType'] ?? 'Petrol').toString(),
        transmission: (_listingData['transmission'] ?? 'Automatic').toString(),
        color: (_listingData['color'] ?? '').toString(),
        isCertified: (_listingData['is_certified'] ?? false) as bool,
        isTopDeal: (_listingData['is_top_deal'] ?? false) as bool,
        badge: (_listingData['badge'] ?? '').toString(),
        galleryImages: (_listingData['photos'] is List) ? List<String>.from(_listingData['photos'] as List) : null,
        technicalSpecs: (_listingData['technical_specs'] is Map) ? Map<String, dynamic>.from(_listingData['technical_specs'] as Map) : null,
        sellerDescription: (_listingData['description'] ?? '').toString(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Listing published successfully!'),
          backgroundColor: AppTheme.primaryContainer,
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error publishing listing: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: CreateListingTopAppBar(
        onBackPressed: () {
          Navigator.pushReplacementNamed(context, '/');
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
              Navigator.pushReplacementNamed(context, '/saved');
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
                onMainImageTap: () => _pickImage(0),
                onAddImage1: () => _pickImage(1),
                onAddImage2: () => _pickImage(2),
                mainImage: (_listingData['photos'] is List && (_listingData['photos'] as List).isNotEmpty) ? (_listingData['photos'][0] as String) : null,
                image1: (_listingData['photos'] is List && (_listingData['photos'] as List).length > 1) ? (_listingData['photos'][1] as String) : null,
                image2: (_listingData['photos'] is List && (_listingData['photos'] as List).length > 2) ? (_listingData['photos'][2] as String) : null,
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
