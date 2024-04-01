import 'package:http/http.dart' as http;
import 'dart:convert';
import './api_key.dart' as key;

import 'package:testflutter/data/weather.dart';

class HttpHelper {

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
