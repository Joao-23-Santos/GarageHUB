import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SavedVehicleCard extends StatefulWidget {
  final String imageUrl;
  final String imageAlt;
  final String badge;
  final String title;
  final double price;
  final int mileage;
  final String transmission;
  final String driveType;
  final VoidCallback onFavoritePressed;
  final bool isFavorited;

  const SavedVehicleCard({
    super.key,
    required this.imageUrl,
    required this.imageAlt,
    required this.badge,
    required this.title,
    required this.price,
    required this.mileage,
    required this.transmission,
    required this.driveType,
    required this.onFavoritePressed,
    this.isFavorited = true,
  });

  @override
  State<SavedVehicleCard> createState() => _SavedVehicleCardState();
}

class _SavedVehicleCardState extends State<SavedVehicleCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section with Gradient and Favorite Button
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // Image with Hover Effect
              Container(
                height: 256,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  color: AppTheme.surfaceContainerLowest,
                ),
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    widget.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppTheme.surfaceContainerLowest,
                        child: const Icon(
                          Icons.image_not_supported,
                          color: AppTheme.onSurfaceVariant,
                        ),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: AppTheme.surfaceContainerLowest,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: AppTheme.primaryContainer,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Gradient Overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        AppTheme.surfaceContainerLow,
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              // Favorite Button - Top Right
              Positioned(
                top: 16,
                right: 16,
                child: GestureDetector(
                  onTapDown: (_) => _scaleController.forward(),
                  onTapUp: (_) {
                    _scaleController.reverse();
                    widget.onFavoritePressed();
                  },
                  onTapCancel: () => _scaleController.reverse(),
                  child: ScaleTransition(
                    scale: Tween<double>(begin: 1.0, end: 0.9)
                        .animate(_scaleController),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceContainerLowest.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.favorite,
                        color: AppTheme.primaryContainer,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Content Section
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Badge and Title Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Badge
                          Text(
                            widget.badge,
                            style: const TextStyle(
                              fontFamily: 'Space Grotesk',
                              fontWeight: FontWeight.w700,
                              fontSize: 11,
                              letterSpacing: 1.6,
                              color: AppTheme.primaryContainer,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Title
                          Text(
                            widget.title,
                            style: const TextStyle(
                              fontFamily: 'Space Grotesk',
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                              letterSpacing: -0.5,
                              color: AppTheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Price
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '\$${widget.price.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => ',')}',
                          style: const TextStyle(
                            fontFamily: 'Space Grotesk',
                            fontWeight: FontWeight.w900,
                            fontSize: 24,
                            color: AppTheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Specs Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Mileage
                    Row(
                      children: [
                        const Icon(
                          Icons.speed,
                          size: 16,
                          color: AppTheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${widget.mileage.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => ',')} mi',
                          style: const TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    // Transmission
                    Row(
                      children: [
                        const Icon(
                          Icons.settings_input_component,
                          size: 16,
                          color: AppTheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          widget.transmission,
                          style: const TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    // Drive Type
                    Row(
                      children: [
                        const Icon(
                          Icons.car_crash,
                          size: 16,
                          color: AppTheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          widget.driveType,
                          style: const TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
