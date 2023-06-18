import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeButton extends StatelessWidget {
  final Widget screen;
  final String text;
  final Color color;
  const HomeButton({
    super.key,
    required this.screen,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: 8.h,
      child: TextButton(
        onPressed: () => Get.to(() => screen),
        style: TextButton.styleFrom(
          foregroundColor: color,
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 30, fontFamily: "VT323"),
        ),
      ),
    );
  }
}
