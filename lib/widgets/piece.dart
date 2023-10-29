import 'package:flutter_tetris/screens/board_screen.dart';
import 'package:flutter_tetris/values.dart';

class Piece {
  final TetroBlock type;

  Piece({
    required this.type,
  });

  List<int> position = [];

  void init() {
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

  void move(Direction direction) {
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

  int rotationState = 1;
  void rotate() {
    List<int> newPosition = [];
    switch (type) {
      case TetroBlock.L:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[1] - rowCount,
              position[1],
              position[1] + rowCount,
              position[1] + rowCount + 1,
            ];

            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowCount - 1,
            ];

            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[1] + rowCount,
              position[1],
              position[1] - rowCount,
              position[1] - rowCount - 1,
            ];

            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[1] - rowCount + 1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];

            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
      case TetroBlock.J:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[1] - rowCount,
              position[1],
              position[1] + rowCount,
              position[1] + rowCount - 1,
            ];

            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[1] - rowCount - 1,
              position[1],
              position[1] - 1,
              position[1] + 1,
            ];

            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[1] + rowCount,
              position[1],
              position[1] - rowCount,
              position[1] - rowCount + 1,
            ];

            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] + rowCount + 1,
            ];

            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
      case TetroBlock.O:
        break;
      case TetroBlock.S:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowCount - 1,
              position[1] + rowCount,
            ];

            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[0] - rowCount,
              position[0],
              position[0] + 1,
              position[0] + rowCount + 1,
            ];

            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowCount - 1,
              position[1] + rowCount,
            ];

            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[0] - rowCount,
              position[0],
              position[0] + 1,
              position[0] + rowCount + 1,
            ];

            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
      case TetroBlock.Z:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[0] + rowCount - 2,
              position[1],
              position[2] + rowCount - 1,
              position[3] + 1,
            ];

            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[0] - rowCount + 2,
              position[1],
              position[2] - rowCount + 1,
              position[3] - 1,
            ];

            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[0] + rowCount - 2,
              position[1],
              position[2] - 1 + rowCount,
              position[3] + 1,
            ];

            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[0] + 2 - rowCount,
              position[1],
              position[2] - rowCount + 1,
              position[3] - 1,
            ];

            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
      case TetroBlock.T:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[1] - rowCount,
              position[1],
              position[1] + 1,
              position[1] + rowCount,
            ];

            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowCount,
            ];

            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[1] - rowCount,
              position[1] - 1,
              position[1],
              position[1] + rowCount,
            ];

            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[1] - rowCount,
              position[1] - 1,
              position[1],
              position[1] + 1,
            ];

            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
      case TetroBlock.I:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + 2,
            ];

            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[1] - rowCount,
              position[1],
              position[1] + rowCount,
              position[1] + 2 * rowCount,
            ];

            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] - 2,
            ];

            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[1] + rowCount,
              position[1],
              position[1] - rowCount,
              position[1] - 2 * rowCount,
            ];

            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
    }
  }

  bool positionIsValid(int position) {
    int row = (position / rowCount).floor();
    int col = position % rowCount;

    if (row < 0 || col < 0 || gameBoard[row][col] != null) {
      return false;
    }

    return true;
  }

  bool piecePositionIsValid(List<int> piecePosition) {
    bool firstColOccupied = false;
    bool lastColOccupied = false;

    for (int pos in position) {
      if (!positionIsValid(pos)) {
        return false;
      }

      int col = pos % rowCount;

      if (col == 0) {
        firstColOccupied = true;
      }

      if (col == rowCount - 1) {
        lastColOccupied = true;
      }
    }

    return !(firstColOccupied && lastColOccupied);
  }
}
