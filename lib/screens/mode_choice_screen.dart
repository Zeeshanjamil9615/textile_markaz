import 'package:flutter/material.dart';
import 'package:textile_markaz/screens/category_grid_screen.dart';
import 'package:textile_markaz/widgets/mode_card.dart';

class ModeChoiceScreen extends StatelessWidget {
  static const routeName = '/mode';

  const ModeChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16),
          ModeCard(
            color: const Color(0xFFBB1943),
            icon: Icons.shopping_cart_outlined,
            text: 'You want to Buy textile item?',
            onTap: () {
              Navigator.of(context).pushNamed(
                CategoryGridScreen.routeName,
                arguments: 'buy',
              );
            },
          ),
          const SizedBox(height: 16),
          ModeCard(
            color: const Color(0xFF112037),
            icon: Icons.credit_card_outlined,
            text: 'You want to sell textile item?',
            onTap: () {
              Navigator.of(context).pushNamed(
                CategoryGridScreen.routeName,
                arguments: 'sell',
              );
            },
          ),
        ],
      ),
    );
  }
}
