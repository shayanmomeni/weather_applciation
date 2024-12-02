import 'package:flutter/material.dart';
import 'package:weather_application/core/constants/config.dart';
import 'package:weather_application/core/utils/extentions.dart';

import 'package:weather_application/features/weather/data/model/weather_model.dart';
import 'package:weather_application/features/weather/presentation/widgets/daily_widget.dart';
import 'package:weather_application/core/components/switch_btn_widget.dart';

class WeatherInfoWidget extends StatelessWidget {
  final int selectedWeekDay;
  final List<WeatherModel> weeklyData;
  final VoidCallback onPullToRefresh;
  final Function(int weekDay) onChangedWeekDay;
  final bool isImperial;
  final ValueChanged<bool> onToggleScale;

  const WeatherInfoWidget({
    super.key,
    required this.selectedWeekDay,
    required this.weeklyData,
    required this.onPullToRefresh,
    required this.onChangedWeekDay,
    required this.isImperial,
    required this.onToggleScale,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => onPullToRefresh(),
      backgroundColor: Colors.amber,
      child: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  weeklyData[selectedWeekDay].weather.first.main,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppConfig().colors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              SizedBox(
                height: AppConfig().dimens.large,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Image.network(
                    weeklyData[selectedWeekDay]
                        .weather
                        .first
                        .icon
                        .toWeatherIconUrl,
                    fit: BoxFit.cover,
                    colorBlendMode: BlendMode.screen,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25.0),
                    child: Text(
                      '${weeklyData[selectedWeekDay].main.temp} ${isImperial ? "°F" : "°C"}',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ),
                  Text(
                    'Humidity: ${weeklyData[selectedWeekDay].main.humidity}%',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  Text(
                    'Pressure: ${weeklyData[selectedWeekDay].main.pressure} hPa',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  Text(
                    'Wind: ${weeklyData[selectedWeekDay].wind.speed} m/s',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  SizedBox(height: AppConfig().dimens.medium),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isImperial ? "Using Fahrenheit" : "Using Celsius",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(width: 10),
                      AppSwitchButton(
                        value: isImperial,
                        onChanged: onToggleScale,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 25.0),
            child: Divider(
              color: Colors.grey,
              thickness: 0.2,
            ),
          ),
          SizedBox(
            height: 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: weeklyData.length,
              separatorBuilder: (__, _) => const SizedBox(width: 10),
              itemBuilder: (context, index) => DailyWidget(
                onTapped: () => onChangedWeekDay(index),
                selected: index == selectedWeekDay,
                data: weeklyData[index],
              ),
            ),
          ),
          SizedBox(height: AppConfig().dimens.large),
        ],
      ),
    );
  }
}
