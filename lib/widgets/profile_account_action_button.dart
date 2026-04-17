import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ProfileAccountActionButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onPressed;
  final bool isDestructive;

  const ProfileAccountActionButton({
    Key? key,
    required this.icon,
    required this.title,
    required this.onPressed,
    this.isDestructive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final iconColor = isDestructive ? AppTheme.error : AppTheme.onSurfaceVariant;
    final textColor = isDestructive ? AppTheme.error : AppTheme.onSurface;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24,
              color: iconColor,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Space Grotesk',
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
                color: textColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
