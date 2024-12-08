import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_application/features/weather/data/data/remote_weather_data.dart';
import 'package:weather_application/features/weather/data/repo/weather_repo_impl.dart';
import 'package:weather_application/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:weather_application/features/weather/presentation/views/weather_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WeatherBloc(
        WeatherRepositoryImpl(
          remote: RemoteWeatherDatasource(),
        ),
      ),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WeatherScreen(),
      ),
    );
  }
}
