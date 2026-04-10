import 'package:flutter/material.dart';
import '../models/car_model.dart';
import '../theme/app_theme.dart';
import '../widgets/top_app_bar.dart';
import '../widgets/search_widget.dart';
import '../widgets/car_card.dart';
import '../widgets/recommendation_card.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedBottomNavIndex = 0;

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
      imageAlt: 'sleek black porsche 911 parked on modern concrete architecture',
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
      imageAlt: 'white tesla model s parked in front of futuristic charging station',
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

  final List<RecommendationCar> recommendedCars = [
    RecommendationCar(
      id: '1',
      brand: 'Audi',
      year: 2021,
      model: 'R8 V10',
      price: 142000,
      description:
          'One of the last naturally aspirated V10 icons. Immaculate service history, performance exhaust, and carbon fiber appearance package.',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBpR45Xz1hRt_hvdgBBXPAFpcYN_tb-hVr79WOfeucJeh_p3szIjPcwk0Z5FKQ4vJAaZzfhHTWBvVGe5cauqsXQTe8O-FTYdv2YMbKfCnu0L79XBl9f56far6fsrPTIZPV2eMOuugqMtFYYXPGptgBoZk7l2b5SIEnTvZqg16bDkjH9mlCkvAgucDi3Jex0H4BiQ-IEr7tcn5dmHkm-VxdWdV03mjyJazDph0TtCwmTh-Z1VIksvJyaGHCF56MW4Y7ff8Lc0q5UrlM',
      imageAlt: 'vibrant red luxury sports car profile view with aggressive lines',
      specs: {
        '0-60 MPH': '3.2 Seconds',
        'Top Speed': '205 MPH',
        'Condition': 'Mint',
      },
    ),
    RecommendationCar(
      id: '2',
      brand: 'Mercedes-Benz',
      year: 2024,
      model: 'G 63',
      price: 186000,
      description:
          'The pinnacle of off-road luxury. Hand-built AMG engine, Magno Night Black finish, and bespoke Diamond Stitching interior.',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuD4iVuqC-m5ObG2wYW_RFumGzAnpUFhGhcuhhFSFVZXmiNFP73XvJC00sYbgkq7shDaUD9iPvHIZQaqdsdCMwVPxaj0Zm5iog19tNUymZTwFAVSrTEV4XnXm_0a94EXo2Kds3XKsw8v8bDTpooY9-AiJ6YSDcn_UubdoiFOzGR7YmNPURFmcagG2Le6a0x8larpCs9MQ5xUY5qWyHWMOG8UAb6khENLXJU_0KUpPQFRJKuaRanx14PpdpqGATlCh5VTiwsfKs0W7SM',
      imageAlt: 'modern luxury suv in dark metallic grey driving on rainy street',
      specs: {
        'Power': '577 HP',
        'Torque': '627 lb-ft',
        'Drive': 'AWD',
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: TopAppBar(
          onMenuPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Menu opened')),
            );
          },
          onProfilePressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile opened')),
            );
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
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Searching inventory...')),
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
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
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
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Filters opened')),
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
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Exploring ${featuredCars[index].fullName}',
                              ),
                            ),
                          );
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
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 48,
              ),
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
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: recommendedCars.length,
                    separatorBuilder: (context, index) =>
                    const SizedBox(height: 24),
                    itemBuilder: (context, index) {
                      return RecommendationCard(
                        car: recommendedCars[index],
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Exploring ${recommendedCars[index].fullName}',
                              ),
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
          setState(() => _selectedBottomNavIndex = index);
          final navLabels = ['Home', 'Search', 'Sell', 'Messages', 'Favorites'];
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${navLabels[index]} clicked')),
          );
        },
      ),
    );
  }
}
