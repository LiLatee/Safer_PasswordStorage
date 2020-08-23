import 'package:flutter/material.dart';

Widget getDefaultIcon({String accountName, Color color, double radius = 25}) {
  return CircleAvatar(
    backgroundColor: color,
    radius: radius,
    child: Center(
      child: Text(
        accountName[0],
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      ),
    ),
  );
}
