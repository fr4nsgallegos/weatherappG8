import 'package:flutter/material.dart';

class ForecastItemWidget extends StatelessWidget {
  String hour;
  String value;
  int isDay;

  ForecastItemWidget({
    required this.hour,
    required this.value,
    required this.isDay,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, bottom: 16),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: Color(0xff3D4244),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            blurRadius: 4,
            offset: Offset(4, 8),
          )
        ],
      ),
      child: Column(
        children: [
          Text(
            "$hour h",
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 8),
          Image.asset(
            isDay == 1
                ? "assets/images/sunny.webp"
                : "assets/images/overcast.webp",
            height: 50,
          ),
          SizedBox(height: 8),
          Text(
            "$value °C",
            style: TextStyle(color: Colors.white, fontSize: 18),
          )
        ],
      ),
    );
  }
}
