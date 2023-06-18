import 'package:flutter/material.dart';
import 'package:flutter_tetris/screens/board.dart';
import 'package:flutter_tetris/screens/scores_screen.dart';
import 'package:flutter_tetris/screens/settings_screen.dart';
import 'package:flutter_tetris/widgets/appbar.dart';
import 'package:flutter_tetris/widgets/home_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const CustomAppBar(title: "TETRIS"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.h),
                  image: const DecorationImage(
                    image: AssetImage("assets/images/logo.png"),
                  ),
                ),
              ),
            ),
          ),
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HomeButton(
                  color: Colors.blue,
                  screen: GameBoard(),
                  text: 'Start Game',
                ),
                HomeButton(
                  color: Colors.orangeAccent,
                  screen: ScoresScreen(),
                  text: 'Score Board',
                ),
                HomeButton(
                  color: Colors.redAccent,
                  screen: SettingsScreen(),
                  text: 'Settings',
                ),
              ],
            ),
          ),
          const Text(
            "version 1.0",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "VT323",
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
