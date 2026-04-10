import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textile_markaz/screens/auth/login/login_controller.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(LoginController());
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
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 560),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(22, 22, 22, 18),
                        child: Form(
                          key: c.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _PillLabel(
                                text: 'Login to Your Account',
                                borderColor: scheme.outline,
                                textColor:
                                    scheme.onSurface.withValues(alpha: 0.7),
                              ),
                              const SizedBox(height: 14),
                              Text(
                                'Welcome Back!',
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
                                'Enter your credentials to access your account.',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: scheme.onSurfaceVariant,
                                    ),
                              ),
                              const SizedBox(height: 18),
                              TextFormField(
                                controller: c.emailC,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  hintText: 'Email Address*',
                                ),
                                validator: c.validateEmail,
                              ),
                              const SizedBox(height: 12),
                              Obx(
                                () => TextFormField(
                                  controller: c.passwordC,
                                  textInputAction: TextInputAction.done,
                                  obscureText: c.obscurePassword.value,
                                  decoration: InputDecoration(
                                    hintText: 'Password*',
                                    suffixIcon: IconButton(
                                      onPressed: () =>
                                          c.obscurePassword.value =
                                              !c.obscurePassword.value,
                                      icon: Icon(
                                        c.obscurePassword.value
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                      ),
                                    ),
                                  ),
                                  validator: c.validatePassword,
                                  onFieldSubmitted: (_) => c.login(),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Obx(
                                () => _PrimaryPillButton(
                                  label: c.isLoading.value
                                      ? 'Signing in...'
                                      : 'Sign in',
                                  onPressed:
                                      c.isLoading.value ? null : c.login,
                                  icon: Icons.arrow_forward,
                                  background: scheme.primary,
                                ),
                              ),
                              const SizedBox(height: 14),
                              Align(
                                alignment: Alignment.center,
                                child: Wrap(
                                  crossAxisAlignment:
                                      WrapCrossAlignment.center,
                                  children: [
                                    Text(
                                      "Don't have an account? ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: scheme.onSurfaceVariant,
                                          ),
                                    ),
                                    TextButton(
                                      onPressed: c.goToSignup,
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
              );
            },
          ),
        ),
      ),
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

