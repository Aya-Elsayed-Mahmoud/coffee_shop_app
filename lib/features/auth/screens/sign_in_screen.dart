import 'package:flutter/material.dart';
import '../../../../core/routing/app_routes.dart';
import '../data/firebase_auth_service.dart';
import '../widgets/auth_background.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/outlined_text_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthService authService = AuthService();

  Future<void> _signIn() async {
    try {
      await authService.signInWithEmail(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      final user = await authService.signInWithGoogle();
      if (user != null)
        Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> _signInWithFacebook() async {
    try {
      final user = await authService.signInWithFacebook();
      if (user != null)
        Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
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
              PrimaryButton(text: "Sign in", onPressed: _signIn),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Image.asset("assets/icons/google.png"),
                    // أضيفي أيقونة جوجل
                    iconSize: 40,
                    onPressed: _signInWithGoogle,
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    icon: Image.asset("assets/icons/facebook.png"),
                    // أضيفي أيقونة فيسبوك
                    iconSize: 40,
                    onPressed: _signInWithFacebook,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                  OutlinedTextButton(
                    text: "Sign up",
                    onPressed: () => Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.signUp,
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
