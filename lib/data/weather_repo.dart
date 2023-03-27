import 'package:geolocator/geolocator.dart';
import 'package:weatherwj/domain/models/weather_data.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';


class WeatherRepo{

  Future<Position> getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<Weather?> getCurrentWeather() async {
    Weather? weather;
    String apiKey = "xyc365c9c608a4d092689872fc050e9112";
    Position position = await getCurrentLocation();

    // double lat = position.latitude;
    // double lon = position.longitude;

    // Bengaluru
    String lat = "12.9716";
    String lon = "77.5946";

    //Delhi
    // String lat = "28.7041";
    // String lon = "77.1025";

    // Mumbai
    // String lat = "19.1075";
    // String lon = "72.8263";

    String apiUrl = "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=$apiKey";

    try {
      var response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {

        var jsonBody = json.decode(response.body);
        // print(jsonBody);
        weather = Weather.fromJson(jsonBody);
      } else {
        print("HTTP error ${response.statusCode}");
      }
    } catch (e) {
      print("HTTP request failed: $e");
    }

    return weather;
  }

}
