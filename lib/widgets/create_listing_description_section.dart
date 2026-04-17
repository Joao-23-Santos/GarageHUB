import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CreateListingDescriptionSection extends StatefulWidget {
  final Function(String) onDescriptionChanged;

  const CreateListingDescriptionSection({
    Key? key,
    required this.onDescriptionChanged,
  }) : super(key: key);

  @override
  State<CreateListingDescriptionSection> createState() => _CreateListingDescriptionSectionState();
}

class _CreateListingDescriptionSectionState extends State<CreateListingDescriptionSection> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description',
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
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: _controller,
            onChanged: (value) {
              widget.onDescriptionChanged(value);
            },
            maxLines: 6,
            decoration: InputDecoration(
              hintText:
                  'Describe the vehicle\'s condition, service history, and any special features...',
              hintStyle: const TextStyle(
                color: Color(0x4DD2C5AB),
              ),
              filled: true,
              fillColor: AppTheme.surfaceContainerLowest,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppTheme.primaryContainer,
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
