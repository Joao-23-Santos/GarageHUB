import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CreateListingTopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onBackPressed;

  const CreateListingTopAppBar({
    Key? key,
    required this.onBackPressed,
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
              Row(
                children: [
                  GestureDetector(
                    onTap: onBackPressed,
                    child: const Icon(
                      Icons.arrow_back,
                      color: AppTheme.primaryContainer,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'CREATE LISTING',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: AppTheme.primaryContainer,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.5,
                          fontSize: 20,
                        ),
                  ),
                ],
              ),
              const Text(
                'VEHICLEMARKET',
                style: TextStyle(
                  fontFamily: 'Space Grotesk',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
