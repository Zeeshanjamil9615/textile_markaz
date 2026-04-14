import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textile_markaz/screens/auth/signup/signup_controller.dart';

class SignupScreen extends StatelessWidget {
  static const routeName = '/signup';

  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(SignupController());
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(






      
      backgroundColor: scheme.primary,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [scheme.primary, const Color(0xFF0B1A2B)],
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 680),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(22, 22, 22, 18),
                    child: Form(
                      key: c.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _PillLabel(
                            text: 'Register Your Account',
                            borderColor: scheme.outline,
                            textColor:
                                scheme.onSurface.withValues(alpha: 0.7),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            'Create Your Account',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: scheme.onSurface,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Fill the form below to register your account with us.',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: scheme.onSurfaceVariant),
                          ),
                          const SizedBox(height: 18),
                          _TwoColRow(
                            left: TextFormField(
                              controller: c.firstNameC,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                hintText: 'First Name*',
                              ),
                              validator: c.validateFirstName,
                            ),
                            right: TextFormField(
                              controller: c.lastNameC,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                hintText: 'Last Name*',
                              ),
                              validator: c.validateLastName,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _TwoColRow(
                            left: TextFormField(
                              controller: c.emailC,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                hintText: 'Email Address*',
                              ),
                              validator: c.validateEmail,
                            ),
                            right: TextFormField(
                              controller: c.phoneC,
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.next,
                              decoration:
                                  const InputDecoration(hintText: 'Cell No*'),
                              validator: c.validatePhone,
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: c.addressC,
                            textInputAction: TextInputAction.next,
                            decoration:
                                const InputDecoration(hintText: 'Address*'),
                            validator: c.validateAddress,
                          ),
                          const SizedBox(height: 12),
                          _TwoColRow(
                            left: TextFormField(
                              controller: c.cityC,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(hintText: 'City*'),
                              validator: c.validateCity,
                            ),
                            right: TextFormField(
                              controller: c.countryC,
                              textInputAction: TextInputAction.done,
                              decoration:
                                  const InputDecoration(hintText: 'Country*'),
                              validator: c.validateCountry,
                              onFieldSubmitted: (_) => c.register(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Obx(
                            () => _PrimaryPillButton(
                              label: c.isLoading.value
                                  ? 'Registering...'
                                  : 'Register Now',
                              onPressed: c.isLoading.value ? null : c.register,
                              icon: Icons.arrow_forward,
                              background: scheme.primary,
                            ),
                          ),
                          const SizedBox(height: 14),
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
                                        color: scheme.onSurfaceVariant,
                                      ),
                                ),
                                TextButton(
                                  onPressed: c.goToLogin,
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
      ),
    );
  }
}

class _TwoColRow extends StatelessWidget {
  const _TwoColRow({required this.left, required this.right});

  final Widget left;
  final Widget right;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 520;
        if (isNarrow) {
          return Column(
            children: [
              left,
              const SizedBox(height: 12),
              right,
            ],
          );
        }
        return Row(
          children: [
            Expanded(child: left),
            const SizedBox(width: 12),
            Expanded(child: right),
          ],
        );
      },
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
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
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

