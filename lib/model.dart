import 'package:flutter/material.dart';

/// Model to store Row Index and Column Index for a respective value.
class PointerInfo {
  /// M corresponds to the row number or row index
  final int m;

  /// N corresponds to the column number or column index
  final int n;

  const PointerInfo({required this.m, required this.n});
}

/// Data to contain all the directions' list seperated and combined
class AllDirectionalList {
  /// individual left-to-right directional list for matches indices
  final List<PointerInfo> eastDirectionIndices;

  /// individual top-to-bottom directional list for matches indices
  final List<PointerInfo> southDirectionIndices;

  /// individual topLeft-to-bottomRight directional list for matches indices
  final List<PointerInfo> southEastDirectionIndices;

  /// combined all the directions list for matches indices
  List<PointerInfo>? allColoredIndicesList;

  AllDirectionalList(
      {required this.eastDirectionIndices,
      required this.southDirectionIndices,
      required this.southEastDirectionIndices,
      this.allColoredIndicesList});

  /// to check whether there are any values in any of the lists
  bool isEmpty() {
    return eastDirectionIndices.isEmpty &&
        southDirectionIndices.isEmpty &&
        southEastDirectionIndices.isEmpty;
  }
}

/// Function to check whether a grid list contains other specific grid
bool piListContainsPI(
    {required List<PointerInfo> list, required PointerInfo item}) {
  for (int k = 0; k < list.length; k++) {
    if (list[k].m == item.m && list[k].n == item.n) return true;
  }
  return false;
}

class ConstantValues {
  static const Color backgroundColor = Colors.white;
  static const Color accentColor = Colors.blueAccent;
  static const Color highlightColor = Colors.red;
  static const Color boxShadowColor = Colors.black26;
}
