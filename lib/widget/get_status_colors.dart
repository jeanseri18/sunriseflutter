import 'package:flutter/material.dart';

class getStatusColors {
  String? state;
  Color getColorFromState() {
    switch (state) {
      case "attente":
        return Colors.blue;
      case "realiser":
        return Colors.green;
      case "accepter":
        return Colors.yellow;
      case "terminer":
        return Colors.green;
      case "annuler":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
