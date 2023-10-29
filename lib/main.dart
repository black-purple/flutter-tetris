import 'package:flutter/material.dart';
import 'package:flutter_tetris/controllers/difficulty_controller.dart';
import 'package:flutter_tetris/screens/home_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DifficultyController());
    return ResponsiveSizer(
      builder: (context, orientation, screenType) => GetMaterialApp(
        theme: ThemeData(
          primaryColor: Colors.orangeAccent,
          primarySwatch: Colors.orange,
          fontFamily: "PressStart2P",
          useMaterial3: false,
        ),
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      ),
    );
  }
}
