import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/utils/constants.dart';
import '../bloc/theme_event.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';
import '../bloc/weather_state.dart';
import '../bloc/theme_bloc.dart';
import '../widgets/forcast_card.dart';
import '../widgets/modern_weather_card.dart';
import '../widgets/modern_search_widget.dart';
import '../widgets/error_widget.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  void initState() {
    super.initState();
    // Load default city weather when app starts
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        try {
          context.read<WeatherBloc>().add(
            WeatherRequested(AppConstants.defaultCity),
          );
        } catch (e) {
          print('❌ Error loading default city: $e');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0D1B2A) : Colors.grey.shade50,
      body: SafeArea(
        child: Column(
          children: [
            // App Bar with theme toggle
            _buildAppBar(context, isDark),

            // Main content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Search Widget
                    BlocBuilder<WeatherBloc, WeatherState>(
                      builder: (context, state) {
                        return ModernSearchWidget(
                          onSearch: (cityName) {
                            context.read<WeatherBloc>().add(
                              ForecastRequested(cityName),
                            );
                          },
                          isLoading: state is WeatherLoading,
                        );
                      },
                    ),

                    // Weather Content
                    BlocBuilder<WeatherBloc, WeatherState>(
                      builder: (context, state) {
                        return _buildWeatherContent(context, state);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Weather',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          IconButton(
            onPressed: () {
              context.read<ThemeBloc>().add(ThemeToggled());
            },
            icon: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
              color: isDark ? Colors.white70 : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherContent(BuildContext context, WeatherState state) {
    if (state is WeatherInitial) {
      return _buildInitialState(context);
    }

    if (state is WeatherLoading) {
      return _buildLoadingState(context);
    }

    if (state is WeatherLoaded) {
      return ModernWeatherCard(weather: state.weather);
    }

    if (state is ForecastLoaded) {
      return Column(
        children: [
          ModernWeatherCard(weather: state.currentWeather),
          _buildForecastSection(context, state),
        ],
      );
    }

    if (state is WeatherError) {
      return ModernErrorWidget(
        message: state.message,
        onRetry: () {
          // You can implement retry logic here
        },
      );
    }

    return const SizedBox();
  }

  Widget _buildInitialState(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Icon(
            Icons.cloud_outlined,
            size: 120,
            color: isDark ? Colors.white30 : Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            'Search for a city to see the weather',
            style: TextStyle(
              fontSize: 18,
              color: isDark ? Colors.white60 : Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          CircularProgressIndicator(
            color: isDark ? Colors.white70 : const Color(0xFF4A90E2),
          ),
          const SizedBox(height: 16),
          Text(
            'Fetching weather data...',
            style: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildForecastSection(BuildContext context, ForecastLoaded state) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '5-Day Forecast',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount:
                  state.forecast.dailyForecasts.length > 5
                      ? 5
                      : state.forecast.dailyForecasts.length,
              itemBuilder: (context, index) {
                return ForecastCard(
                  weather: state.forecast.dailyForecasts[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
