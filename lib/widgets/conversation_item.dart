import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class ConversationItem extends StatelessWidget {
  final String name;
  final String time;
  final String carModel;
  final String message;
  final String avatarUrl;
  final String carImageUrl;
  final bool isUnread;

  const ConversationItem({
    Key? key,
    required this.name,
    required this.time,
    required this.carModel,
    required this.message,
    required this.avatarUrl,
    required this.carImageUrl,
    this.isUnread = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isUnread ? AppTheme.surfaceContainerLow : AppTheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          Stack(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(avatarUrl),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryContainer,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isUnread ? AppTheme.surfaceContainerLow : AppTheme.surface,
                      width: 4,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.spaceGrotesk(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: isUnread ? AppTheme.onSurface : AppTheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      time,
                      style: GoogleFonts.manrope(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        color: isUnread ? AppTheme.primaryContainer : AppTheme.outline,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    carModel,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                      color: isUnread ? AppTheme.onSurfaceVariant : AppTheme.onSurfaceVariant.withOpacity(0.5),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isUnread ? AppTheme.onSurface : AppTheme.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Car Image
          Container(
            width: 64,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppTheme.outlineVariant.withOpacity(0.1),
              ),
              image: DecorationImage(
                image: NetworkImage(carImageUrl),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.grey,
                  BlendMode.saturation,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}