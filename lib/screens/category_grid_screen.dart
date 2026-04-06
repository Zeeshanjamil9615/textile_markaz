import 'package:flutter/material.dart';
import 'package:textile_markaz/data/dummy/dummy_data.dart';
import 'package:textile_markaz/screens/post_ad_screen.dart';

class CategoryGridScreen extends StatelessWidget {
  static const routeName = '/categories';

  const CategoryGridScreen({super.key});

  IconData _iconFor(String category) {
    switch (category) {
      case 'Yarn':
        return Icons.linear_scale;
      case 'Fabric':
        return Icons.check_box_outline_blank;
      case 'Stocks Lots':
        return Icons.inventory_2_outlined;
      case 'Cotton':
        return Icons.spa_outlined;
      case 'Fiber':
        return Icons.blur_on_outlined;
      case 'Looms Conversion':
        return Icons.sync_alt;
      case 'Textile Machinery':
        return Icons.precision_manufacturing_outlined;
      case 'Spare Parts':
        return Icons.settings_outlined;
      case 'General Textile Items':
        return Icons.category_outlined;
      default:
        return Icons.category_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mode =
        (ModalRoute.of(context)?.settings.arguments as String?) ?? 'buy';
    final isBuy = mode == 'buy';

    return Scaffold(
      appBar: AppBar(
        title: Text(isBuy ? 'Choose category (Buy)' : 'Choose category (Sell)'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              isBuy
                  ? 'Choose a category that best describes what you\'re listing. This helps buyers find your ad faster.'
                  : 'Choose a category that best describes what you\'re listing. This helps sellers find your ad faster.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.4,
              ),
              itemCount: categories.length,
              itemBuilder: (context, i) {
                final cat = categories[i];
                final icon = _iconFor(cat);
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      PostAdScreen.routeName,
                      arguments: {
                        'mode': mode,
                        'category': cat,
                      },
                    );
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 44,
                            width: 44,
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.08),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              icon,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 10),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              cat,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
