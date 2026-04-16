import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SearchWidget extends StatefulWidget {
  final VoidCallback onSearch;

  const SearchWidget({
    Key? key,
    required this.onSearch,
  }) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  String? selectedBrand = 'All Brands';
  String? selectedModel = 'Any Model';
  String? selectedYear = '2020 - 2024';
  String? selectedPrice = '\$50k - \$100k';

  final List<String> brands = [
    'All Brands',
    'Porsche',
    'Tesla',
    'BMW',
    'Audi',
    'Mercedes-Benz',
  ];

  final List<String> models = [
    'Any Model',
    '911 GT3',
    'Model S',
    'M4 Competition',
    'R8 V10',
    'G 63',
  ];

  final List<String> years = [
    '2020 - 2024',
    '2015 - 2019',
    'Classic',
  ];

  final List<String> prices = [
    '\$50k - \$100k',
    '\$100k - \$250k',
    '\$250k+',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: const Border(
          left: BorderSide(
            color: AppTheme.primaryContainer,
            width: 4,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 16,
            spreadRadius: 0,
          ),
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Grid 2x2 de dropdowns
          GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 0,
            crossAxisSpacing: 8,
            childAspectRatio: 1.9,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildDropdown(
                label: 'Brand',
                value: selectedBrand,
                items: brands,
                onChanged: (value) => setState(() => selectedBrand = value),
              ),
              _buildDropdown(
                label: 'Model',
                value: selectedModel,
                items: models,
                onChanged: (value) => setState(() => selectedModel = value),
              ),
              _buildDropdown(
                label: 'Year',
                value: selectedYear,
                items: years,
                onChanged: (value) => setState(() => selectedYear = value),
              ),
              _buildDropdown(
                label: 'Price Range',
                value: selectedPrice,
                items: prices,
                onChanged: (value) => setState(() => selectedPrice = value),
              ),
            ],
          ),
          const SizedBox(height: 0),
          // Search Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: widget.onSearch,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryContainer,
                foregroundColor: AppTheme.onPrimaryContainer,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                elevation: 8,
                shadowColor: AppTheme.primaryContainer.withOpacity(0.4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.search, size: 16),
                  const SizedBox(width: 6),
                  Text(
                    'Search Inventory'.toUpperCase(),
                    style: const TextStyle(
                      fontFamily: 'Space Grotesk',
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontFamily: 'Manrope',
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.0,
            color: AppTheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 2),
        DropdownButtonFormField<String>(
          value: value,
          items: items
              .map((item) => DropdownMenuItem(
                value: item,
                child: Text(item),
              ))
              .toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 8,
            ),
          ),
          style: const TextStyle(
            fontFamily: 'Manrope',
            fontSize: 14,
            color: AppTheme.onSurface,
          ),
          dropdownColor: AppTheme.surfaceContainer,
          icon: const Icon(Icons.expand_more, color: AppTheme.onSurfaceVariant),
        ),
      ],
    );
  }
}
