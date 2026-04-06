import 'package:flutter/material.dart';

class RoundActionButton extends StatelessWidget {
  const RoundActionButton({
    super.key,
    required this.bg,
    required this.icon,
    required this.onTap,
  });

  final Color bg;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: bg,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          height: 44,
          width: 44,
          child: Center(child: Icon(icon, color: Colors.white)),
        ),
      ),
    );
  }
}
