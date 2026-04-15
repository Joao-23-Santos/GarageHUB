import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'screens/search_filters_screen.dart';
import 'screens/search_results_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VehicleMarket',
      theme: AppTheme.darkTheme,
      home: const HomeScreen(),
      routes: {
        '/search_results': (context) => const SearchResultsScreen(),
        '/search_filters': (context) => const SearchFiltersScreen(),
      },
    );
  }
}