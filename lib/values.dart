import 'package:flutter/material.dart';

enum TetroBlock { L, J, I, O, S, Z, T }

enum Direction { down, left, right }

const colCount = 20;
const rowCount = 12;

const Map<TetroBlock, Color> blockColor = {
  TetroBlock.L: Colors.deepOrangeAccent,
  TetroBlock.J: Colors.orange,
  TetroBlock.I: Colors.redAccent,
  TetroBlock.O: Colors.green,
  TetroBlock.S: Colors.blue,
  TetroBlock.Z: Colors.indigo,
  TetroBlock.T: Colors.yellow,
};
