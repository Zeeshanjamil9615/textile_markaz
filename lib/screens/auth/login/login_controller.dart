import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textile_markaz/screens/auth/signup/signup.dart';
import 'package:textile_markaz/screens/home_search_screen.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final emailC = TextEditingController();
  final passwordC = TextEditingController();

  final obscurePassword = true.obs;
  final isLoading = false.obs;

  String? validateEmail(String? v) {
    final value = (v ?? '').trim();
    if (value.isEmpty) return 'Email is required';
    if (!GetUtils.isEmail(value)) return 'Enter a valid email';
    return null;
  }

  String? validatePassword(String? v) {
    final value = (v ?? '').trim();
    if (value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  Future<void> login() async {
    final ok = formKey.currentState?.validate() ?? false;
    if (!ok) return;

    isLoading.value = true;
    try {
      await Future<void>.delayed(const Duration(milliseconds: 700));
      Get.snackbar(
        'Success',
        'Logged in (demo)',
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.offAllNamed(HomeSearchScreen.routeName);
    } finally {
      isLoading.value = false;
    }
  }

  void goToSignup() {
    Get.toNamed(SignupScreen.routeName);
  }

  @override
  void onClose() {
    emailC.dispose();
    passwordC.dispose();
    super.onClose();
  }
}

