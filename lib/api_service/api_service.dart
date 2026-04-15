import 'dart:convert';

import 'package:dio/dio.dart';

class ApiService {
  ApiService._()
      : _dio = Dio(
          BaseOptions(
            baseUrl: 'https://textilemarkaz.pk/api',
            connectTimeout: const Duration(seconds: 20),
            receiveTimeout: const Duration(seconds: 20),
            sendTimeout: const Duration(seconds: 20),
          ),
        );

  static final ApiService instance = ApiService._();

  final Dio _dio;

  Future<Map<String, dynamic>> loginRequest({
    required String email,
    required String password,
  }) async {
    try {
      final data = FormData.fromMap({
        'email': email,
        'password': password,
      });

      final response = await _dio.request(
        '/loginRequest',
        options: Options(method: 'POST'),
        data: data,
      );

      return _ensureMap(response.data);
    } on DioException catch (e) {
      throw ApiException(_dioMessage(e));
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  Future<Map<String, dynamic>> registerRequest({
    required String firstName,
    required String lastName,
    required String email,
    required String cell,
    required String address,
    required String city,
    required String country,
  }) async {
    try {
      final data = FormData.fromMap({
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'cell': cell,
        'address': address,
        'city': city,
        'country': country,
      });

      final response = await _dio.request(
        '/registerRequest',
        options: Options(method: 'POST'),
        data: data,
      );

      return _ensureMap(response.data);
    } on DioException catch (e) {
      throw ApiException(_dioMessage(e));
    } catch (e) {
      throw ApiException(e.toString());
    }
  }
}

class ApiException implements Exception {
  ApiException(this.message);
  final String message;

  @override
  String toString() => message;
}

Map<String, dynamic> _ensureMap(Object? data) {
  if (data is Map<String, dynamic>) return data;
  if (data is String) return (jsonDecode(data) as Map).cast<String, dynamic>();
  return (jsonDecode(jsonEncode(data)) as Map).cast<String, dynamic>();
}

String _dioMessage(DioException e) {
  // Prefer backend-provided message if present.
  final data = e.response?.data;
  try {
    final map = _ensureMap(data);
    final msg = map['message']?.toString();
    if (msg != null && msg.trim().isNotEmpty) return msg;
  } catch (_) {}

  if (e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.sendTimeout ||
      e.type == DioExceptionType.receiveTimeout) {
    return 'Request timeout. Please try again.';
  }
  if (e.type == DioExceptionType.connectionError) {
    return 'No internet connection. Please check your network.';
  }
  return e.message ?? 'Something went wrong. Please try again.';
}
