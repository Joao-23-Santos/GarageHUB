import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final items = [
      _NavItem(icon: Icons.home, label: 'Home'),
      _NavItem(icon: Icons.search, label: 'Search'),
      _NavItem(icon: Icons.add_circle_outline, label: 'Sell'),
      _NavItem(icon: Icons.message_outlined, label: 'Messages'),
      _NavItem(icon: Icons.favorite_outline, label: 'Favorites'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surface.withOpacity(0.8),
        border: const Border(
          top: BorderSide(
            color: Colors.white10,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              items.length,
              (index) => _buildNavButton(
                items[index],
                index,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton(_NavItem item, int index) {
    final isSelected = widget.selectedIndex == index;

    return GestureDetector(
      onTap: () => widget.onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryContainer : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: AppTheme.primaryContainer.withOpacity(0.3),
              blurRadius: 12,
              spreadRadius: 0,
            ),
          ]
              : [],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              item.icon,
              size: 24,
              color: isSelected
                  ? AppTheme.onPrimaryContainer
                  : AppTheme.onSurfaceVariant,
            ),
            const SizedBox(height: 4),
            Text(
              item.label.toUpperCase(),
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
                color: isSelected
                    ? AppTheme.onPrimaryContainer
                    : AppTheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;

  _NavItem({
    required this.icon,
    required this.label,
  });
}
