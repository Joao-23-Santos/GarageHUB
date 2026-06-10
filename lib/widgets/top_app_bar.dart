import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class TopAppBar extends StatelessWidget {
  final VoidCallback onMenuPressed;
  final VoidCallback onProfilePressed;
  final VoidCallback? onLanguagePressed;
  final String selectedLanguage;
  final ValueChanged<String>? onLanguageChanged;

  const TopAppBar({
    super.key,
    required this.onMenuPressed,
    required this.onProfilePressed,
    this.onLanguagePressed,
    this.selectedLanguage = 'en',
    this.onLanguageChanged,
  });

  String _getFlagEmoji(String languageCode) {
    switch (languageCode) {
      case 'en':
        return '🇺🇸';
      case 'pt':
        return '🇵🇹';
      case 'es':
        return '🇪🇸';
      case 'fr':
        return '🇫🇷';
      default:
        return '🇺🇸';
    }
  }

  String _getLanguageLabel(String languageCode) {
    switch (languageCode) {
      case 'en':
        return 'EN';
      case 'pt':
        return 'PT';
      case 'es':
        return 'ES';
      case 'fr':
        return 'FR';
      default:
        return 'EN';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.surface,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const SizedBox(width: 8),
                  Text(
                    'GARAGEHUB',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppTheme.primaryContainer,
                      fontStyle: FontStyle.italic,
                      letterSpacing: -0.02,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  PopupMenuButton<String>(
                    icon: Container(
                      height: 24,
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _getFlagEmoji(selectedLanguage),
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(width: 2),
                        ],
                      ),
                    ),
                    tooltip: 'Language',
                    onSelected: (value) {
                      if (onLanguageChanged != null) {
                        onLanguageChanged!(value);
                      }
                      debugPrint('Selected language: $value');
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem<String>(
                        value: 'en',
                        child: Row(
                          children: [
                            const Text(
                              '🇺🇸',
                              style: TextStyle(fontSize: 20),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'English',
                              style: TextStyle(
                                color: AppTheme.onSurface,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'pt',
                        child: Row(
                          children: [
                            const Text(
                              '🇵🇹',
                              style: TextStyle(fontSize: 20),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Português',
                              style: TextStyle(
                                color: AppTheme.onSurface,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'es',
                        child: Row(
                          children: [
                            const Text(
                              '🇪🇸',
                              style: TextStyle(fontSize: 20),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Español',
                              style: TextStyle(
                                color: AppTheme.onSurface,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'fr',
                        child: Row(
                          children: [
                            const Text(
                              '🇫🇷',
                              style: TextStyle(fontSize: 20),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Français',
                              style: TextStyle(
                                color: AppTheme.onSurface,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.person,
                      color: AppTheme.onSurfaceVariant,
                    ),
                    onPressed: onProfilePressed,
                    tooltip: 'Profile',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
