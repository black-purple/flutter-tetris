import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tetris/widgets/control_button.dart';
import 'package:flutter_tetris/widgets/piece.dart';
import 'package:flutter_tetris/widgets/pixel.dart';
import 'package:flutter_tetris/values.dart';

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
  Piece currentPiece = Piece(type: TetroBlock.J);

  void startGame() {
    currentPiece.init();

    Timer.periodic(
      const Duration(milliseconds: 500),
      (timer) {
        setState(() {
          checkLanding();
          currentPiece.move(Direction.down);
        });
      },
    );
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

  void createNewPiece() {
    Random rand = Random();

    TetroBlock randomBlock =
        TetroBlock.values[rand.nextInt(TetroBlock.values.length)];
    currentPiece = Piece(type: randomBlock);
    currentPiece.init();
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
            flex: 6,
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
                      if (!checkCollision(Direction.left)) {
                        currentPiece.move(Direction.left);
                      }
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
