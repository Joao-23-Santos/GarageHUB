import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ProfileReviewCard extends StatelessWidget {
  final String reviewerInitials;
  final String reviewerName;
  final String purchaseInfo;
  final int rating;
  final String reviewText;
  final bool isHighlighted;

  const ProfileReviewCard({
    Key? key,
    required this.reviewerInitials,
    required this.reviewerName,
    required this.purchaseInfo,
    required this.rating,
    required this.reviewText,
    this.isHighlighted = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(
            color: isHighlighted
                ? AppTheme.primaryContainer
                : AppTheme.outlineVariant.withOpacity(0.3),
            width: 4,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with avatar and rating
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Avatar
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceContainerHighest,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        reviewerInitials,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Name and purchase info
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reviewerName,
                        style: const TextStyle(
                          fontFamily: 'Space Grotesk',
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color: AppTheme.onSurface,
                        ),
                      ),
                      Text(
                        purchaseInfo,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1,
                          color: AppTheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // Stars
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    Icons.star,
                    size: 12,
                    color: index < rating
                        ? AppTheme.primaryContainer
                        : AppTheme.onSurfaceVariant.withOpacity(0.2),
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Review text
          Text(
            reviewText,
            style: const TextStyle(
              fontFamily: 'Manrope',
              fontSize: 13,
              fontStyle: FontStyle.italic,
              height: 1.4,
              color: AppTheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
