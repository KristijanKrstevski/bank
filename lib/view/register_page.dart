import 'package:bank/model/user.dart';
import 'package:bank/service/user_service.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final userService = UserService();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _genderController = TextEditingController();

  void signUp() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    final username = _usernameController.text;
    final firstName = _firstNameController.text;
    final lastName = _lastNameController.text;
    final gender = _genderController.text;

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Passwords don't match")));
      return;
    }

    final user = Users(
      username: username,
      email: email,
      firstName: firstName,
      lastName: lastName,
      password: password,
      gender: gender,
    );

    try {
      await userService.signUpWithEmailPassword(user);
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: "Email",
              hintText: "Enter your email",
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: "Username",
              hintText: "Enter your username",
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _firstNameController,
            decoration: const InputDecoration(
              labelText: "First Name",
              hintText: "Enter your first name",
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _lastNameController,
            decoration: const InputDecoration(
              labelText: "Last Name",
              hintText: "Enter your last name",
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _genderController,
            decoration: const InputDecoration(
              labelText: "Gender",
              hintText: "Enter your gender",
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(
              labelText: "Password",
              hintText: "Enter your password",
            ),
            obscureText: true,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _confirmPasswordController,
            decoration: const InputDecoration(
              labelText: "Confirm Password",
              hintText: "Confirm your password",
            ),
            obscureText: true,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: signUp,
            child: const Text("Sign Up"),
          ),
        ],
      ),
    );
  }
}