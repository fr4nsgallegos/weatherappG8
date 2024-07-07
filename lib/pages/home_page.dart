import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherappg8/models/forecast_model.dart';
// import 'package:weatherappg8/models/forecast_model.dart';
import 'package:weatherappg8/models/weather_model.dart';
import 'package:weatherappg8/services/api_services.dart';
import 'package:weatherappg8/widgets/forecast_item_widget.dart';
import 'package:weatherappg8/widgets/weather_item.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherModel? model;
  ForecastModel? forecastModel;
  ApiServices apiServices = ApiServices();
  Future<void> getWeather() async {
    model = await apiServices.getWeatherInfo();
    setState(() {});
  }

  Future<void> getForecasteWeather() async {
    forecastModel = await apiServices.getForecastInfo();
    setState(() {});
  }

  Future<Position> getLocation() async {
    bool _serviceEnabled;
    LocationPermission _permission;

    _serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!_serviceEnabled) {
      return Future.error("Servicios de geolocalización desahabilitados");
    }

    _permission = await Geolocator.checkPermission();
    if (_permission == LocationPermission.denied) {
      _permission = await Geolocator.requestPermission();
      if (_permission == LocationPermission.denied) {
        return Future.error("Los permisos han sido denegados");
      }
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<void> getDataLocation() async {
    Position position = await getLocation();
    forecastModel = await apiServices.getForecastInfoLocation(
      position.latitude,
      position.longitude,
    );
    setState(() {});
  }

  @override
  void initState() {
    // getWeather();
    // getForecasteWeather();
    getDataLocation();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () async {
        // Position position = await getLocation();
        // print(position);
        // ApiServices apiServices = ApiServices();
        // apiServices.getProductsFakeApi();
        apiServices.postProductFakeApi();
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
            child: forecastModel == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      Text(
                        "${forecastModel?.location.name}, ${forecastModel?.location.country}",
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
                        "${forecastModel?.current.tempC}°",
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
                            value: forecastModel!.current.windKph.toString(),
                          ),
                          WeatherItem(
                            imageName: "humidity",
                            unit: "%",
                            value: forecastModel!.current.humidity.toString(),
                          ),
                          WeatherItem(
                            imageName: "cloud",
                            unit: "%",
                            value: forecastModel!.current.cloud.toString(),
                          ),
                        ],
                      )
                    ],
                  ),
          ),
          Text(
            "Forecast",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
          SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: forecastModel == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Row(
                    children: List.generate(
                      forecastModel!.forecast.forecastday[0].hour.length,
                      (index) => ForecastItemWidget(
                        hour: forecastModel!
                            .forecast.forecastday[0].hour[index].time
                            .toString()
                            .substring(10, 16),
                        value: forecastModel!
                            .forecast.forecastday[0].hour[index].tempC
                            .toString(),
                        isDay: forecastModel!
                            .forecast.forecastday[0].hour[index].isDay,
                      ),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
