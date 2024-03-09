class Weather {
  final String place;
  final double temperature;
  final double windspeed;
  final int humidity;
  final int pressure;
  final String description;
  final int visibility;
  Weather({
    required this.description,
    required this.temperature,
    required this.windspeed,
    required this.humidity,
    required this.pressure,
    required this.place,
    required this.visibility,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      place: json['name'],
      temperature: json['main']['temp'],
      windspeed: json['wind']['speed'],
      humidity: json['main']['humidity'],
      pressure: json['main']['pressure'],
      description: json["weather"][0]["description"],
      visibility: json['visibility'],
    );
  }
}
