import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class GalleryWithIndicators extends StatefulWidget {
  final List<String> images;
  final String imageAlt;

  const GalleryWithIndicators({
    Key? key,
    required this.images,
    required this.imageAlt,
  }) : super(key: key);

  @override
  State<GalleryWithIndicators> createState() => _GalleryWithIndicatorsState();
}

class _GalleryWithIndicatorsState extends State<GalleryWithIndicators> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main Gallery
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.6,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              return Image.network(
                widget.images[index],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppTheme.surfaceContainer,
                    child: const Center(
                      child: Icon(
                        Icons.directions_car,
                        color: AppTheme.onSurfaceVariant,
                        size: 64,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        
        // Gradient overlay
        Positioned.fill(
          child: IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppTheme.surface.withOpacity(0.3),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Indicators at bottom
        Positioned(
          bottom: 24,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainer.withOpacity(0.6),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.white.withOpacity(0.05),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  widget.images.length,
                  (index) {
                    bool isActive = index == _currentPage;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: isActive ? 32 : 6,
                        height: 3,
                        decoration: BoxDecoration(
                          color: isActive
                              ? AppTheme.primaryContainer
                              : AppTheme.onSurfaceVariant.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
