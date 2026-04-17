import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CreateListingPhotosSection extends StatelessWidget {
  final VoidCallback onMainImageTap;
  final VoidCallback onAddImage1;
  final VoidCallback onAddImage2;

  const CreateListingPhotosSection({
    Key? key,
    required this.onMainImageTap,
    required this.onAddImage1,
    required this.onAddImage2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Photos',
              style: const TextStyle(
                fontFamily: 'Space Grotesk',
                fontSize: 28,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
                color: AppTheme.onSurface,
              ),
            ),
            Text(
              'Max 10 images',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.5,
                color: AppTheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Grid layout: 3x1 main + 2 small images
        SizedBox(
          height: 400,
          child: Row(
            children: [
              // Main image (col-span-3 row-span-2)
              Expanded(
                flex: 3,
                child: GestureDetector(
                  onTap: onMainImageTap,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppTheme.outlineVariant,
                        width: 2,
                        strokeAlign: BorderSide.strokeAlignOutside,
                      ),
                    ),
                    child: Stack(
                      children: [
                        // Background image with opacity
                        Positioned.fill(
                          child: Image.network(
                            'https://lh3.googleusercontent.com/aida-public/AB6AXuATpLqOY00q2ouo9wtkxMp2ts_mnQrlJxjNTQ-bogPHfWQXbis8A79MPtdjkBI8uN9XL8jjvH0gDJpoUL7R7Tk-emUJDWFfI_N1SaQHfxl3xnDM6P7CnJveR7M4NwhR1jm3rQEnPWTGO_7PsprPlHFokN4iwIqTcK_Y2A3J0WU064ht-thHoQlTHU43Iqm3J2sV1m6--9MAaSloOFTorJbJ8pBmbQhmopmdsh7j7NonSFQFvquat7s5JzY1dKxW7SEKQRxebIF-Awc',
                            fit: BoxFit.cover,
                            opacity: const AlwaysStoppedAnimation(0.4),
                          ),
                        ),
                        // Content overlay
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryContainer,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 15,
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.add_a_photo,
                                  color: AppTheme.onPrimaryContainer,
                                  size: 32,
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Main Cover Image',
                                style: TextStyle(
                                  fontFamily: 'Space Grotesk',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5,
                                  color: AppTheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Drag and drop or click to upload',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: AppTheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Right side images column
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: onAddImage1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppTheme.surfaceContainerHigh,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppTheme.outlineVariant.withOpacity(0.15),
                              width: 1,
                            ),
                          ),
                          child: const Icon(
                            Icons.image,
                            color: AppTheme.onSurfaceVariant,
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: onAddImage2,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppTheme.surfaceContainerHigh,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppTheme.outlineVariant.withOpacity(0.15),
                              width: 1,
                            ),
                          ),
                          child: const Icon(
                            Icons.image,
                            color: AppTheme.onSurfaceVariant,
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
