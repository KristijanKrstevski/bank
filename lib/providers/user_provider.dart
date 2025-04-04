import 'package:flutter/material.dart';
import 'package:bank/model/user.dart';
import 'package:bank/service/user_service.dart';

class UserProvider with ChangeNotifier {
  Users? _user;
  final UserService _userService = UserService();

  Users? get user => _user;

  Future<void> signIn(String email, String password) async {
    try {
      await _userService.signInWithEmailPassword(email, password);

      notifyListeners();
    } catch (e) {
      throw Exception("Failed to sign in: $e");
    }
  }

  Future<void> signUp(Users user) async {
    try {
      await _userService.signUpWithEmailPassword(user);
      notifyListeners();
    } catch (e) {
      throw Exception("Failed to sign up: $e");
    }
  }

  Future<void> signOut() async {
    try {
      await _userService.signOut();
      _user = null;
      notifyListeners();
    } catch (e) {
      throw Exception("Failed to sign out: $e");
    }
  }
}