import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SavedTopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onMenuPressed;
  final VoidCallback onProfilePressed;

  const SavedTopAppBar({
    Key? key,
    required this.onMenuPressed,
    required this.onProfilePressed,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

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
              GestureDetector(
                onTap: onMenuPressed,
                child: const Icon(
                  Icons.menu,
                  color: AppTheme.primaryContainer,
                  size: 24,
                ),
              ),
              Text(
                'SAVED',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppTheme.primaryContainer,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      fontSize: 20,
                    ),
              ),
              GestureDetector(
                onTap: onProfilePressed,
                child: const Icon(
                  Icons.account_circle,
                  color: AppTheme.primaryContainer,
                  size: 28,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
