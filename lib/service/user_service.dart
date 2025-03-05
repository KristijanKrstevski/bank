import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bank/model/user.dart';
import 'package:flutter/foundation.dart' as foundation;

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
// Future<AuthResponse> signInWithGoogle() async {
//     const webClientId = '523302827652-l9e1ul100me9ms5k6mqelf3k012gj9m4.apps.googleusercontent.com';
//     const iosClientId = '523302827652-dfc4nacmdl18s8nmtt7p40moi20gr4cn.apps.googleusercontent.com';

//     final GoogleSignIn googleSignIn = GoogleSignIn(
//       clientId: foundation.kIsWeb ? webClientId : iosClientId,
//       serverClientId: webClientId,
//       scopes: ['email'],
//       forceSignIn: true, // Ensures user is always prompted to choose an account
//     );

//     final googleUser = await googleSignIn.signIn();
//     if (googleUser == null) {
//       throw Exception('Google sign-in aborted.');
//     }

//     final googleAuth = await googleUser.authentication;
//     final accessToken = googleAuth.accessToken;
//     final idToken = googleAuth.idToken;

//     if (idToken == null || accessToken == null) {
//       throw Exception('Google authentication failed.');
//     }

//     return await _supabase.auth.signInWithIdToken(
//       provider: OAuthProvider.google,
//       idToken: idToken,
//       accessToken: accessToken,
//     );
//   }

//   Future<void> signInWithGoogleWeb() async {
//     await _supabase.auth.signInWithOAuth(
//       OAuthProvider.google,
//       redirectTo: 'https://your-app-url.com', // Replace with your app's redirect URL
//       authScreen: true, // Ensures Google prompts for account selection
//     );
//   }





  Future<void> signInWithGoogle() async {
  try {
    if (foundation.kIsWeb) {
      // 🔹 Web authentication using Supabase OAuth
      await _supabase.auth.signInWithOAuth(OAuthProvider.google);
    } else {
      // 🔹 Mobile (Android/iOS) Google Sign-In Flow
      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS
            ? '523302827652-dfc4nacmdl18s8nmtt7p40moi20gr4cn.apps.googleusercontent.com' // iOS Client ID
            : null, // Android does not need clientId
        serverClientId:
            '523302827652-l9e1ul100me9ms5k6mqelf3k012gj9m4.apps.googleusercontent.com', // Web Client ID
      );

      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Google sign-in aborted.');
      }

      final googleAuth = await googleUser.authentication;
      final idToken = googleAuth.idToken;
      final accessToken = googleAuth.accessToken;

      if (idToken == null || accessToken == null) {
        throw Exception('Google authentication failed.');
      }

      await _supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google, // ✅ Fixed: Use OAuthProvider.google
        idToken: idToken,
        accessToken: accessToken,
      );
    }
  } catch (e) {
    throw Exception("Google Sign-In Failed: $e");
  }
}

}
