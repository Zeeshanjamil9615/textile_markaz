import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textile_markaz/api_service/api_service.dart';
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
      final map = await ApiService.instance.registerRequest(
        firstName: firstNameC.text.trim(),
        lastName: lastNameC.text.trim(),
        email: emailC.text.trim(),
        cell: phoneC.text.trim(),
        address: addressC.text.trim(),
        city: cityC.text.trim(),
        country: countryC.text.trim(),
      );
      final res = SignupResponse.fromJson(map);

      if (res.status == 200) {
        Get.snackbar(
          'Success',
          res.message.isNotEmpty ? res.message : 'Registered successfully',
          snackPosition: SnackPosition.TOP,
        );
        Get.offNamed(LoginScreen.routeName);
        return;
      }

      Get.snackbar(
        'Error',
        res.message.isNotEmpty ? res.message : 'Registration failed',
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

class SignupResponse {
  SignupResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  final int status;
  final String message;
  final SignupUser? data;

  factory SignupResponse.fromJson(Map<String, dynamic> json) {
    return SignupResponse(
      status: (json['status'] as num?)?.toInt() ?? 0,
      message: json['message']?.toString() ?? '',
      data: json['data'] is Map<String, dynamic>
          ? SignupUser.fromJson((json['data'] as Map).cast<String, dynamic>())
          : null,
    );
  }
}

class SignupUser {
  SignupUser({
    required this.userId,
    required this.name,
    required this.email,
  });

  final int userId;
  final String name;
  final String email;

  factory SignupUser.fromJson(Map<String, dynamic> json) {
    return SignupUser(
      userId: (json['user_id'] as num?)?.toInt() ?? 0,
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
    );
  }
}

