import 'package:flutter/material.dart';

class ControlButton extends StatelessWidget {
  final Function()? onTap;
  final IconData icon;

  const ControlButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey[800],
        ),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
