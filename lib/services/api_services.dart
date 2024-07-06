import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weatherappg8/models/weather_model.dart';

class ApiServices {
  Future getWeatherInfo() async {
    Uri url = Uri.parse(
        "http://api.weatherapi.com/v1/current.json?key=70866d7ade244a3c9ca20142230509&q=Lima&aqi=no");
    http.Response response = await http.get(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      WeatherModel weatherModel = WeatherModel.fromJson(data);
      print(weatherModel);
    }
  }
}
