import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tetris/controllers/difficulty_controller.dart';
import 'package:flutter_tetris/db/db.dart';
import 'package:flutter_tetris/screens/home_screen.dart';
import 'package:flutter_tetris/widgets/control_button.dart';
import 'package:flutter_tetris/widgets/piece.dart';
import 'package:flutter_tetris/widgets/pixel.dart';
import 'package:flutter_tetris/values.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

List<List<TetroBlock?>> gameBoard = List.generate(
  colCount,
  (i) => List.generate(
    rowCount,
    (j) => null,
  ),
);

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  Piece currentPiece = Piece(type: TetroBlock.L);
  int currentScore = 0;
  bool isGameOver = false;

  DatabaseHelper db = DatabaseHelper();

  void startGame() {
    currentPiece.init();
    Timer.periodic(
      Duration(milliseconds: Get.find<DifficultyController>().dTimer),
      (timer) {
        if (mounted) {
          setState(() {
            clearLine();
            checkLanding();
            if (isGameOver) {
              timer.cancel();
              showScoreAndRetry();
            }
            currentPiece.move(Direction.down);
          });
        }
      },
    );
  }

  void showScoreAndRetry() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.grey.shade800.withOpacity(0.9),
        content: SizedBox(
          height: 20.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5.h,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Game Over",
                      style: TextStyle(fontSize: 30, color: Colors.red),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  const Text(
                    "Score : ",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "$currentScore",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: resetGame, child: const Text("Retry")),
          TextButton(
            onPressed: () {
              db.addScore(
                DateTime.now().toIso8601String(),
                currentScore.toString(),
              );
              resetGame();
              Get.offAll(() => const HomeScreen());
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text("Home"),
          ),
        ],
      ),
    );
  }

  void resetGame() {
    gameBoard = List.generate(
      colCount,
      (i) => List.generate(
        rowCount,
        (j) => null,
      ),
    );

    isGameOver = false;
    currentScore = 0;

    Navigator.pop(context);
    createNewPiece();
    startGame();
  }

  bool checkCollision(Direction direction) {
    for (int i = 0; i < currentPiece.position.length; i++) {
      int row = (currentPiece.position[i] / rowCount).floor();
      int col = currentPiece.position[i] % rowCount;

      if (direction == Direction.left) {
        col -= 1;
      } else if (direction == Direction.right) {
        col += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }

      if (row >= colCount || col < 0 || col >= rowCount) {
        return true;
      } else if (col > 0 && row > 0 && gameBoard[row][col] != null) {
        return true;
      }
    }
    return false;
  }

  void checkLanding() {
    if (checkCollision(Direction.down)) {
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowCount).floor();
        int col = currentPiece.position[i] % rowCount;
        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }
      createNewPiece();
    }
  }

  void clearLine() {
    for (int row = colCount - 1; row >= 0; row--) {
      bool rowIsFull = true;

      for (int col = 0; col < rowCount; col++) {
        if (gameBoard[row][col] == null) {
          rowIsFull = false;
          break;
        }
      }

      if (rowIsFull) {
        for (int r = row; r > 0; r--) {
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }

        gameBoard[0] = List.generate(row, (index) => null);

        currentScore += 10;
      }
    }
  }

  void createNewPiece() {
    Random rand = Random();

    TetroBlock randomBlock =
        TetroBlock.values[rand.nextInt(TetroBlock.values.length)];
    currentPiece = Piece(type: randomBlock);
    currentPiece.init();

    if (gameOver()) {
      isGameOver = true;
    }
  }

  bool gameOver() {
    for (int col = 0; col < rowCount; col++) {
      if (gameBoard[0][col] != null) {
        return true;
      }
    }
    return false;
  }

  MaterialColor getScoreColor() {
    if (currentScore < 10) {
      return Colors.blue;
    } else if (currentScore >= 10 && currentScore < 100) {
      return Colors.green;
    } else if (currentScore >= 100 && currentScore < 1000) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  @override
  void initState() {
    super.initState();
    startGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 7,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: rowCount,
              ),
              itemCount: colCount * rowCount,
              itemBuilder: (_, index) {
                int row = (index / rowCount).floor();
                int col = index % rowCount;

                if (currentPiece.position.contains(index)) {
                  return Pixel(
                    color: blockColor[currentPiece.type],
                  );
                } else if (gameBoard[row][col] != null) {
                  return Pixel(
                    color: blockColor[gameBoard[row][col]],
                  );
                } else {
                  return const Pixel();
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Score: ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                Text(
                  "$currentScore",
                  style: TextStyle(
                    color: getScoreColor(),
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ControlButton(
                  icon: Icons.arrow_back_ios_new_rounded,
                  onTap: () => setState(
                    () {
                      HapticFeedback.lightImpact();
                      if (!checkCollision(Direction.left)) {
                        currentPiece.move(Direction.left);
                      }
                    },
                  ),
                ),
                ControlButton(
                  icon: Icons.rotate_right_rounded,
                  onTap: () => setState(
                    () {
                      HapticFeedback.lightImpact();
                      currentPiece.rotate();
                    },
                  ),
                ),
                ControlButton(
                  icon: Icons.arrow_forward_ios_rounded,
                  onTap: () => setState(
                    () {
                      HapticFeedback.lightImpact();
                      if (!checkCollision(Direction.right)) {
                        currentPiece.move(Direction.right);
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
