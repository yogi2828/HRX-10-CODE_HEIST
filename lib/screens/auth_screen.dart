// lib/screens/auth_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/services/firebase_service.dart';
import 'package:gamifier/utils/app_router.dart';
import 'package:gamifier/widgets/common/loading_indicator.dart';
import 'package:gamifier/utils/validation_utils.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  bool _isLogin = true;
  bool _isLoading = false;

  void _submitAuthForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String username = _usernameController.text.trim();

    final firebaseService = Provider.of<FirebaseService>(context, listen: false);

    try {
      if (_isLogin) {
        // Log in user
        final userCredential = await firebaseService.signIn(email, password);
        if (userCredential != null) {
          Navigator.of(context).pushReplacementNamed(AppRouter.homeRoute);
        } else {
          _showErrorSnackbar('Login failed. Please check your credentials.');
        }
      } else {
        // Sign up user
        final userCredential = await firebaseService.signUp(email, password);
        if (userCredential != null && userCredential.user != null) {
          await firebaseService.createUserProfile(userCredential.user!.uid, username);
          Navigator.of(context).pushReplacementNamed(AppRouter.onboardingRoute);
        } else {
          _showErrorSnackbar('Sign up failed. Please try again.');
        }
      }
    } catch (e) {
      _showErrorSnackbar('An error occurred: ${e.toString()}');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.errorColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.backgroundGradient()),
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.padding * 2),
            child: Card(
              color: AppColors.cardColor.withOpacity(0.9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.borderRadius * 2),
              ),
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.padding * 2),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _isLogin ? 'Welcome Back!' : 'Join Gamifier!',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: AppColors.textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppConstants.padding),
                      if (!_isLogin)
                        TextFormField(
                          controller: _usernameController,
                          key: const ValueKey('username'),
                          decoration: const InputDecoration(
                            labelText: 'Username',
                            prefixIcon: Icon(Icons.person, color: AppColors.accentColor),
                          ),
                          validator: (value) => ValidationUtils.validateUsername(value),
                          textCapitalization: TextCapitalization.words,
                          autocorrect: false,
                        ),
                      if (!_isLogin) const SizedBox(height: AppConstants.padding),
                      TextFormField(
                        controller: _emailController,
                        key: const ValueKey('email'),
                        decoration: const InputDecoration(
                          labelText: 'Email Address',
                          prefixIcon: Icon(Icons.email, color: AppColors.accentColor),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) => ValidationUtils.validateEmail(value),
                        textCapitalization: TextCapitalization.none,
                        autocorrect: false,
                      ),
                      const SizedBox(height: AppConstants.padding),
                      TextFormField(
                        controller: _passwordController,
                        key: const ValueKey('password'),
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock, color: AppColors.accentColor),
                        ),
                        obscureText: true,
                        validator: (value) => ValidationUtils.validatePassword(value),
                      ),
                      const SizedBox(height: AppConstants.padding * 1.5),
                      _isLoading
                          ? const LoadingIndicator()
                          : ElevatedButton(
                              onPressed: _submitAuthForm,
                              child: Text(_isLogin ? 'Login' : 'Sign Up'),
                            ),
                      const SizedBox(height: AppConstants.padding),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: Text(
                          _isLogin
                              ? 'Create New Account'
                              : 'I already have an account',
                          style: const TextStyle(color: AppColors.textColorSecondary),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }
}
