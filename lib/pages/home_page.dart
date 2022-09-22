// inspiração @CodeWithFlexz instagram
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/constanst.dart';
import '../model/modelo_meteorologico.dart';
import '../services/API_clima.dart';
import '../widget/clima_atual.dart';
import '../widget/mais_informacoes.dart.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherApiClient weatherapi = WeatherApiClient();
  WeatherModel? data;
  Future<void> getData(String? location) async {
    data = await weatherapi.getCurrentWeather(location);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.4), BlendMode.darken),
              filterQuality: FilterQuality.high,
              image: AssetImage("assets/images/asas.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          width: w,
          height: h,
          child: Container(margin: EdgeInsets.all(10), child: loadedData()),
        ),
      ),
    );
  }


//--------------------//
  FutureBuilder<void> loadedData() {
    return FutureBuilder(
      // são miguel , Pau dos Ferros, Pereiro
      future: getData("Rio de Janeiro"), 
      builder: (ctx, snp) {
        if (snp.connectionState == ConnectionState.done) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              currentWeather(
                  onPressed: () {
                    setState(() {
                      loadedData();
                    });
                  },
                  temp: "${data!.temp}",
                  location: "${data!.cityName}",
                  status: "${data!.status}",
                  country: "${data!.country}"),
              moreInfo(
                  wind: "${data!.wind}",
                  humidity: "${data!.humidity}",
                  feelsLike: "${data!.feelsLike}")
            ],
          );
        } else if (snp.connectionState == ConnectionState.waiting) {
          return Center(
            child: CupertinoActivityIndicator(
              radius: 20,
              color: Color.fromARGB(255, 172, 216, 247),
            ),
          );
        }
        return Container();
      },
    );
  }
}
