import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/Models/weather_model.dart';
import 'package:weather_app/Services/weather_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final _weatherservice = WeatherService();
  Weather? _weather;

  _fetchApi() async {
    try {
      final cityName = await _weatherservice.getCurrentCity();
      final weather = await _weatherservice.getWeather(cityName);
      debugPrint(_weather as String?);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  IconData getIcon(int condition) {
    if (condition <= 0) {
      return Icons.icecream_rounded;
    } else if (condition <= 10) {
      return Icons.icecream_sharp;
    } else if (condition <= 20) {
      return Icons.ice_skating;
    } else if (condition <= 30) {
      return Icons.hot_tub;
    } else if (condition <= 40) {
      return Icons.sunny;
    } else {
      return Icons.sunny;
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchApi();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 67, 67, 67),
                Color.fromARGB(26, 95, 94, 94)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: _weather == null
              ? Center(
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.grey[400],
                      ),
                      height: 100.0,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: const Center(
                        child: Text(
                          "Loading..",
                          style: TextStyle(fontSize: 30.0, color: Colors.white),
                        ),
                      )),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat('hh:mm a').format(DateTime.now()),
                              style: const TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              _weather?.place ?? "",
                              style: const TextStyle(
                                fontSize: 30.0,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        // Row(
                        //   children: [
                        //     Container(
                        //       width: 40.0,
                        //       height: 40.0,
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(20.0),
                        //         color: Colors.grey[300],
                        //       ),
                        //       child: const Icon(
                        //         Icons.settings,
                        //         color: Colors.white,
                        //         size: 30,
                        //       ),
                        //     ),
                        //     Container(
                        //       width: 40.0,
                        //       height: 40.0,
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(20.0),
                        //         color: Colors.white,
                        //       ),
                        //       child: const Icon(
                        //         Icons.home_outlined,
                        //         size: 30,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ), //First Box
                    Divider(
                      height: 20,
                      thickness: 2,
                      endIndent: MediaQuery.of(context).size.width / 2,
                      color: Colors.white54,
                    ),
                    Text(
                      _weather?.description ?? "",
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                         Icon(
                          getIcon(_weather!.temperature.round()),
                          size: 80.0,
                          color: Colors.white70,
                        ),
                        Text(
                          '${_weather?.temperature.round()}°C',
                          style:  const TextStyle(
                              fontSize: 80.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white70),
                        )
                      ],
                    ), //degree and image roe
                    const SizedBox(height: 20),
                    const Text(
                      "Details",
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                    const Divider(
                      height: 20,
                      thickness: 2,
                      color: Colors.white54,
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 40.0,
                              width: 120.0,
                              decoration: BoxDecoration(
                                color: Colors.grey[350],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Center(
                                child: Text(
                                  "Wind",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Text(
                              _weather?.windspeed.toString() ?? "",
                              style: const TextStyle(
                                  fontSize: 25.0, color: Colors.white),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              height: 40.0,
                              width: 120.0,
                              decoration: BoxDecoration(
                                color: Colors.grey[350],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Center(
                                child: Text(
                                  "Humidity",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Text(
                              "${_weather?.humidity ?? ""} %",
                              style: const TextStyle(
                                  fontSize: 25.0, color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 40.0,
                              width: 120.0,
                              decoration: BoxDecoration(
                                color: Colors.grey[350],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Center(
                                child: Text(
                                  "Visibility",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Text(
                              '${_weather?.visibility}',
                              style: const TextStyle(
                                  fontSize: 25.0, color: Colors.white),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              height: 40.0,
                              width: 120.0,
                              decoration: BoxDecoration(
                                color: Colors.grey[350],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Center(
                                child: Text(
                                  "Pressure",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Text(
                              '${_weather?.pressure}',
                              style: const TextStyle(
                                  fontSize: 25.0, color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
