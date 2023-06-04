import 'dart:convert';

//import 'package:'; // api_key.dart
import 'package:weathergetx/api/api_key.dart';
import 'package:weathergetx/model/weather_data.dart';
import 'package:http/http.dart' as http;
import 'package:weathergetx/model/weather_data_current.dart';
import 'package:weathergetx/model/weather_data_daily.dart';
import 'package:weathergetx/model/weather_data_hourly.dart';

import '../utils/api_url.dart';

class FetchWeatherAPI {
  WeatherData? weatherData;

  //processing the data from response -> json
  Future<WeatherData> processData(lat, lon) async {
    var response = await http.get(Uri.parse(apiURL(lat, lon)));
    var jsonString = jsonDecode(response.body);
    weatherData = WeatherData(
      WeatherDataCurrent.fromJson(jsonString),
      WeatherDataHourly.fromJson(jsonString),
      WeatherDataDaily.fromJson(jsonString),
    );

    return weatherData!;
  }
}

String apiURL(var lat, var lon) {
  String url;

  url =
      "https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&appid=$apiKey&units=metric&exclude=minutely";
  return url;
}
