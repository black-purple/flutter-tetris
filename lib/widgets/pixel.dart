import 'package:flutter/material.dart';

class Pixel extends StatelessWidget {
  final String? child;
  final Color? color;

  const Pixel({
    super.key,
    this.color,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(1.2),
      decoration: BoxDecoration(
        color: color ?? Colors.grey[900],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          child ?? "",
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
