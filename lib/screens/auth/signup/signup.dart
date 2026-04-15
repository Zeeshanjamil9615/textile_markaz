import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textile_markaz/app/theme/app_colors.dart';
import 'package:textile_markaz/screens/auth/signup/signup_controller.dart';

class SignupScreen extends StatelessWidget {
  static const routeName = '/signup';

  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(SignupController());
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
                          child: _PillLabel(
                            text: 'Register Your Account',
                            borderColor: primary.withValues(alpha: 0.28),
                            textColor: primary.withValues(alpha: 0.70),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          'Create Your Account',
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
                          'Fill the form below to register your account with us.',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    height: 1.35,
                                    color: primary.withValues(alpha: 0.70),
                                  ),
                        ),
                        const SizedBox(height: 22),
                        _UnderlineField(
                          label: 'First Name*',
                          controller: c.firstNameC,
                          textInputAction: TextInputAction.next,
                          validator: c.validateFirstName,
                        ),
                        const SizedBox(height: 18),
                        _UnderlineField(
                          label: 'Last Name*',
                          controller: c.lastNameC,
                          textInputAction: TextInputAction.next,
                          validator: c.validateLastName,
                        ),
                        const SizedBox(height: 18),
                        _UnderlineField(
                          label: 'Email Address*',
                          controller: c.emailC,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: c.validateEmail,
                        ),
                        const SizedBox(height: 18),
                        _UnderlineField(
                          label: 'Cell No*',
                          controller: c.phoneC,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          validator: c.validatePhone,
                        ),
                        const SizedBox(height: 18),
                        _UnderlineField(
                          label: 'Address*',
                          controller: c.addressC,
                          textInputAction: TextInputAction.next,
                          validator: c.validateAddress,
                        ),
                        const SizedBox(height: 18),
                        _UnderlineField(
                          label: 'City*',
                          controller: c.cityC,
                          textInputAction: TextInputAction.next,
                          validator: c.validateCity,
                        ),
                        const SizedBox(height: 18),
                        _UnderlineField(
                          label: 'Country*',
                          controller: c.countryC,
                          textInputAction: TextInputAction.done,
                          validator: c.validateCountry,
                          onSubmitted: (_) => c.register(),
                        ),
                        const SizedBox(height: 22),
                        Obx(
                          () => _PrimaryPillButton(
                            label: c.isLoading.value
                                ? 'Registering'
                                : 'Register Now',
                            onPressed: c.isLoading.value ? null : c.register,
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
                                'Already have an account? ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: primary.withValues(alpha: 0.70),
                                    ),
                              ),
                              TextButton(
                                onPressed: c.goToLogin,
                                style: TextButton.styleFrom(
                                  foregroundColor: primary,
                                ),
                                child: const Text('Login here'),
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
    this.validator,
    this.onSubmitted,
  });

  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    final primary = AppColors.primaryclr;
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
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

