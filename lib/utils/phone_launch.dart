import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

String digitsOnly(String input) => input.replaceAll(RegExp(r'[^0-9]'), '');

Future<void> launchCall(BuildContext context, String phone) async {
  final digits = digitsOnly(phone);
  if (digits.isEmpty) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Phone not available')));
    return;
  }
  final uri = Uri(scheme: 'tel', path: digits);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    if (context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Could not open dialer')));
    }
  }
}

Future<void> launchWhatsApp(BuildContext context, String phone) async {
  final digits = digitsOnly(phone);
  if (digits.isEmpty) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Phone not available')));
    return;
  }

  final uri = Uri.parse('https://wa.me/$digits');
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open WhatsApp')),
      );
    }
  }
}
