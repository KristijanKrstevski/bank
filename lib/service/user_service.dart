import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bank/model/user.dart';

class UserService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<AuthResponse> signInWithEmailPassword(String email, String password) async {
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<AuthResponse> signUpWithEmailPassword(Users user) async {
    return await _supabase.auth.signUp(
      email: user.email,
      password: user.password,
      data: {
        'username': user.username,
        'first_name': user.firstName,
        'last_name': user.lastName,
        'gender': user.gender,
      },
    );
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

 
}