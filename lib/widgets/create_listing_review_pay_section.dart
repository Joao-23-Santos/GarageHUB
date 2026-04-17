import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CreateListingReviewPaySection extends StatefulWidget {
  final VoidCallback onPublish;

  const CreateListingReviewPaySection({
    Key? key,
    required this.onPublish,
  }) : super(key: key);

  @override
  State<CreateListingReviewPaySection> createState() => _CreateListingReviewPaySectionState();
}

class _CreateListingReviewPaySectionState extends State<CreateListingReviewPaySection> {
  String _selectedPayment = 'card';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Review & Pay',
          style: TextStyle(
            fontFamily: 'Space Grotesk',
            fontSize: 28,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
            color: AppTheme.onSurface,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryContainer.withOpacity(0.1),
                blurRadius: 30,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Standard Premium Listing',
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.6,
                            color: AppTheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Listing Fee: €10.00',
                          style: TextStyle(
                            fontFamily: 'Space Grotesk',
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: AppTheme.primaryContainer,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Icon(
                              Icons.verified_user,
                              size: 16,
                              color: AppTheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 8),
                            const Expanded(
                              child: Text(
                                'Secure encrypted checkout',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: AppTheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Payment Method',
                          style: TextStyle(
                            fontFamily: 'Space Grotesk',
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.6,
                            color: AppTheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () {
                            setState(() => _selectedPayment = 'card');
                          },
                          child: Container(
                            height: 56,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: AppTheme.surfaceContainerHighest,
                              border: Border.all(
                                color: _selectedPayment == 'card'
                                    ? AppTheme.primaryContainer
                                    : Colors.transparent,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.credit_card,
                                  color: _selectedPayment == 'card'
                                      ? AppTheme.primaryContainer
                                      : AppTheme.onSurfaceVariant,
                                  size: 20,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Card',
                                  style: TextStyle(
                                    fontFamily: 'Space Grotesk',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.8,
                                    color: _selectedPayment == 'card'
                                        ? AppTheme.primaryContainer
                                        : AppTheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () {
                            setState(() => _selectedPayment = 'mbway');
                          },
                          child: Container(
                            height: 56,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: _selectedPayment == 'mbway'
                                  ? AppTheme.surfaceContainerHighest
                                  : AppTheme.surfaceContainerLowest,
                              border: Border.all(
                                color: _selectedPayment == 'mbway'
                                    ? AppTheme.primaryContainer
                                    : Colors.transparent,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'MB WAY',
                                style: TextStyle(
                                  fontFamily: 'Space Grotesk',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w900,
                                  fontStyle: FontStyle.italic,
                                  color: _selectedPayment == 'mbway'
                                      ? AppTheme.primaryContainer
                                      : AppTheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        // Publish Button
        GestureDetector(
          onTap: widget.onPublish,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24),
            decoration: BoxDecoration(
              color: AppTheme.primaryContainer,
              borderRadius: BorderRadius.circular(999),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryContainer.withOpacity(0.2),
                  blurRadius: 40,
                  offset: const Offset(0, 20),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                'Publish Listing',
                style: TextStyle(
                  fontFamily: 'Space Grotesk',
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                  color: AppTheme.onPrimaryContainer,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: Text(
            'By publishing, you agree to our terms of service',
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 11,
              fontWeight: FontWeight.w400,
              letterSpacing: 1.6,
              color: AppTheme.onSurfaceVariant.withOpacity(0.6),
            ),
          ),
        ),
      ],
    );
  }
}
