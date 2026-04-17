import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ProfileStatisticsBar extends StatelessWidget {
  final int activeListings;
  final double rating;
  final int followers;

  const ProfileStatisticsBar({
    Key? key,
    required this.activeListings,
    required this.rating,
    required this.followers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 40),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          // Active Listings
          Expanded(
            child: Column(
              children: [
                Text(
                  activeListings.toString(),
                  style: const TextStyle(
                    fontFamily: 'Space Grotesk',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.primaryContainer,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Active Listings',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: AppTheme.outlineVariant.withOpacity(0.15),
          ),
          // Rating
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      rating.toString(),
                      style: const TextStyle(
                        fontFamily: 'Space Grotesk',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.primaryContainer,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.star,
                      size: 16,
                      color: AppTheme.primaryContainer,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'Rating',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: AppTheme.outlineVariant.withOpacity(0.15),
          ),
          // Followers
          Expanded(
            child: Column(
              children: [
                Text(
                  followers.toString(),
                  style: const TextStyle(
                    fontFamily: 'Space Grotesk',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.primaryContainer,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Followers',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
