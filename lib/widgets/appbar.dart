import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: title != "TETRIS"
          ? TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "<",
                style: TextStyle(
                  color: Colors.orangeAccent,
                  fontSize: 30,
                ),
              ),
            )
          : null,
      title: Padding(
        padding: EdgeInsets.only(top: title == "TETRIS" ? 5.h : 0),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.orangeAccent,
            fontSize: title != "TETRIS" ? 25 : 60,
          ),
        ),
      ),
      centerTitle: true,
      toolbarHeight: title != "TETRIS" ? 100 : 250,
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
