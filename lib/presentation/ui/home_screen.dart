import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weatherwj/domain/models/weather_data.dart';
import 'package:weatherwj/data/weather_repo.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late WeatherRepo _weatherRepo;
  late Future<Weather?> _currentWeatherFuture;

  @override
  void initState() {
    super.initState();
    _weatherRepo = WeatherRepo();
    _currentWeatherFuture = _weatherRepo.getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Weather? _weather = snapshot.data as Weather?;
              if (_weather != null) {
                return weatherScreen(_weather);
              } else {
                return Text("Error getting weather");
              }
            } else if (snapshot.hasError) {
              return Text("Error getting weather");
            } else {
              return CircularProgressIndicator();
            }
          },
          future: _currentWeatherFuture,
        ),
      ),
    );
  }

  Widget weatherScreen(Weather _weather){

    String? temperature = _weather.temperature;
    String? maxtemperature = _weather.maximumTemperature;

    String formattedTemperature = double.parse(temperature!).toStringAsFixed(0);
    String formattedMaximumTemperature = double.parse(maxtemperature!).toStringAsFixed(0);

    String temperatureString = "$formattedTemperature°C";
    String maxTemperatureString = "$formattedMaximumTemperature°C";

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 50),
          color: Colors.white10,
          child: Column(
            children: [
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Icon(Icons.location_pin),
                  Text("${_weather.cityName}",style: GoogleFonts.lato(
                    textStyle: Theme.of(context).textTheme.headlineMedium,
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                  ),
                  ),
                  // Icon(Icons.menu),
                ],
              ),
              Container(
                height: 550,
                color: Colors.white10,
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(height: 60,),
                    Container(
                      child: Image.asset(
                        getImageUrl(_weather.description),
                        height: 200,
                        width: 300,
                      )
                    ),

                    SizedBox(height: 40,),
                    Text("$temperatureString", style:
                    TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.bold
                    ),
                    ),

                    SizedBox(height: 20,),

                    Text("${_weather.description}", style:
                    TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Colors.black.withOpacity(0.5),
                    )),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
              Container(
                height: 316,
                color: Colors.black,
                padding: EdgeInsets.only(top:50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(child: Column(
                      children: [
                        Image.asset(
                          'assets/windspeed.png',width: 40,
                        ),
                        SizedBox(height: 20,),
                        Text(
                          "${_weather.windspeed}Km/h",style:
                        const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold
                        ),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          'Wind',style:
                        TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),)
                      ],
                    )),
                    Expanded(child: Column(
                      children: [
                        Image.asset(
                          'assets/humidity.png',width: 40,
                        ),
                        SizedBox(height: 20,),
                        Text(
                          "${_weather.humidity}%",style:
                        TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold
                        ),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          'Humidity',style:
                        TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),)
                      ],
                    )),
                    Expanded(child: Column(
                      children: [
                        Image.asset(
                          'assets/max-temp.png',width: 40,
                        ),
                        SizedBox(height: 20,),
                        Text(
                          "$maxTemperatureString",style:
                        TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold
                        ),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          'Max-Temp',style:
                        TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),)
                      ],
                    ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String getImageUrl(String key) {
    final Map<String, String> imageUrls = {
      'Sunny': 'assets/clear.png',
      'Clouds': 'assets/heavycloud.png',
      'Clear' : 'assets/clear.png',
      'Rainy': 'assets/showers.png',
      'Snow': 'assets/snow.png',
      'Haze': 'assets/lightcloud.png',
      'Thunderstorm': "assets/heavyrain.png",
      'Drizzle': "assets/lightrain.png"
    };
    return imageUrls[key] ?? '';
  }

}
