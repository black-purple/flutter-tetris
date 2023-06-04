import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tetris/piece.dart';
import 'package:flutter_tetris/pixel.dart';
import 'package:flutter_tetris/values.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  Piece currentPiece = Piece(type: Tetromino.L);

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    currentPiece.initPosition();

    Duration frameRate = const Duration(seconds: 1);
    gameLoop(frameRate);
  }

  void gameLoop(Duration frameRate) {
    Timer.periodic(frameRate, (timer) {
      setState(() {
        currentPiece.movePiece(Direction.down);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: rows,
          ),
          itemCount: cols * rows,
          itemBuilder: (_, index) {
            if (currentPiece.position.contains(index)) {
              return Pixel(
                child: index,
                color: Colors.amber,
              );
            }
            return Pixel(child: index);
          }),
    );
  }
}
