// lib/screens/auth_screen.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/services/firebase_service.dart';
import 'package:gamifier/utils/app_router.dart';
import 'package:gamifier/utils/validation_utils.dart';
import 'package:gamifier/widgets/common/custom_button.dart';
import 'package:gamifier/widgets/common/custom_text_field.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  bool _isLogin = true;
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _submitAuthForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final firebaseService = Provider.of<FirebaseService>(context, listen: false);
      if (_isLogin) {
        await firebaseService.signInWithEmailAndPassword(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
      } else {
        await firebaseService.registerWithEmailAndPassword(
          _emailController.text.trim(),
          _passwordController.text.trim(),
          _usernameController.text.trim(),
        );
      }
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(AppRouter.homeRoute);
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'An unexpected error occurred: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.backgroundGradient(),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.padding * 2),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _isLogin ? 'Welcome Back!' : 'Join Gamifier!',
                    style: AppColors.neonTextStyle(fontSize: 32),
                  ),
                  const SizedBox(height: AppConstants.spacing * 4),
                  if (!_isLogin)
                    CustomTextField(
                      controller: _usernameController,
                      labelText: 'Username',
                      icon: Icons.person,
                      validator: ValidationUtils.validateUsername,
                      keyboardType: TextInputType.text,
                    ),
                  const SizedBox(height: AppConstants.spacing * 2),
                  CustomTextField(
                    controller: _emailController,
                    labelText: 'Email',
                    icon: Icons.email,
                    validator: ValidationUtils.validateEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: AppConstants.spacing * 2),
                  CustomTextField(
                    controller: _passwordController,
                    labelText: 'Password',
                    icon: Icons.lock,
                    validator: ValidationUtils.validatePassword,
                    obscureText: true,
                  ),
                  const SizedBox(height: AppConstants.spacing * 4),
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppConstants.spacing * 2),
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(color: AppColors.errorColor, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  _isLoading
                      ? const CircularProgressIndicator(color: AppColors.accentColor)
                      : CustomButton(
                          onPressed: _submitAuthForm,
                          text: _isLogin ? 'Login' : 'Register',
                          icon: _isLogin ? Icons.login : Icons.app_registration,
                        ),
                  const SizedBox(height: AppConstants.spacing * 2),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                        _errorMessage = null;
                      });
                    },
                    child: Text(
                      _isLogin
                          ? 'Don\'t have an account? Register'
                          : 'Already have an account? Login',
                      style: const TextStyle(color: AppColors.textColorSecondary, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}