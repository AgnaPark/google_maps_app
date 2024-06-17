import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/weather_model.dart';
import 'package:http/http.dart' as http;
class WeatherService{

  static const BASE_URL = "https://api.openweathermap.org/data/2.5/weather";
  static String apiKey = "ffe8f87253ef31f0a08d3117716eed89";

  Future<Weather> getWeather(String cityName) async{
    final response = await http.get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'));

    if(response.statusCode == 200){
      return Weather.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Failed to load weather data');
    }
  }

  Future<String> getCurrentCity(LatLng currentPosition) async{

    List<Placemark> placemarks =
        await placemarkFromCoordinates(currentPosition.latitude, currentPosition.longitude);

    // Extract the city name form the first placemark
    String? city = placemarks[0].locality;

    return city ?? "";

  }
}