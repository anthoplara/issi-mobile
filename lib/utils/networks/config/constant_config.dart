import 'package:flutter/material.dart';

class ConstantConfig {
  final String baseEndpoint = "https://issiupdate.kitaissi.com/";
  final Widget background = Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white,
          Color(0xFFFFF8F2),
        ],
      ),
    ),
  );
}
