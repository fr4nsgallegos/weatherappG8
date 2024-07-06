import 'package:flutter/material.dart';

class WeatherItem extends StatelessWidget {
  String value;
  String unit;
  String imageName;
  WeatherItem({
    required this.value,
    required this.unit,
    required this.imageName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          "assets/images/$imageName.webp",
          height: 50,
        ),
        Text(
          "$value $unit",
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }
}
