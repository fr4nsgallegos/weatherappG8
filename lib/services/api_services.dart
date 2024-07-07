import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weatherappg8/models/forecast_model.dart';
import 'package:weatherappg8/models/weather_model.dart';

class ApiServices {
  String apiKey = "";

  Future<WeatherModel?> getWeatherInfo() async {
    Uri url = Uri.parse(
        "http://api.weatherapi.com/v1/current.json?key=$apiKey&q=Cusco&aqi=no");
    http.Response response = await http.get(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      WeatherModel weatherModel = WeatherModel.fromJson(data);
      print(weatherModel);
      return weatherModel;
    }
    return null;
  }

  Future<ForecastModel?> getForecastInfo() async {
    Uri url = Uri.parse(
        "http://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=Lima&days=1&aqi=no&alerts=no");
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      ForecastModel forecastModel = ForecastModel.fromJson(data);
      return forecastModel;
    }
    return null;
  }
}
