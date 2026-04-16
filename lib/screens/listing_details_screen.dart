import 'package:flutter/material.dart';
import '../models/car_model.dart';
import '../theme/app_theme.dart';
import '../widgets/gallery_with_indicators.dart';
import '../widgets/seller_profile_card.dart';
import '../widgets/tech_specs_grid.dart';
import '../widgets/car_card.dart';

class ListingDetailsScreen extends StatefulWidget {
  final Car car;

  const ListingDetailsScreen({
    Key? key,
    required this.car,
  }) : super(key: key);

  @override
  State<ListingDetailsScreen> createState() => _ListingDetailsScreenState();
}

class _ListingDetailsScreenState extends State<ListingDetailsScreen> {
  bool _isFavorite = false;
  late ScrollController _scrollController;
  bool _showFloatingButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset > 300) {
      if (!_showFloatingButton) {
        setState(() => _showFloatingButton = true);
      }
    } else {
      if (_showFloatingButton) {
        setState(() => _showFloatingButton = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 1024;
    final images = widget.car.galleryImages ??
        [
          widget.car.imageUrl,
          widget.car.imageUrl,
          widget.car.imageUrl,
        ];

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // App Bar
          SliverAppBar(
            pinned: true,
            elevation: 0,
            backgroundColor: AppTheme.surface.withOpacity(0.8),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppTheme.primaryContainer),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'Vehicle Market',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppTheme.primaryContainer,
                fontStyle: FontStyle.italic,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.share, color: AppTheme.primaryContainer),
                onPressed: () {
                  // Share functionality
                },
              ),
            ],
          ),

          // Gallery
          SliverToBoxAdapter(
            child: GalleryWithIndicators(
              images: images,
              imageAlt: widget.car.imageAlt,
            ),
          ),

          // Main Content
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 48,
                vertical: 32,
              ),
              child: isMobile
                  ? _buildMobileLayout(context)
                  : _buildDesktopLayout(context),
            ),
          ),

          // Similar Cars Section
          if (widget.car.similarCars != null && widget.car.similarCars!.isNotEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 48,
                  vertical: 32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'More from this collection',
                          style:
                              Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontFamily: 'Space Grotesk',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'See all (${widget.car.similarCars!.length})',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                            color: AppTheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isMobile ? 1 : 3,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1.2,
                      ),
                      itemCount: widget.car.similarCars!.length,
                      itemBuilder: (context, index) {
                        return CarCard(
                          car: widget.car.similarCars![index],
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ListingDetailsScreen(
                                  car: widget.car.similarCars![index],
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
            ),

          // Bottom spacing
          SliverToBoxAdapter(
            child: SizedBox(height: isMobile ? 100 : 60),
          ),
        ],
      ),

      // Bottom Action Bar (Mobile)
      bottomSheet: isMobile
          ? Container(
        color: AppTheme.surfaceContainerLowest.withOpacity(0.9),
        padding: EdgeInsets.fromLTRB(16, 12, 16, 16 + MediaQuery.of(context).padding.bottom),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Request quote functionality
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryContainer,
                  foregroundColor: AppTheme.onPrimaryContainer,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'REQUEST QUOTE',
                  style: TextStyle(
                    fontFamily: 'Space Grotesk',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 56,
              height: 56,
              child: OutlinedButton(
                onPressed: () => setState(() => _isFavorite = !_isFavorite),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: AppTheme.outlineVariant.withOpacity(0.3),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Icon(
                  _isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: _isFavorite
                      ? AppTheme.primaryContainer
                      : AppTheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      )
          : null,

      // Floating Action Button (Desktop)
      floatingActionButton: !isMobile && _showFloatingButton
          ? FloatingActionButton.extended(
        onPressed: () {
          // Buy now functionality
        },
        backgroundColor: AppTheme.primaryContainer,
        foregroundColor: AppTheme.onPrimaryContainer,
        label: const Text(
          'BUY NOW',
          style: TextStyle(
            fontFamily: 'Space Grotesk',
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        icon: const Icon(Icons.bolt),
      )
          : null,
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title & Primary Info
        _buildTitleSection(context),
        const SizedBox(height: 24),

        // Quick Specs Bar
        QuickSpecsBar(
          mileage: '${widget.car.mileage} mi',
          drivetrain: 'RWD PDK',
          engine: '4.0L FLAT-6',
        ),
        const SizedBox(height: 32),

        // Tech Specs
        if (widget.car.technicalSpecs != null) ...[
          _buildSectionTitle(context, 'Technical Specifications'),
          const SizedBox(height: 16),
          TechSpecsGrid(
            specs: widget.car.technicalSpecs!,
            crossAxisCount: 2,
          ),
          const SizedBox(height: 32),
        ],

        // Seller Description
        if (widget.car.sellerDescription != null) ...[
          _buildSectionTitle(context, 'Seller Description'),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(24),
              border: Border(
                left: BorderSide(
                  color: AppTheme.primaryContainer,
                  width: 4,
                ),
              ),
            ),
            padding: const EdgeInsets.all(20),
            child: Text(
              widget.car.sellerDescription!,
              style: const TextStyle(
                fontFamily: 'Manrope',
                fontSize: 16,
                height: 1.6,
                color: AppTheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],

        // Seller Profile Card
        if (widget.car.sellerInfo != null)
          SellerProfileCard(
            sellerInfo: widget.car.sellerInfo!,
            onContactPressed: () {
              // Contact seller
            },
            onMessagePressed: () {
              // Message seller
            },
          ),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Column
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title & Primary Info
              _buildTitleSection(context),
              const SizedBox(height: 32),

              // Quick Specs Bar
              QuickSpecsBar(
                mileage: '${widget.car.mileage} mi',
                drivetrain: 'RWD PDK',
                engine: '4.0L FLAT-6',
              ),
              const SizedBox(height: 32),

              // Tech Specs
              if (widget.car.technicalSpecs != null) ...[
                _buildSectionTitle(context, 'Technical Specifications'),
                const SizedBox(height: 16),
                TechSpecsGrid(
                  specs: widget.car.technicalSpecs!,
                  crossAxisCount: 2,
                ),
                const SizedBox(height: 32),
              ],

              // Seller Description
              if (widget.car.sellerDescription != null) ...[
                _buildSectionTitle(context, 'Seller Description'),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(24),
                    border: Border(
                      left: BorderSide(
                        color: AppTheme.primaryContainer,
                        width: 4,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    widget.car.sellerDescription!,
                    style: const TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 16,
                      height: 1.6,
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        
        const SizedBox(width: 48),

        // Right Column - Sticky Sidebar
        if (widget.car.sellerInfo != null)
          Expanded(
            child: SingleChildScrollView(
              child: SellerProfileCard(
                sellerInfo: widget.car.sellerInfo!,
                onContactPressed: () {
                  // Contact seller
                },
                onMessagePressed: () {
                  // Message seller
                },
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTitleSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Badges
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.secondaryContainer,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Text(
                'New Listing',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                  color: AppTheme.onSurface,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Text(
                'Verified Tech',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Title
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '${widget.car.year} ${widget.car.brand} ',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                ),
              ),
              TextSpan(
                text: widget.car.model,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  color: AppTheme.primaryContainer,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Price
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '\$${widget.car.price.toStringAsFixed(0)}',
              style: const TextStyle(
                fontFamily: 'Space Grotesk',
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppTheme.onSurface,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Est. \$${(widget.car.price * 0.0155).toStringAsFixed(0)}/mo with 20% down',
              style: const TextStyle(
                fontFamily: 'Manrope',
                fontSize: 14,
                color: AppTheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 2,
          color: AppTheme.primaryContainer,
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}
