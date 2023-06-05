import 'package:flutter_tetris/values.dart';

class Piece {
  final TetroBlock type;

  Piece({
    required this.type,
  });

  List<int> position = [];

  void initPosition() {
    List<int> getInitialPixelPosotion(List<int> position) {
      return [
        (position[0] - (12 * 3)),
        (position[1] - (12 * 3)),
        (position[2] - (12 * 3)),
        (position[3] - (12 * 3)),
      ];
    }

    switch (type) {
      case TetroBlock.L:
        position = getInitialPixelPosotion([5, 17, 29, 30]);
        break;
      case TetroBlock.J:
        position = getInitialPixelPosotion([6, 18, 30, 29]);
        break;
      case TetroBlock.I:
        position = getInitialPixelPosotion([5, 17, 29, 41]);
        break;
      case TetroBlock.O:
        position = getInitialPixelPosotion([5, 6, 17, 18]);
        break;
      case TetroBlock.S:
        position = getInitialPixelPosotion([5, 6, 16, 17]);
        break;
      case TetroBlock.Z:
        position = getInitialPixelPosotion([4, 5, 17, 18]);
        break;
      case TetroBlock.T:
        position = getInitialPixelPosotion([5, 17, 18, 29]);
        break;
    }
  }

  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.down:
        for (int i = 0; i < position.length; i++) {
          position[i] += rowCount;
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
