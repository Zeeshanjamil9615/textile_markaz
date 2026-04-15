import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textile_markaz/api_service/api_service.dart';
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
      final map = await ApiService.instance.loginRequest(
        email: emailC.text.trim(),
        password: passwordC.text.trim(),
      );
      final res = LoginResponse.fromJson(map);

      if (res.status == 200) {
        Get.snackbar(
          'Success',
          res.message.isNotEmpty ? res.message : 'Login successful',
          snackPosition: SnackPosition.TOP,
        );
        Get.offAllNamed(HomeSearchScreen.routeName);
        return;
      }

      Get.snackbar(
        'Error',
        res.message.isNotEmpty ? res.message : 'Login failed',
        snackPosition: SnackPosition.TOP,
      );
    } on ApiException catch (e) {
      Get.snackbar(
        'Error',
        e.message,
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.TOP,
      );
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

class LoginResponse {
  LoginResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  final int status;
  final String message;
  final LoginUser? data;

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: (json['status'] as num?)?.toInt() ?? 0,
      message: json['message']?.toString() ?? '',
      data: json['data'] is Map<String, dynamic>
          ? LoginUser.fromJson((json['data'] as Map).cast<String, dynamic>())
          : null,
    );
  }
}

class LoginUser {
  LoginUser({
    required this.csId,
    required this.name,
    required this.email,
    required this.mobile,
    required this.city,
    required this.country,
  });

  final String csId;
  final String name;
  final String email;
  final String mobile;
  final String city;
  final String country;

  factory LoginUser.fromJson(Map<String, dynamic> json) {
    return LoginUser(
      csId: json['cs_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      mobile: json['mobile']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      country: json['country']?.toString() ?? '',
    );
  }
}

