import 'package:flutter/material.dart';

Widget imageForCard(String imagePath) {
  return Padding(
    padding: const EdgeInsets.all(4),
    child: Container(
      width: 120,
      height: 130,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(7),
          bottomLeft: Radius.circular(7),
        ),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}
