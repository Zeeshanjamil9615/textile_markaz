import 'dart:io';

import 'package:flutter/material.dart';
import 'package:textile_markaz/data/dummy/dummy_data.dart';
import 'package:textile_markaz/data/models/textile_ad.dart';
import 'package:textile_markaz/utils/phone_launch.dart';
import 'package:textile_markaz/widgets/round_action_button.dart';

class ResultsScreen extends StatelessWidget {
  static const routeName = '/results';

  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final items = (args is List<TextileAd>) ? args : dummyAds;

    return Scaffold(
      appBar: AppBar(title: const Text('Results')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, i) {
          final ad = items[i];
          return Padding(
            padding: EdgeInsets.only(bottom: i < items.length - 1 ? 12 : 0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Stack(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: ad.imagePaths.isNotEmpty
                              ? Image.file(
                                  File(ad.imagePaths.first),
                                  height: 72,
                                  width: 72,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  height: 72,
                                  width: 72,
                                  alignment: Alignment.center,
                                  color: Colors.orange.shade100,
                                  child: const Text(
                                    'LOT',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 84),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '| ${ad.title}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'City: ${ad.city}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                if (ad.price != null) ...[
                                  const SizedBox(height: 2),
                                  Text(
                                    'Price: ${ad.price}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ],
                                const SizedBox(height: 2),
                                Text(
                                  'Expiry date: ${ad.expiryDate.day.toString().padLeft(2, '0')}/${ad.expiryDate.month.toString().padLeft(2, '0')}/${ad.expiryDate.year}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Product description: ${ad.description}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  ad.contactPhone,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Row(
                        children: [
                          RoundActionButton(
                            bg: const Color(0xFF25D366),
                            icon: Icons.chat,
                            onTap: () =>
                                launchWhatsApp(context, ad.contactPhone),
                          ),
                          const SizedBox(width: 10),
                          RoundActionButton(
                            bg: const Color(0xFF112037),
                            icon: Icons.call,
                            onTap: () => launchCall(context, ad.contactPhone),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
