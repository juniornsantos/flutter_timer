// estou consumindo a API do openweathermap o unico parametro que passo é a cidade.
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/modelo_meteorologico.dart';

class WeatherApiClient {
  Future<WeatherModel> getCurrentWeather(String? location) async {
    var endPoint = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=c06ccef3f85fba1f9f98b66795ae4a7b&units=metric");
    var response = await http.get(endPoint);
    print(response.statusCode);
    var body = jsonDecode(response.body);
    WeatherModel weather = WeatherModel.fromJson(body);
    return weather;
  }
}
