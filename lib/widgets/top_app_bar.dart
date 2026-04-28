import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class TopAppBar extends StatelessWidget {
  final VoidCallback onMenuPressed;
  final VoidCallback onProfilePressed;

  const TopAppBar({
    Key? key,
    required this.onMenuPressed,
    required this.onProfilePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.surface,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const SizedBox(width: 8),
                  Text(
                    'GARAGEHUB',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppTheme.primaryContainer,
                      fontStyle: FontStyle.italic,
                      letterSpacing: -0.02,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: onMenuPressed,
                    icon: const Icon(
                      Icons.flag,
                      color: AppTheme.onSurfaceVariant,
                    ),
                    tooltip: 'Language',
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.person,
                      color: AppTheme.onSurfaceVariant,
                    ),
                    onPressed: onProfilePressed,
                    tooltip: 'Profile',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
