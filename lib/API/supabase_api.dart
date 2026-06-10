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
      'email': email,
      'full_name': fullName,
      'password': password,
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
}
