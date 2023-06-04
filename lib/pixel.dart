import 'package:flutter/material.dart';

class Pixel extends StatelessWidget {
  final int child;
  final Color? color;
  const Pixel({
    super.key,
    this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: color ?? Colors.grey[900],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          child.toString(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
