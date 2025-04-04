import 'package:bank/model/user.dart';
import 'package:bank/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true, 
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1D2671), Color(0xFFC33764)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: screenHeight * 0.15, 
                  bottom: screenHeight * 0.05, 
                ),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  elevation: 5,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Create an Account",
                          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        TextField(controller: _emailController, decoration: const InputDecoration(labelText: "Email")),
                        const SizedBox(height: 12),
                        TextField(controller: _usernameController, decoration: const InputDecoration(labelText: "Username")),
                        const SizedBox(height: 12),
                        TextField(controller: _firstNameController, decoration: const InputDecoration(labelText: "First Name")),
                        const SizedBox(height: 12),
                        TextField(controller: _lastNameController, decoration: const InputDecoration(labelText: "Last Name")),
                        const SizedBox(height: 12),
                        TextField(controller: _genderController, decoration: const InputDecoration(labelText: "Gender")),
                        const SizedBox(height: 12),
                        TextField(controller: _passwordController, decoration: const InputDecoration(labelText: "Password"), obscureText: true),
                        const SizedBox(height: 12),
                        TextField(controller: _confirmPasswordController, decoration: const InputDecoration(labelText: "Confirm Password"), obscureText: true),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: signUp,
                          child: const Text("Sign Up"),
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Already have an account? Log In"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
