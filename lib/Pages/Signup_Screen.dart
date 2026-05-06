import 'package:MoneyBee/Pages/Login_Screen.dart';
import 'package:MoneyBee/Services/AuthService.dart';
import 'package:MoneyBee/Services/GoHome.dart';
import 'package:MoneyBee/Services/SignUpWithGoogle.dart';
import 'package:MoneyBee/Services/validate.dart';
import 'package:MoneyBee/Widgets/CustomTextField_Widget.dart';
import 'package:MoneyBee/Widgets/Header.dart';
import 'package:MoneyBee/Widgets/SignByGoogle_Widget.dart';
import 'package:MoneyBee/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    final error = validateSignUp(
      username: _usernameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      confirmPassword: _confirmPasswordController.text,
    );

    if (error != null) {
      _showError(error);
      return;
    }

    setState(() => _isLoading = true);

    try {
      await AuthService().signUp(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
      );

      if (mounted) goHome(context);
    } on FirebaseAuthException catch (e) {
      _showError(e.message ?? 'Sign-up failed.');
    } catch (e) {
      _showError('Something went wrong.');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _handleGoogleSignUp() async {
    setState(() => _isLoading = true);

    try {
      await signUpWithGoogle();
      if (mounted) goHome(context);
    } on FirebaseAuthException catch (e) {
      _showError(e.message ?? 'Google sign-in failed.');
    } catch (e) {
      if (e.toString() != 'Exception: cancelled') {
        _showError('Google sign-in failed.');
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: GoogleFonts.poppins(fontSize: 13)),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 235, 252),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
            Header(label: "Log In", fun: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => Login()),
                )),
              const SizedBox(height: 10),
              Text(
                "Create an account",
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: PrimaryColor,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Start your journey toward mindful spending\nand financial clarity today.",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  children: [
                    CustomTextFiled_Widget(
                      focusNode: _emailFocus,
                      controller: _usernameController,
                      labelText: "Username",
                      icon: const Icon(Icons.person_outline),
                    ),
                    const SizedBox(height: 15),
                    CustomTextFiled_Widget(
                      focusNode: _passwordFocus,
                      controller: _emailController,
                      labelText: "Email",
                      icon: const Icon(Icons.email_outlined),
                    ),
                    const SizedBox(height: 15),
                    CustomTextFiled_Widget(
                      controller: _passwordController,
                      labelText: "Password",
                      icon: const Icon(Icons.lock_outline),
                      isPassword: true,
                    ),
                    const SizedBox(height: 15),
                    CustomTextFiled_Widget(
                      controller: _confirmPasswordController,
                      labelText: "Confirm Password",
                      icon: const Icon(Icons.lock_outline),
                      isPassword: true,
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _signUp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: PrimaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          textStyle: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : const Text("Create Account"),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Or Join With",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: PrimaryColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: SignbygoogleWidget(
                            text: _isLoading ? "Loading..." : "Sign Up with Google",
                            image: "assets/images/google.png",
                            onPressed: _isLoading ? null : () => _handleGoogleSignUp(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Text.rich(
                TextSpan(
                  text: "By creating an account, you agree to our\n",
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: PrimaryColor,
                  ),
                  children: [
                    TextSpan(
                      text: "Terms of Service",
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: PrimaryColor,
                      ),
                    ),
                    const TextSpan(text: " and "),
                    TextSpan(
                      text: "Privacy Policy",
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: PrimaryColor,
                      ),
                    ),
                    const TextSpan(text: "."),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}