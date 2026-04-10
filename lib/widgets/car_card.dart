import 'package:flutter/material.dart';
import '../models/car_model.dart';
import '../theme/app_theme.dart';

class CarCard extends StatefulWidget {
  final Car car;
  final VoidCallback onTap;

  const CarCard({
    Key? key,
    required this.car,
    required this.onTap,
  }) : super(key: key);

  @override
  State<CarCard> createState() => _CarCardState();
}

class _CarCardState extends State<CarCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: _isHovered
              ? AppTheme.surfaceContainerHigh
              : AppTheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: AspectRatio(
                    aspectRatio: 16 / 10,
                    child: AnimatedScale(
                      scale: _isHovered ? 1.05 : 1.0,
                      duration: const Duration(milliseconds: 500),
                      child: Image.network(
                        widget.car.imageUrl,
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
                  ),
                ),
                // Badge
                if (widget.car.isCertified || widget.car.isTopDeal)
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: widget.car.isTopDeal
                            ? AppTheme.primaryContainer
                            : AppTheme.surface.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: widget.car.isTopDeal
                            ? [
                          BoxShadow(
                            color: AppTheme.primaryContainer
                                .withOpacity(0.3),
                            blurRadius: 8,
                          ),
                        ]
                            : [],
                      ),
                      child: Text(
                        widget.car.badge ?? 'Certified',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color: widget.car.isTopDeal
                              ? AppTheme.onPrimaryContainer
                              : AppTheme.primaryContainer,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Title and Price
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.car.fullName.toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                fontSize: 18,
                                color: AppTheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.car.subtitle,
                              style: const TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                                color: AppTheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '\$${(widget.car.price / 1000).toStringAsFixed(0)}k',
                            style: const TextStyle(
                              fontFamily: 'Space Grotesk',
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.primaryContainer,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            widget.car.priceLabel.toUpperCase(),
                            style: const TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                              color: AppTheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Specs
                  Row(
                    children: [
                      _buildSpec(Icons.speed, widget.car.mileageLabel),
                      const SizedBox(width: 16),
                      _buildSpec(
                        widget.car.fuelType == 'Electric'
                            ? Icons.bolt
                            : Icons.local_gas_station,
                        widget.car.fuelType,
                      ),
                      const SizedBox(width: 16),
                      _buildSpec(Icons.settings, widget.car.transmission),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Explore Button
                  ElevatedButton(
                    onPressed: widget.onTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.surfaceContainerHighest,
                      foregroundColor: AppTheme.onSurface,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                        side: const BorderSide(
                          color: Color(0xFF4e4632),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Text(
                      'Explore Specs'.toUpperCase(),
                      style: const TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpec(IconData icon, String label) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: AppTheme.onSurfaceVariant,
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Manrope',
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: AppTheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
