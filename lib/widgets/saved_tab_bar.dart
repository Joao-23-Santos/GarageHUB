import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SavedTabBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabChanged;

  const SavedTabBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        children: [
          // Vehicles Tab
          Expanded(
            child: GestureDetector(
              onTap: () => onTabChanged(0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: selectedIndex == 0
                      ? AppTheme.primaryContainer
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: selectedIndex == 0
                      ? [
                          BoxShadow(
                            color: AppTheme.primaryContainer.withOpacity(0.2),
                            blurRadius: 15,
                            spreadRadius: 0,
                          ),
                        ]
                      : [],
                ),
                child: Center(
                  child: Text(
                    'Vehicles',
                    style: TextStyle(
                      fontFamily: 'Space Grotesk',
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      letterSpacing: 0.8,
                      color: selectedIndex == 0
                          ? AppTheme.onPrimaryContainer
                          : AppTheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Searches Tab
          Expanded(
            child: GestureDetector(
              onTap: () => onTabChanged(1),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: selectedIndex == 1
                      ? AppTheme.primaryContainer
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: selectedIndex == 1
                      ? [
                          BoxShadow(
                            color: AppTheme.primaryContainer.withOpacity(0.2),
                            blurRadius: 15,
                            spreadRadius: 0,
                          ),
                        ]
                      : [],
                ),
                child: Center(
                  child: Text(
                    'Searches',
                    style: TextStyle(
                      fontFamily: 'Space Grotesk',
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      letterSpacing: 0.8,
                      color: selectedIndex == 1
                          ? AppTheme.onPrimaryContainer
                          : AppTheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
