import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class TechSpecsGrid extends StatelessWidget {
  final Map<String, String> specs;
  final int crossAxisCount;

  const TechSpecsGrid({
    Key? key,
    required this.specs,
    this.crossAxisCount = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.5,
      ),
      itemCount: specs.length,
      itemBuilder: (context, index) {
        final entry = specs.entries.toList()[index];
        return Container(
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppTheme.outlineVariant.withOpacity(0.1),
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                entry.key,
                style: const TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
              Text(
                entry.value,
                style: const TextStyle(
                  fontFamily: 'Space Grotesk',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.onSurface,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }
}

class QuickSpecsBar extends StatelessWidget {
  final String mileage;
  final String drivetrain;
  final String engine;

  const QuickSpecsBar({
    Key? key,
    required this.mileage,
    required this.drivetrain,
    required this.engine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 3,
      crossAxisSpacing: 0,
      mainAxisSpacing: 0,
      childAspectRatio: 1.2,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainerLow,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
            ),
            border: Border(
              left: BorderSide(
                color: AppTheme.outlineVariant.withOpacity(0.15),
              ),
              top: BorderSide(
                color: AppTheme.outlineVariant.withOpacity(0.15),
              ),
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'MILEAGE',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppTheme.onSurfaceVariant,
                  fontSize: 8,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                mileage,
                style: const TextStyle(
                  fontFamily: 'Space Grotesk',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryContainer,
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainerLow,
            border: Border(
              top: BorderSide(
                color: AppTheme.outlineVariant.withOpacity(0.15),
              ),
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'DRIVETRAIN',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppTheme.onSurfaceVariant,
                  fontSize: 8,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                drivetrain,
                style: const TextStyle(
                  fontFamily: 'Space Grotesk',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.onSurface,
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainerLow,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(24),
            ),
            border: Border(
              right: BorderSide(
                color: AppTheme.outlineVariant.withOpacity(0.15),
              ),
              top: BorderSide(
                color: AppTheme.outlineVariant.withOpacity(0.15),
              ),
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'ENGINE',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppTheme.onSurfaceVariant,
                  fontSize: 8,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                engine,
                style: const TextStyle(
                  fontFamily: 'Space Grotesk',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
