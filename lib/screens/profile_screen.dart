import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/profile_top_app_bar.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_statistics_bar.dart';
import '../widgets/profile_listing_card.dart';
import '../widgets/profile_review_card.dart';
import '../widgets/profile_account_action_button.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Sample data
  final String avatarUrl =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuDCheLEU2RziFLNZXIy6ynMcju75TW6hgFQD-VWCvawHIkob0lhtJ8X4ZwUVh7xfOCmQabaKZeaTQec5Tr9oG6p2f4vsbr_8Yqw0uttrv4idREfSdKiNsRyeA6BiXiB49uYRQXiB2Vw26dTtL__qiH1ZtbctMLVcWPMFtP4SSR-kgPk2kq7ezgjbRfeah_LsSiJ_EugfDsdvAO6MnwqS78pd0zsaFXhYl-VmJyLQbmmptSfijM5TYIrtTMbUlcsuf9pBihOHnjPRgQ';

  final List<Map<String, dynamic>> myListings = [
    {
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBqRiML-zuttzwQ3mkhcnYUOS-41qZgRebR3z8ZQ4t91x6SYDhSmhbtPmli7pcpEzj7Z1JP-m0LLtSzkO6pmnwGJAmw0ZG6Eq0t9X2bfLS3FHP5664vnVWKTJBwr5TQ0LHRnmIBh4_GYLXas8tukEB_zfwwVQ6h-IS9SzBS1zuz_xc_WRttA-T-izIa-TwFzEf2SILzG-MsEV5wXgaBeAblBLFAuURBsuMKy2ipXPgXicPNDhkMfYFf1eAT_D-DNuhfTrKCWHtL2_Q',
      'title': '2021 BMW M3',
      'subtitle': 'Competition Package • 12,400 km',
      'price': '€89,500',
    },
    {
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDoU7RGKbgfwVj7UJHGpFY2lB0FaLZUVtU_XtoWXOxD-JLUxeQZ5M3euVvgGlUG2tLfL6eEzG4Uq5mkz6bxKIhoPpyfkCdOKsh52jgb2kOk7aYHHy-wbirb5Lp5pnIdRkbCLdQKS441TaZyFPcRGCXHa87VV_VwOIbcjF6Op-SbJ31gz2EEhS3d2DviwzTBMIbF7DPXdHs7oFnAdcbHIOjwW_5iSpQ8BplH-Sf0oC3ELnkjCpedvASEQ0k3pzV5e8tLMu1iIfJxJaQ',
      'title': '2019 Audi A4',
      'subtitle': 'S-Line Edition • 45,000 km',
      'price': '€32,900',
    },
  ];

  final List<Map<String, dynamic>> reviews = [
    {
      'initials': 'MA',
      'name': 'Miguel Almeida',
      'purchase': 'Purchased BMW M2',
      'rating': 5,
      'text':
          'Ricardo was extremely professional. The car was exactly as described and the transaction was smooth.',
      'highlighted': true,
    },
    {
      'initials': 'SF',
      'name': 'Sofia Ferreira',
      'purchase': 'Purchased Mini Cooper',
      'rating': 4,
      'text':
          'Great communication. A bit slow on paperwork but overall a very positive experience.',
      'highlighted': false,
    },
  ];

  void _handleBack() {
    Navigator.of(context).pop();
  }

  void _handleSettings() {
    // Handle settings action
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Settings tapped')),
    );
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
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/search_filters');
          } else if (index == 4) {
            Navigator.pushReplacementNamed(context, '/saved');
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
                name: 'Ricardo Santos',
                location: 'Lisboa, Portugal',
                memberSince: 'Member since Oct 2021',
              ),

              // Statistics Bar
              ProfileStatisticsBar(
                activeListings: 12,
                rating: 4.8,
                followers: 156,
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
                        onPressed: () => _handleAccountAction('Edit Profile'),
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
