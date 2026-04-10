import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textile_markaz/screens/auth/login/login.dart';

class SignupController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final firstNameC = TextEditingController();
  final lastNameC = TextEditingController();
  final emailC = TextEditingController();
  final phoneC = TextEditingController();
  final addressC = TextEditingController();
  final cityC = TextEditingController();
  final countryC = TextEditingController();

  final isLoading = false.obs;

  String? _required(String label, String? v) {
    if ((v ?? '').trim().isEmpty) return '$label is required';
    return null;
  }

  String? validateEmail(String? v) {
    final value = (v ?? '').trim();
    if (value.isEmpty) return 'Email is required';
    if (!GetUtils.isEmail(value)) return 'Enter a valid email';
    return null;
  }

  String? validatePhone(String? v) {
    final value = (v ?? '').trim();
    if (value.isEmpty) return 'Cell No is required';
    if (value.length < 8) return 'Enter a valid phone number';
    return null;
  }

  Future<void> register() async {
    final ok = formKey.currentState?.validate() ?? false;
    if (!ok) return;

    isLoading.value = true;
    try {
      await Future<void>.delayed(const Duration(milliseconds: 700));
      Get.snackbar(
        'Success',
        'Account created (demo)',
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.offNamed(LoginScreen.routeName);
    } finally {
      isLoading.value = false;
    }
  }

  void goToLogin() {
    Get.offNamed(LoginScreen.routeName);
  }

  @override
  void onClose() {
    firstNameC.dispose();
    lastNameC.dispose();
    emailC.dispose();
    phoneC.dispose();
    addressC.dispose();
    cityC.dispose();
    countryC.dispose();
    super.onClose();
  }

  String? validateFirstName(String? v) => _required('First Name', v);
  String? validateLastName(String? v) => _required('Last Name', v);
  String? validateAddress(String? v) => _required('Address', v);
  String? validateCity(String? v) => _required('City', v);
  String? validateCountry(String? v) => _required('Country', v);
}

