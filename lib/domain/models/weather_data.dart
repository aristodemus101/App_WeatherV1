class Weather{
  String? cityName ="";
  String? temperature ="";
  String description ="";

  String? humidity ="";
  String? windspeed ="";
  String? maximumTemperature ="";
  String? timeZone ="";

  Weather({this.cityName, this.temperature, required this.description, this.humidity,
      this.windspeed, this.maximumTemperature, this.timeZone});

  factory Weather.fromJson(Map<String,dynamic> json){
    return Weather(
    cityName : json['name'].toString(),
    temperature : json['main']['temp'].toString(),
    description : json['weather'][0]['main'].toString(),

    humidity : json['main']['humidity'].toString(),
    maximumTemperature : json['main']['temp_max'].toString(),
    windspeed : json['wind']['speed'].toString(),

  );
  }
}