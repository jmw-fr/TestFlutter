import 'package:http/http.dart' as http;
import 'dart:convert';
import './api_key.dart' as key;

import 'package:testflutter/data/weather.dart';

class HttpHelper {
  final String uri =
      "https://api.openweathermap.org/data/2.5/weather?q=Paris,033&appid=61ab07032c1f9c488013221e2eebecb3";

  final String host = "api.openweathermap.org";
  final String path = "/data/2.5/weather";
  final String apiKey = key.apiKey;

  Future<Weather> getWeather(String location) async {
    Map<String, dynamic> parameters = {
      "q": location,
      "appid": apiKey,
    };
    Uri uri = Uri.https(host, path, parameters);

    http.Response response = await http.get(uri);

    Map<String, dynamic> data = json.decode(response.body);

    return Weather.fromJson(data);
  }
}
