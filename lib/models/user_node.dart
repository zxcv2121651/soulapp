import 'package:flutter/material.dart';

class UserNode {
  final String id;
  final String name;
  final bool isOnline;
  final Color starColor;
  final bool hasShadow;
  final String matchPercent;
  final String matchDescribe;

  double x;
  double y;
  double z;

  UserNode({
    required this.id,
    required this.name,
    required this.isOnline,
    required this.starColor,
    required this.hasShadow,
    required this.matchPercent,
    required this.matchDescribe,
    this.x = 0,
    this.y = 0,
    this.z = 0,
  });
}
