import 'package:flutter/material.dart';
import 'package:weathergetx/controller/global_controller.dart';
import 'package:get/get.dart';
import 'package:weathergetx/model/weather/weather.dart';
import 'package:weathergetx/model/weather_data.dart';
import 'package:weathergetx/model/weather_data_hourly.dart';

import '../utils/custom_color.dart';
import '../widgets/comfort_level.dart';
import '../widgets/current_weather_widget.dart';
import '../widgets/daily_data_forecast.dart';
import '../widgets/header_widget.dart';
import '../widgets/hourly_data_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => globalController.checkLoading().isTrue
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/clouds.png",
                        height: 200,
                        width: 200,
                      ),
                      const CircularProgressIndicator(),
                    ],
                  ),
                  // child: Image.asset("assets/icons/clouds.png",
                  // height: 200,
                  // width: 200,)
                )
              : Center(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const HeaderWidget(),

                      //for our current temp ('current')
                      CurrentWeatherWidget(
                        weatherDataCurrent:
                            globalController.getData().getCurrentWeather(),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      HourlyDataWidget(
                        weatherDataHourly:
                            globalController.getData().getHourlyWeather(),
                      ),

                      DailyDataForecast(
                        weatherDataDaily:
                            globalController.getData().getDailyWeather(),
                      ),

                      Container(
                        height: 1,
                        color: CustomColors.dividerline,
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      ComfortLevel(
                          weatherDataCurrent:
                              globalController.getData().getCurrentWeather()),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
