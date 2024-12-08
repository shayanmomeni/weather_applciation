import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_application/core/constants/config.dart';
import 'package:weather_application/core/utils/enums.dart';
import 'package:weather_application/features/weather/data/data/local_weather_data.dart';
import 'package:weather_application/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:weather_application/features/weather/presentation/bloc/weather_events.dart';
import 'package:weather_application/features/weather/presentation/bloc/weather_states.dart';
import 'package:weather_application/features/weather/presentation/widgets/appbar_widget.dart';
import 'package:weather_application/features/weather/presentation/widgets/weather_info_widget.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Cities _selectedCity = Cities.values.first;
  int _selectedWeekDay = 0;
  bool _isImperial =
      LocalWeatherData().temperatureScale == TemperatureScale.imperial;

  void _toggleTemperatureScale(bool newValue) {
    setState(() {
      _isImperial = newValue;
      LocalWeatherData().temperatureScale =
          _isImperial ? TemperatureScale.imperial : TemperatureScale.metric;

      context.read<WeatherBloc>().add(GetWeatherData(_selectedCity));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WeatherAppbarWidget(
        weekDay: _selectedWeekDay,
        currentCity: _selectedCity,
        onChangedCity: (selectedCity) {
          setState(() => _selectedCity = selectedCity!);
          context.read<WeatherBloc>().add(GetWeatherData(_selectedCity));
        },
      ),
      body: BlocListener<WeatherBloc, WeatherState>(
        listener: _listener,
        child: _blocBuilder(context),
      ),
    );
  }

  void _listener(BuildContext context, WeatherState state) {
    if (state is WeatherError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
    }
  }

  BlocBuilder<WeatherBloc, WeatherState> _blocBuilder(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoading) {
          return const Center(
            child: SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(strokeWidth: 3.0),
            ),
          );
        } else if (state is WeatherLoaded &&
            state.weeklyWeatherData[_selectedWeekDay].weather.isNotEmpty) {
          return SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
              child: WeatherInfoWidget(
                selectedWeekDay: _selectedWeekDay,
                weeklyData: state.weeklyWeatherData,
                onPullToRefresh: () => context
                    .read<WeatherBloc>()
                    .add(GetWeatherData(_selectedCity)),
                onChangedWeekDay: (newSelectedWeekDay) =>
                    setState(() => _selectedWeekDay = newSelectedWeekDay),
                isImperial: _isImperial,
                onToggleScale: _toggleTemperatureScale,
              ),
            ),
          );
        } else if (state is WeatherError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  state.message,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.black87,
                      ),
                ),
                SizedBox(height: AppConfig().dimens.medium),
                ElevatedButton(
                  onPressed: () => context
                      .read<WeatherBloc>()
                      .add(GetWeatherData(_selectedCity)),
                  child: const Text('Try again'),
                ),
              ],
            ),
          );
        }

        return const Center(child: Text('No data'));
      },
    );
  }
}
