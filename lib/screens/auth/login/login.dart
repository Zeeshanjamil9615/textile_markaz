import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textile_markaz/app/theme/app_colors.dart';
import 'package:textile_markaz/screens/auth/login/login_controller.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(LoginController());
    final primary = AppColors.primaryclr;

    return Scaffold(
      backgroundColor: primary,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.primaryclr, AppColors.primaryclr],
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(18),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: _AuthCard(
                  child: Form(
                    key: c.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 6),
                        Center(
                          child: Image.asset(
                            'assets/images/app_icon.png',
                            height: 54,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Center(
                          child: _PillLabel(
                            text: 'Login to Your Account',
                            borderColor: primary.withValues(alpha: 0.28),
                            textColor: primary.withValues(alpha: 0.70),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          'Welcome Back!',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w900,
                                letterSpacing: -0.4,
                                color: primary,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Enter your credentials to access your account.',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    height: 1.35,
                                    color: primary.withValues(alpha: 0.70),
                                  ),
                        ),
                        const SizedBox(height: 22),
                        _UnderlineField(
                          label: 'Email Address*',
                          controller: c.emailC,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: c.validateEmail,
                        ),
                        const SizedBox(height: 18),
                        Obx(
                          () => _UnderlineField(
                            label: 'Password*',
                            controller: c.passwordC,
                            textInputAction: TextInputAction.done,
                            obscureText: c.obscurePassword.value,
                            validator: c.validatePassword,
                            suffix: IconButton(
                              onPressed: () => c.obscurePassword.value =
                                  !c.obscurePassword.value,
                              icon: Icon(
                                c.obscurePassword.value
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: primary.withValues(alpha: 0.70),
                              ),
                            ),
                            onSubmitted: (_) => c.login(),
                          ),
                        ),
                        const SizedBox(height: 22),
                        Obx(
                          () => _PrimaryPillButton(
                            label: c.isLoading.value ? 'Signing in' : 'Sign in',
                            onPressed: c.isLoading.value ? null : c.login,
                            icon: Icons.arrow_forward,
                            background: primary,
                          ),
                        ),
                        const SizedBox(height: 18),
                        Align(
                          alignment: Alignment.center,
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: primary.withValues(alpha: 0.70),
                                    ),
                              ),
                              TextButton(
                                onPressed: c.goToSignup,
                                style: TextButton.styleFrom(
                                  foregroundColor: primary,
                                ),
                                child: const Text('Register here'),
                              ),
                            ],
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
      ),
    );
  }
}

class _AuthCard extends StatelessWidget {
  const _AuthCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final primary = AppColors.primaryclr;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: primary.withValues(alpha: 0.22),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(24, 22, 24, 20),
      child: child,
    );
  }
}

class _PillLabel extends StatelessWidget {
  const _PillLabel({
    required this.text,
    required this.borderColor,
    required this.textColor,
  });

  final String text;
  final Color borderColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: borderColor),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _UnderlineField extends StatelessWidget {
  const _UnderlineField({
    required this.label,
    required this.controller,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.validator,
    this.suffix,
    this.onSubmitted,
  });

  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Widget? suffix;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    final primary = AppColors.primaryclr;
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      validator: validator,
      onFieldSubmitted: onSubmitted,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: primary,
            fontWeight: FontWeight.w500,
          ),
      decoration: InputDecoration(
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: primary.withValues(alpha: 0.70),
              fontWeight: FontWeight.w500,
            ),
        isDense: true,
        contentPadding: const EdgeInsets.only(top: 6, bottom: 10),
        enabledBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: primary.withValues(alpha: 0.28), width: 1),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: primary, width: 2),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent, width: 1.5),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent, width: 2),
        ),
        suffixIcon: suffix,
      ),
    );
  }
}

class _PrimaryPillButton extends StatelessWidget {
  const _PrimaryPillButton({
    required this.label,
    required this.onPressed,
    required this.icon,
    required this.background,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData icon;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: background,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        shape: const StadiumBorder(),
      ),
      icon: const SizedBox.shrink(),
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(width: 10),
          Icon(icon, size: 18),
        ],
      ),
    );
  }
}

