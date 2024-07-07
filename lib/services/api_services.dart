import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weatherappg8/models/forecast_model.dart';
import 'package:weatherappg8/models/product_model.dart';
import 'package:weatherappg8/models/weather_model.dart';

class ApiServices {
  String apiKey = "70866d7ade244a3c9ca20142230509";

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

  Future<ForecastModel?> getForecastInfoLocation(
      double lat, double long) async {
    Uri url = Uri.parse(
        "http://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$lat,$long&days=1&aqi=no&alerts=no");
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      ForecastModel forecastModel = ForecastModel.fromJson(data);
      return forecastModel;
    }
    return null;
  }

  Future<ForecastModel?> getForecastInfo() async {
    Uri url = Uri.parse(
        "http://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=Cusco&days=1&aqi=no&alerts=no");
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      ForecastModel forecastModel = ForecastModel.fromJson(data);
      return forecastModel;
    }
    return null;
  }

  Future<List<Product>?> getProductsFakeApi() async {
    Uri url = Uri.parse("https://fakestoreapi.com/products");
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Product> productList = data.map((e) => Product.fromJson(e)).toList();
      print(productList);
      productList.forEach((element) => print(element.title));
      return productList;
    }
    return null;
  }

  Future<void> postProductFakeApi() async {
    Rating rating = Rating(rate: 10.5, count: 10);

    Product _producto = Product(
        id: 25,
        title: "PRODUCOT NUEVO",
        price: 12.5,
        description: "ESTE ES UNPRODUCTO NUEVO",
        category: "women's clothing",
        image:
            "https://fakestoreapi.com/img/51eg55uWmdL._AC_UX679_.jpghttps://fakestoreapi.com/img/51eg55uWmdL._AC_UX679_.jpg",
        rating: rating);

    Uri url = Uri.parse("https://fakestoreapi.com/products");
    http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(_producto.toJson()),
    );
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print("no se agrego correctamente");
    }
  }
}
