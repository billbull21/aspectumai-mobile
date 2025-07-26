import 'package:flutter/material.dart';
import 'package:aspectumai/core/app_route.dart';
import 'package:aspectumai/core/resources/colors.dart';
import 'package:aspectumai/core/resources/images.dart';
import 'package:aspectumai/core/utils/extensions/context_ext.dart';
import 'package:aspectumai/core/widgets/app_button.dart';
import 'package:aspectumai/core/widgets/app_spacer.dart';
import 'package:aspectumai/core/widgets/app_text_form.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ForgotPasswordScreenBody();
  }
}

class _ForgotPasswordScreenBody extends StatefulWidget {
  const _ForgotPasswordScreenBody();

  @override
  State<_ForgotPasswordScreenBody> createState() => _ForgotPasswordScreenBodyState();
}

class _ForgotPasswordScreenBodyState extends State<_ForgotPasswordScreenBody> {
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void _sendResetLink() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: Implement forgot password API call
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset link sent to your email'),
          backgroundColor: AppColors.blue,
        ),
      );
      
      // Navigate to OTP screen for verification
      context.push(rOtp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// header
            SizedBox(
              height: 219,
              width: context.screenWidth,
              child: Stack(
                children: [
                  Container(
                    width: context.screenWidth,
                    height: double.infinity,
                    color: AppColors.primary,
                  ),
                  Image.asset(
                    ImageConstants.authBg,
                    width: context.screenWidth,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),

                  /// content
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 24,
                        right: 40,
                        bottom: 40,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              context.pop();
                            },
                            child: const Icon(
                              Icons.arrow_back_sharp,
                              color: AppColors.white,
                            ),
                          ),
                          const AppSpacer.height(24),
                          const Text(
                            'Forgot Password',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                              color: AppColors.white,
                            ),
                          ),
                          const AppSpacer.height(12),
                          GestureDetector(
                            onTap: () {
                              context.push(rLogin);
                            },
                            child: const Text.rich(
                              TextSpan(
                                text: "Remember your password?",
                                children: [
                                  TextSpan(
                                    text: ' Sign in',
                                    style: TextStyle(
                                      color: AppColors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// main content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppSpacer.height(16),
                    
                    /// Description
                    const Text(
                      'Enter your email address and we\'ll send you a link to reset your password.',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.darkGrey,
                        height: 1.4,
                      ),
                    ),
                    
                    const AppSpacer.height(32),
                    
                    /// Email Input
                    AppTextForm(
                      label: 'Email',
                      hint: 'Enter your email address',
                      type: AppTextFormType.outlined,
                      backgroundColor: AppColors.white,
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),

                    const AppSpacer.height(32),

                    /// Send Reset Link Button
                    AppButton(
                      text: 'Send Reset Link',
                      onPressed: _sendResetLink,
                      width: context.screenWidth,
                    ),

                    const AppSpacer.height(24),

                    /// Additional Info
                    Center(
                      child: Column(
                        children: [
                          const Text(
                            'Didn\'t receive the email?',
                            style: TextStyle(
                              color: AppColors.darkGrey,
                              fontSize: 12,
                            ),
                          ),
                          const AppSpacer.height(8),
                          GestureDetector(
                            onTap: () {
                              // Check spam folder info
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please check your spam/junk folder'),
                                  backgroundColor: AppColors.primary,
                                ),
                              );
                            },
                            child: const Text(
                              'Check spam folder',
                              style: TextStyle(
                                color: AppColors.blue,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const AppSpacer.height(32),

                    /// Back to Login
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          context.push(rLogin);
                        },
                        child: const Text.rich(
                          TextSpan(
                            text: 'Back to ',
                            children: [
                              TextSpan(
                                text: 'Sign in',
                                style: TextStyle(
                                  color: AppColors.blue,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          style: TextStyle(
                            color: AppColors.darkGrey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
