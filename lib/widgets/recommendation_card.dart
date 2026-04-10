import 'package:flutter/material.dart';
import '../models/car_model.dart';
import '../theme/app_theme.dart';

class RecommendationCard extends StatefulWidget {
  final RecommendationCar car;
  final VoidCallback onTap;

  const RecommendationCard({
    Key? key,
    required this.car,
    required this.onTap,
  }) : super(key: key);

  @override
  State<RecommendationCard> createState() => _RecommendationCardState();
}

class _RecommendationCardState extends State<RecommendationCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

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
          border: Border.all(
            color: Colors.transparent,
          ),
        ),
        child: Column(
          children: [
            if (isMobile)
              // Mobile: Stack layout
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: Image.network(
                      widget.car.imageUrl,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
                          color: AppTheme.surfaceContainerHighest,
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
                  _buildContent(context),
                ],
              )
            else
              // Desktop: Row layout
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.33 - 12,
                    child: AspectRatio(
                      aspectRatio: 4 / 3,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        ),
                        child: Image.network(
                          widget.car.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: AppTheme.surfaceContainerHighest,
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
                  Expanded(
                    child: _buildContent(context),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Title and Price Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  widget.car.fullName.toUpperCase(),
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppTheme.onSurface,
                    fontSize: 22,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '\$${(widget.car.price / 1000).toStringAsFixed(0)}k',
                style: const TextStyle(
                  fontFamily: 'Space Grotesk',
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primaryContainer,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Description
          Text(
            widget.car.description,
            style: const TextStyle(
              fontFamily: 'Manrope',
              fontSize: 14,
              color: AppTheme.onSurfaceVariant,
              height: 1.5,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 24),
          // Specs Grid
          GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 12,
            crossAxisSpacing: 24,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: widget.car.specs.entries
                .map((entry) => _buildSpecItem(entry.key, entry.value))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontFamily: 'Manrope',
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
            color: AppTheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Space Grotesk',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppTheme.onSurface,
          ),
        ),
      ],
    );
  }
}
