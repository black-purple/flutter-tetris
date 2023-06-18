import 'package:flutter/material.dart';

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
                  fontFamily: "VT323",
                  fontSize: 40,
                ),
              ),
            )
          : null,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.orangeAccent,
          fontFamily: "VT323",
          fontSize: title != "TETRIS" ? 50 : 100,
        ),
      ),
      centerTitle: true,
      toolbarHeight: title != "TETRIS" ? 100 : 200,
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
