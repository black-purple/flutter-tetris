import 'package:flutter_tetris/values.dart';
import 'package:get/get.dart';

class DifficultyController extends GetxController {
  Difficulty d = Difficulty.easy;
  int dTimer = 600;

  void updateDifficulty(Difficulty newValue) {
    d = newValue;
    switch (d) {
      case Difficulty.easy:
        dTimer = 600;
        break;
      case Difficulty.medium:
        dTimer = 450;
        break;
      case Difficulty.hard:
        dTimer = 200;
        break;
      case Difficulty.legend:
        dTimer = 100;
        break;
      default:
        dTimer = 600;
        break;
    }
    update();
  }
}
