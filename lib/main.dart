import 'package:flutter/material.dart';
import 'package:garagehub/screens/messages_screen.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'screens/search_filters_screen.dart';
import 'screens/search_results_screen.dart';
import 'screens/listing_details_screen.dart';
import 'screens/saved_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/create_listing_screen.dart';

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
        '/create_listing': (context) => const CreateListingScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/saved': (context) => const SavedScreen(),
        '/search_results': (context) => const SearchResultsScreen(
          filters: {}, // Pass empty filters for now
        ),
        '/search_filters': (context) => const SearchFiltersScreen(),
        '/listing_details': (context) {
          final car = ModalRoute.of(context)?.settings.arguments;
          if (car != null) {
            return ListingDetailsScreen(car: car as dynamic);
          }
          return const HomeScreen();
        },
        '/messages': (context) => const MessagesScreen(),
      },
    );
  }
}