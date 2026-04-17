import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ProfileTopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onBackPressed;
  final VoidCallback onSettingsPressed;

  const ProfileTopAppBar({
    Key? key,
    required this.onBackPressed,
    required this.onSettingsPressed,
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
                onTap: onBackPressed,
                child: const Icon(
                  Icons.arrow_back,
                  color: AppTheme.primaryContainer,
                  size: 24,
                ),
              ),
              Text(
                'PROFILE',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppTheme.primaryContainer,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.5,
                      fontSize: 20,
                    ),
              ),
              GestureDetector(
                onTap: onSettingsPressed,
                child: const Icon(
                  Icons.settings,
                  color: AppTheme.primaryContainer,
                  size: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
