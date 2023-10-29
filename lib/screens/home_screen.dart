import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_tetris/screens/board_screen.dart';
import 'package:flutter_tetris/screens/scores_screen.dart';
import 'package:flutter_tetris/screens/settings_screen.dart';
import 'package:flutter_tetris/widgets/appbar.dart';
import 'package:flutter_tetris/widgets/home_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

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
          Padding(
            padding: EdgeInsets.only(bottom: 5.h, top: 5.h),
            child: GestureDetector(
              child: const Text(
                "version 1.0",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
              onTap: () => showAboutDialog(
                context: context,
                applicationIcon: SizedBox(
                  height: 10.w,
                  child: Image.asset("assets/images/logo.png"),
                ),
                applicationName: "FLUTTER TETTRIS",
                applicationVersion: "1.0",
                children: [
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          "Made with",
                          style: TextStyle(fontSize: 10),
                        ),
                        const Icon(
                          Icons.favorite,
                          color: Colors.redAccent,
                        ),
                        const Text("By", style: TextStyle(fontSize: 10)),
                        InkWell(
                          child: const Text(
                            "black-purple",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 10,
                              color: Colors.blueAccent,
                            ),
                          ),
                          onTap: () async {
                            final Uri url =
                                Uri.parse("https://github.com/black-purple");
                            if (await launchUrl(url)) {
                              log("github url");
                            }
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
