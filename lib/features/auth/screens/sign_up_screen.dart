import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/routing/app_routes.dart';
import '../widgets/auth_background.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/outlined_text_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> _signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? "Sign up failed")));
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                controller: usernameController,
                hintText: "Enter Username",
                prefixIcon: Icons.person,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: emailController,
                hintText: "Enter Email",
                prefixIcon: Icons.email,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: passwordController,
                hintText: "Enter Password",
                prefixIcon: Icons.lock,
                obscureText: true,
                suffixIcon: Icons.visibility,
              ),
              const SizedBox(height: 20),
              PrimaryButton(text: "Sign up", onPressed: _signUp),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already Registered?",
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                  OutlinedTextButton(
                    text: "Sign in",
                    onPressed: () => Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.signIn,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
