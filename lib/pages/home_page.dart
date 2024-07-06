import 'package:flutter/material.dart';
import 'package:weatherappg8/services/api_services.dart';
import 'package:weatherappg8/widgets/weather_item.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        ApiServices apiServices = ApiServices();
        apiServices.getWeatherInfo();
      }),
      backgroundColor: Color(0xff272B2E),
      appBar: AppBar(
        centerTitle: true,
        title: Text("WeatherApp"),
        backgroundColor: Color(0xff272B2E),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.all(16),
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(25),
              gradient: LinearGradient(
                colors: [
                  Color(0xff225DF1),
                  Color(0xff679AFB),
                ],
                stops: [0.2, 0.7],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                Text(
                  "Lima, Perú",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Image.asset(
                  "assets/images/heavycloudy.webp",
                  height: 100,
                ),
                Text(
                  "25°",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 100,
                  ),
                ),
                Divider(
                  color: Colors.white,
                  height: 16,
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    WeatherItem(
                      imageName: "windspeed",
                      unit: "km/h",
                      value: "6",
                    ),
                    WeatherItem(
                      imageName: "humidity",
                      unit: "%",
                      value: "58",
                    ),
                    WeatherItem(
                      imageName: "cloud",
                      unit: "%",
                      value: "100",
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
