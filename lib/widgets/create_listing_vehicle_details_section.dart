import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CreateListingVehicleDetailsSection extends StatefulWidget {
  final Function(Map<String, dynamic>) onDetailsChanged;

  const CreateListingVehicleDetailsSection({
    Key? key,
    required this.onDetailsChanged,
  }) : super(key: key);

  @override
  State<CreateListingVehicleDetailsSection> createState() => _CreateListingVehicleDetailsSectionState();
}

class _CreateListingVehicleDetailsSectionState extends State<CreateListingVehicleDetailsSection> {
  final _formData = <String, dynamic>{
    'brand': '',
    'model': '',
    'year': '',
    'fuelType': 'Petrol',
    'transmission': 'Automatic',
    'mileage': '',
    'price': '',
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Vehicle Details',
          style: TextStyle(
            fontFamily: 'Space Grotesk',
            fontSize: 28,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
            color: AppTheme.onSurface,
          ),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              // Brand and Model Row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Brand',
                          style: TextStyle(
                            fontFamily: 'Space Grotesk',
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.6,
                            color: AppTheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          onChanged: (value) {
                            setState(() => _formData['brand'] = value);
                            widget.onDetailsChanged(_formData);
                          },
                          decoration: InputDecoration(
                            hintText: 'e.g. Porsche',
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
                            contentPadding:
                                const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Model',
                          style: TextStyle(
                            fontFamily: 'Space Grotesk',
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.6,
                            color: AppTheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          onChanged: (value) {
                            setState(() => _formData['model'] = value);
                            widget.onDetailsChanged(_formData);
                          },
                          decoration: InputDecoration(
                            hintText: 'e.g. 911 GT3',
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
                            contentPadding:
                                const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Year and Fuel Type Row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Year',
                          style: TextStyle(
                            fontFamily: 'Space Grotesk',
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.6,
                            color: AppTheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() => _formData['year'] = value);
                            widget.onDetailsChanged(_formData);
                          },
                          decoration: InputDecoration(
                            hintText: '2024',
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
                            contentPadding:
                                const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Fuel Type',
                          style: TextStyle(
                            fontFamily: 'Space Grotesk',
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.6,
                            color: AppTheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: _formData['fuelType'],
                          items: const [
                            DropdownMenuItem(
                              value: 'Petrol',
                              child: Text('Petrol'),
                            ),
                            DropdownMenuItem(
                              value: 'Diesel',
                              child: Text('Diesel'),
                            ),
                            DropdownMenuItem(
                              value: 'Electric',
                              child: Text('Electric'),
                            ),
                            DropdownMenuItem(
                              value: 'Hybrid',
                              child: Text('Hybrid'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() => _formData['fuelType'] = value);
                            widget.onDetailsChanged(_formData);
                          },
                          decoration: InputDecoration(
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
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Transmission buttons
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Transmission',
                    style: TextStyle(
                      fontFamily: 'Space Grotesk',
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.6,
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(
                              () => _formData['transmission'] = 'Automatic',
                            );
                            widget.onDetailsChanged(_formData);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: _formData['transmission'] == 'Automatic'
                                  ? AppTheme.primaryContainer
                                  : AppTheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                'Automatic',
                                style: TextStyle(
                                  fontFamily: 'Space Grotesk',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.8,
                                  color: _formData['transmission'] ==
                                          'Automatic'
                                      ? AppTheme.onPrimaryContainer
                                      : AppTheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() => _formData['transmission'] = 'Manual');
                            widget.onDetailsChanged(_formData);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color:
                                  _formData['transmission'] == 'Manual'
                                      ? AppTheme.primaryContainer
                                      : AppTheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                'Manual',
                                style: TextStyle(
                                  fontFamily: 'Space Grotesk',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.8,
                                  color: _formData['transmission'] == 'Manual'
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
                ],
              ),
              const SizedBox(height: 24),
              // Mileage
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Mileage (km)',
                    style: TextStyle(
                      fontFamily: 'Space Grotesk',
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.6,
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() => _formData['mileage'] = value);
                      widget.onDetailsChanged(_formData);
                    },
                    decoration: InputDecoration(
                      hintText: '0',
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
                ],
              ),
              const SizedBox(height: 24),
              // More Filters Button
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceContainerHighest,
                    border: Border.all(
                      color: AppTheme.outlineVariant.withOpacity(0.2),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'More Filters',
                        style: TextStyle(
                          fontFamily: 'Space Grotesk',
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.6,
                          color: AppTheme.onSurfaceVariant,
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right,
                        color: AppTheme.onSurfaceVariant,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Asking Price
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Asking Price',
                    style: TextStyle(
                      fontFamily: 'Space Grotesk',
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.6,
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() => _formData['price'] = value);
                      widget.onDetailsChanged(_formData);
                    },
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                    decoration: InputDecoration(
                      prefixText: '€ ',
                      prefixStyle: const TextStyle(
                        color: AppTheme.primaryContainer,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                      hintText: '0.00',
                      hintStyle: const TextStyle(
                        color: Color(0x33D2C5AB),
                        fontSize: 28,
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
                        vertical: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
