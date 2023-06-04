import 'package:flutter_tetris/values.dart';

class Piece {
  Tetromino type;
  Piece({required this.type});

  List<int> position = [];

  void initPosition() {
    switch (type) {
      case Tetromino.L:
        position = [-26, -16, -6, -5];
        break;
      case Tetromino.J:
        position = [];
        break;
      case Tetromino.O:
        position = [];
        break;
      case Tetromino.S:
        position = [];
        break;
      case Tetromino.Z:
        position = [];
        break;
      case Tetromino.T:
        position = [];
        break;
    }
  }

  void movePiece(Direction direaction) {
    switch (direaction) {
      case Direction.down:
        for (int i = 0; i < position.length; i++) {
          position[i] += rows;
        }
        break;
      case Direction.left:
        for (int i = 0; i < position.length; i++) {
          position[i] -= 1;
        }
        break;
      case Direction.right:
        for (int i = 0; i < position.length; i++) {
          position[i] += 1;
        }
        break;
    }
  }
}
