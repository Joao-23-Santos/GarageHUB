import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ProfileHeader extends StatelessWidget {
  final String avatarUrl;
  final String name;
  final String location;
  final String memberSince;

  const ProfileHeader({
    Key? key,
    required this.avatarUrl,
    required this.name,
    required this.location,
    required this.memberSince,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 32),
        // Avatar with verification badge
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              width: 128,
              height: 128,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppTheme.primaryContainer,
                  width: 2,
                ),
                color: AppTheme.surfaceContainerLow,
              ),
              padding: const EdgeInsets.all(4),
              child: ClipOval(
                child: Image.network(
                  avatarUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppTheme.surfaceContainerLowest,
                      child: const Icon(
                        Icons.person,
                        color: AppTheme.onSurfaceVariant,
                        size: 48,
                      ),
                    );
                  },
                ),
              ),
            ),
            // Verification badge
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppTheme.primaryContainer,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppTheme.surface,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.verified,
                color: AppTheme.onPrimaryContainer,
                size: 18,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        // Name
        Text(
          name,
          style: const TextStyle(
            fontFamily: 'Space Grotesk',
            fontSize: 30,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
            color: AppTheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        // Location
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.location_on,
              size: 16,
              color: AppTheme.onSurfaceVariant,
            ),
            const SizedBox(width: 8),
            Text(
              location,
              style: const TextStyle(
                fontFamily: 'Manrope',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppTheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Member since
        Text(
          memberSince,
          style: const TextStyle(
            fontFamily: 'Space Grotesk',
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.6,
            color: AppTheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
