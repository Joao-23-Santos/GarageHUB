import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseApi {
  // Substitua estes valores pelos do seu projeto Supabase.
  static const String supabaseUrl = 'https://yvpppvvgwgawfibunqgu.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl2cHBwdnZnd2dhd2ZpYnVucWd1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODA1NzQyNTcsImV4cCI6MjA5NjE1MDI1N30.pIyezE6AT4Dl0JCKIiacrcZiW0rT9y3UbpIXiIkOAH4';

  static final SupabaseClient client = SupabaseClient(supabaseUrl, supabaseAnonKey);

  static Future<void> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String location,
  }) async {
    final response = await client.auth.signUp(email: email, password: password);

    final user = response.user;
    if (user == null) {
      throw Exception('Ocorreu um erro inesperado ao criar o utilizador.');
    }

    final fullName = '${firstName.trim()} ${lastName.trim()}'.trim();

    // NOTE: storing passwords in plain text is insecure. The password
    // is already handled by Supabase Auth; storing it again in the
    // `profiles` table is discouraged. Implemented as requested.
    await client.from('profiles').insert({
      'id': user.id,
      'full_name': fullName,
      'location': location,
    }).select();
  }

  static Future<void> login({
    required String email,
    required String password,
  }) async {
    final response = await client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    final user = response.user;
    if (user == null) {
      throw Exception('Falha ao fazer login. Verifique as suas credenciais.');
    }
  }

  static bool isUserLoggedIn() {
    return client.auth.currentUser != null;
  }

  static User? getCurrentUser() {
    return client.auth.currentUser;
  }

  /// Fetches profile row from `profiles` table for given user id.
  static Future<Map<String, dynamic>?> fetchProfile(String userId) async {
    try {
      final res = await client.from('profiles').select().eq('id', userId).limit(1).maybeSingle();
      if (res == null) return null;
      return Map<String, dynamic>.from(res as Map);
    } catch (e) {
      return null;
    }
  }

  /// Fetches listings for a user from `listings` table.
  static Future<List<Map<String, dynamic>>> fetchListings(String userId) async {
    try {
      // Backwards-compatible: try `listings`, fall back to `cars` table.
      var res = await client.from('listings').select().eq('owner_id', userId).order('created_at', ascending: false);
      if (res == null) {
        res = await client.from('cars').select().eq('seller_id', userId).order('created_at', ascending: false);
      }
      if (res == null) return [];
      return List<Map<String, dynamic>>.from(res as List);
    } catch (e) {
      return [];
    }
  }

  /// Inserts a new car listing into `cars` table.
  /// Accepts galleryImages as List<String> and technicalSpecs as Map<String, dynamic>.
  static Future<Map<String, dynamic>> createCar({
    String? id,
    required String brand,
    required String model,
    required int year,
    required double price,
    required String priceLabel,
    required String imageUrl,
    String imageAlt = '',
    required int mileage,
    String mileageLabel = '',
    required String fuelType,
    required String transmission,
    required String color,
    bool isCertified = false,
    bool isTopDeal = false,
    String? badge,
    List<String>? galleryImages,
    Map<String, dynamic>? technicalSpecs,
    String? sellerDescription,
    String? sellerId,
  }) async {
    final currentUserId = sellerId ?? client.auth.currentUser?.id;
    if (currentUserId == null) {
      throw Exception('User must be logged in to create a listing.');
    }

    final listingId = id ?? DateTime.now().millisecondsSinceEpoch.toString();

    final payload = {
      'id': listingId,
      'brand': brand,
      'model': model,
      'year': year,
      'price': price,
      'price_label': priceLabel,
      'image_url': imageUrl,
      'image_alt': imageAlt,
      'mileage': mileage,
      'mileage_label': mileageLabel,
      'fuel_type': fuelType,
      'transmission': transmission,
      'color': color,
      'is_certified': isCertified,
      'is_top_deal': isTopDeal,
      'badge': badge,
      'gallery_images': galleryImages,
      'technical_specs': technicalSpecs,
      'seller_description': sellerDescription,
      'seller_id': currentUserId,
    };

    try {
      final res = await client.from('cars').insert(payload).select();
      if (res == null) {
        throw Exception('Failed to create listing.');
      }
      if (res is List && res.isNotEmpty) return Map<String, dynamic>.from(res[0] as Map);
      if (res is Map) return Map<String, dynamic>.from(res as Map);
      throw Exception('Unexpected response from create listing.');
    } catch (e) {
      rethrow;
    }
  }

  /// Fetches cars for a seller from `cars` table.
  static Future<List<Map<String, dynamic>>> fetchCarsBySeller(String userId) async {
    try {
      final res = await client.from('cars').select().eq('seller_id', userId).order('created_at', ascending: false);
      if (res == null) return [];
      return List<Map<String, dynamic>>.from(res as List);
    } catch (e) {
      return [];
    }
  }

  /// Calculates average rating for a user from `reviews` table.
  static Future<double> fetchAverageRating(String userId) async {
    try {
      final res = await client.from('reviews').select('rating').eq('reviewed_user_id', userId);
      if (res == null) return 0.0;
      final list = res as List;
      if (list.isEmpty) return 0.0;
      double sum = 0.0;
      int count = 0;
      for (final item in list) {
        if (item is Map && item['rating'] != null) {
          final r = item['rating'];
          if (r is num) {
            sum += r.toDouble();
            count++;
          }
        } else if (item is num) {
          sum += item.toDouble();
          count++;
        }
      }
      if (count == 0) return 0.0;
      return sum / count;
    } catch (e) {
      return 0.0;
    }
  }

  /// Counts followers from `followers` table where `followed_user_id` == userId.
  static Future<int> fetchFollowersCount(String userId) async {
    try {
      final res = await client.from('followers').select().eq('followed_user_id', userId);
      if (res == null) return 0;
      if (res is List) return res.length;
      return 0;
    } catch (e) {
      return 0;
    }
  }
}
