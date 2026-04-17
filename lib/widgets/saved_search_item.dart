import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SavedSearchItem extends StatefulWidget {
  final String title;
  final int listingCount;
  final int newListingsToday;
  final VoidCallback onDelete;

  const SavedSearchItem({
    super.key,
    required this.title,
    required this.listingCount,
    required this.newListingsToday,
    required this.onDelete,
  });

  @override
  State<SavedSearchItem> createState() => _SavedSearchItemState();
}

class _SavedSearchItemState extends State<SavedSearchItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left Content: Icon + Title + Info
          Row(
            children: [
              // Search Icon Container
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppTheme.secondaryContainer,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.search,
                  color: AppTheme.secondary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              // Title and Info
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontFamily: 'Space Grotesk',
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: AppTheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${widget.listingCount} listings • ${widget.newListingsToday} new today',
                    style: const TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Delete Button
          GestureDetector(
            onTapDown: (_) => _scaleController.forward(),
            onTapUp: (_) {
              _scaleController.reverse();
              widget.onDelete();
            },
            onTapCancel: () => _scaleController.reverse(),
            child: ScaleTransition(
              scale: Tween<double>(begin: 1.0, end: 0.9)
                  .animate(_scaleController),
              child: const Icon(
                Icons.delete,
                color: AppTheme.error,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
