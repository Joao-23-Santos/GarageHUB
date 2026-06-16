import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../API/supabase_api.dart';
import '../widgets/profile_top_app_bar.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_statistics_bar.dart';
import '../widgets/profile_listing_card.dart';
import '../widgets/profile_review_card.dart';
import '../models/car_model.dart';
import 'listing_details_screen.dart';
import '../widgets/profile_account_action_button.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Sample data
  String avatarUrl =
      'https://www.gravatar.com/avatar/?d=mp';
  String displayName = '';
  String displayLocation = '';
  String memberSince = '';
  double rating = 0.0;
  int followers = 0;
  List<Map<String, dynamic>> myListings = [];

  final List<Map<String, dynamic>> reviews = [];

  void _handleBack() {
    Navigator.pushNamed(context, "/");
  }

  void _handleSettings() {
    // Navigate to Settings screen
    Navigator.pushNamed(context, '/settings');
  }

  void _handleViewAll() {
    // Handle view all listings
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('View all listings')),
    );
  }

  void _handleAccountAction(String action) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$action tapped')),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final user = SupabaseApi.getCurrentUser();
    if (user == null) {
      // Not logged in — redirect to login
      if (mounted) Navigator.pushReplacementNamed(context, '/login');
      return;
    }

    final profile = await SupabaseApi.fetchProfile(user.id);
    var listings = await SupabaseApi.fetchListings(user.id);
    if (listings.isEmpty) {
      listings = await SupabaseApi.fetchCarsBySeller(user.id);
    }
    final avgRating = await SupabaseApi.fetchAverageRating(user.id);
    final followerCount = await SupabaseApi.fetchFollowersCount(user.id);

    setState(() {
      displayName = profile?['full_name'] ?? profile?['email'] ?? 'User';
      displayLocation = profile?['location'] ?? '';
      // Prefer profile.created_at if available
      if (profile != null && profile['created_at'] != null) {
        memberSince = 'Member since ${profile['created_at']}';
      } else {
        memberSince = '';
      }

      rating = avgRating;
      followers = followerCount;

      // Map listings into expected shape for UI, using safe fallbacks
      myListings = listings.map<Map<String, dynamic>>((l) {
        String image = '';
        if (l['image_url'] != null) {
          image = l['image_url'];
        } else if (l['main_image_url'] != null) {
          image = l['main_image_url'];
        } else if (l['images'] is List && l['images'].isNotEmpty) {
          image = l['images'][0];
        }

        final title =
            l['title'] ??
            l['name'] ??
            '${l['brand'] ?? l['make'] ?? ''} ${l['model'] ?? ''}'.trim();
        final subtitle = l['subtitle'] ??
            (l['mileage'] != null
                ? '${l['mileage']} km'
                : (l['color'] != null ? l['color'].toString() : ''));
        final price = l['price'] != null
            ? '\$${l['price']}'
            : (l['price_label']?.toString().isNotEmpty == true
                ? l['price_label'].toString()
                : '');

        return {
          'imageUrl': image,
          'title': title,
          'subtitle': subtitle,
          'price': price,
          'raw': l,
        };
      }).toList();
    });
  }

  Car _mapRawListingToCar(Map<String, dynamic> raw) {
    final mileage = raw['mileage'] is num
        ? (raw['mileage'] as num).toInt()
        : int.tryParse((raw['mileage'] ?? '').toString()) ?? 0;
    final price = raw['price'] is num
        ? (raw['price'] as num).toDouble()
        : double.tryParse((raw['price'] ?? '').toString()) ?? 0.0;
    final imageUrl = (raw['image_url'] ?? raw['main_image_url'] ?? raw['imageUrl'] ?? '').toString();
    final galleryImages = raw['gallery_images'] is List
        ? List<String>.from(raw['gallery_images'] as List)
        : null;
    final technicalSpecs = raw['technical_specs'] is Map
        ? Map<String, String>.from((raw['technical_specs'] as Map).map(
            (key, value) => MapEntry(key.toString(), value?.toString() ?? ''),
          ))
        : null;
    final priceLabel = raw['price_label']?.toString().isNotEmpty == true
        ? raw['price_label'].toString()
        : price > 0
            ? '\$${price.toStringAsFixed(0)}'
            : '';

    return Car(
      id: (raw['id'] ?? raw['listing_id'] ?? raw['car_id'] ?? '').toString(),
      brand: (raw['brand'] ?? raw['make'] ?? raw['manufacturer'] ?? '').toString(),
      year: raw['year'] is num
          ? (raw['year'] as num).toInt()
          : int.tryParse((raw['year'] ?? '').toString()) ?? 0,
      model: (raw['model'] ?? raw['name'] ?? raw['title'] ?? '').toString(),
      color: (raw['color'] ?? '').toString(),
      price: price,
      priceLabel: priceLabel,
      imageUrl: imageUrl,
      imageAlt: (raw['image_alt'] ?? raw['main_image_alt'] ?? '').toString(),
      mileage: mileage,
      mileageLabel: raw['mileage_label']?.toString().isNotEmpty == true
          ? raw['mileage_label'].toString()
          : (mileage > 0 ? '$mileage km' : ''),
      fuelType: (raw['fuel_type'] ?? raw['fuel'] ?? '').toString(),
      transmission: (raw['transmission'] ?? '').toString(),
      isCertified: raw['is_certified'] == true,
      isTopDeal: raw['is_top_deal'] == true,
      badge: raw['badge']?.toString(),
      galleryImages: galleryImages,
      technicalSpecs: technicalSpecs,
      sellerDescription: (raw['seller_description'] ?? raw['description'] ?? '').toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: ProfileTopAppBar(
        onBackPressed: _handleBack,
        onSettingsPressed: _handleSettings,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: -1, // No item selected for profile
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
          }
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Header
              ProfileHeader(
                avatarUrl: avatarUrl,
                name: displayName.isNotEmpty ? displayName : 'Your Name',
                location: displayLocation,
                memberSince: memberSince,
              ),

              // Statistics Bar
              ProfileStatisticsBar(
                activeListings: myListings.length,
                rating: rating,
                followers: followers,
              ),

              // My Listings Section
              Column(
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
                          const Text(
                            'INVENTORY',
                            style: TextStyle(
                              fontFamily: 'Space Grotesk',
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.6,
                              color: AppTheme.primaryContainer,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'My Listings',
                            style: TextStyle(
                              fontFamily: 'Space Grotesk',
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.5,
                              color: AppTheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: _handleViewAll,
                        child: const Text(
                          'View All',
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Horizontal Listings
                  SizedBox(
                    height: 280,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: myListings.length,
                      separatorBuilder: (context, index) => const SizedBox(width: 24),
                      itemBuilder: (context, index) {
                        final listing = myListings[index];
                        return ProfileListingCard(
                          imageUrl: listing['imageUrl'],
                          title: listing['title'],
                          subtitle: listing['subtitle'],
                          price: listing['price'],
                          onTap: () {
                            final raw = listing['raw'] as Map<String, dynamic>?;
                            if (raw == null) return;
                            final car = _mapRawListingToCar(raw);
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
                  ),
                ],
              ),

              const SizedBox(height: 48),

              // Ratings & Reviews Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'FEEDBACK',
                        style: TextStyle(
                          fontFamily: 'Space Grotesk',
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.6,
                          color: AppTheme.primaryContainer,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Ratings & Reviews',
                        style: TextStyle(
                          fontFamily: 'Space Grotesk',
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.5,
                          color: AppTheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Reviews
                  Column(
                    children: reviews.map((review) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: ProfileReviewCard(
                          reviewerInitials: review['initials'],
                          reviewerName: review['name'],
                          purchaseInfo: review['purchase'],
                          rating: review['rating'],
                          reviewText: review['text'],
                          isHighlighted: review['highlighted'],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),

              const SizedBox(height: 48),

              // Account Actions Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CONTROL PANEL',
                        style: TextStyle(
                          fontFamily: 'Space Grotesk',
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.6,
                          color: AppTheme.primaryContainer,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Account Actions',
                        style: TextStyle(
                          fontFamily: 'Space Grotesk',
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.5,
                          color: AppTheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Action Buttons Grid
                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      ProfileAccountActionButton(
                        icon: Icons.edit,
                        title: 'Edit Profile',
                        onPressed: (
                          () {
                            Navigator.pushNamed(context, '/edit_profile');
                          }
                        ) ,
                      ),
                      ProfileAccountActionButton(
                        icon: Icons.credit_card,
                        title: 'Payment Options',
                        onPressed: () => _handleAccountAction('Payment Options'),
                      ),
                      ProfileAccountActionButton(
                        icon: Icons.help_center,
                        title: 'Help Center',
                        onPressed: () => _handleAccountAction('Help Center'),
                      ),
                      ProfileAccountActionButton(
                        icon: Icons.logout,
                        title: 'Log Out',
                        onPressed: () => _handleAccountAction('Log Out'),
                        isDestructive: true,
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 120), // Bottom padding for nav bar
            ],
          ),
        ),
      ),
    );
  }
}
