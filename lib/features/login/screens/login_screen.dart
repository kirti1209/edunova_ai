import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../widgets/login_button.dart';
import '../services/auth_service.dart';
import '../../Dashboard/screens/dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  Future<void> _handleGoogleLogin() async {
    setState(() => _isLoading = true);
    try {
      final userCredential = await _authService.signInWithGoogle();
      if (userCredential != null && mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const DashboardScreen(),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Google login failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _handleMicrosoftLogin() async {
    setState(() => _isLoading = true);
    try {
      final userCredential = await _authService.signInWithMicrosoft();
      if (userCredential != null && mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const DashboardScreen(),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Microsoft login failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _handleAppleLogin() async {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Apple sign-in is disabled, please try another method.'),
        backgroundColor: Colors.red,
      ),
    );
  }

  Future<void> _handleOneTapLogin() async {
    setState(() => _isLoading = true);
    try {
      final userCredential = await _authService.signInWithOneTap();
      if (userCredential != null && mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const DashboardScreen(),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('One Tap login failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.dark, AppColors.primary],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: _isLoading
                ? const CircularProgressIndicator(
                    color: AppColors.white,
                  )
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Logo/Icon
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.school,
                            size: 60,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 40),
                        
                        // Welcome Text
                        const Text(
                          AppStrings.welcome,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          AppStrings.loginSubtitle,
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 48),
                        
                        // Login Buttons
                        LoginButton(
                          text: AppStrings.googleLogin,
                          icon: Icons.g_mobiledata,
                          backgroundColor: AppColors.white,
                          textColor: AppColors.dark,
                          onPressed: _isLoading ? () {} : () => _handleGoogleLogin(),
                        ),
                        const SizedBox(height: 16),
                        
                        LoginButton(
                          text: AppStrings.microsoftLogin,
                          icon: Icons.window,
                          backgroundColor: AppColors.white,
                          textColor: AppColors.dark,
                          onPressed: _isLoading ? () {} : () => _handleMicrosoftLogin(),
                        ),
                        const SizedBox(height: 16),
                        
                        LoginButton(
                          text: AppStrings.appleLogin,
                          icon: Icons.apple,
                          backgroundColor: AppColors.dark,
                          textColor: AppColors.white,
                          onPressed: _isLoading ? () {} : () => _handleAppleLogin(),
                        ),
                        const SizedBox(height: 16),
                        
                        LoginButton(
                          text: AppStrings.oneTapLogin,
                          icon: Icons.touch_app,
                          backgroundColor: AppColors.primary,
                          textColor: AppColors.white,
                          onPressed: _isLoading ? () {} : () => _handleOneTapLogin(),
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
