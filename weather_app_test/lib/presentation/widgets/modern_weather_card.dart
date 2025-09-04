import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/entities/weather.dart';
import '../../core/constants/api_constants.dart';

class ModernWeatherCard extends StatelessWidget {
  final Weather weather;

  const ModernWeatherCard({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color:
            isDark
                ? const Color(0xFF1E2B3C) // Dark blue card
                : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            weather.cityName,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 16),

          // Weather Icon
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: CachedNetworkImage(
              imageUrl: '${ApiConstants.iconBaseUrl}${weather.icon}@2x.png',
              width: 80,
              height: 80,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget:
                  (context, url, error) => Icon(
                    Icons.wb_sunny,
                    size: 80,
                    color: Colors.orange.shade600,
                  ),
            ),
          ),

          const SizedBox(height: 16),

          // Temperature
          Text(
            '${weather.temperature.round()}°',
            style: TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.w300,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),

          // Description
          Text(
            weather.description.toUpperCase(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white70 : Colors.black54,
              letterSpacing: 1.2,
            ),
          ),

          const SizedBox(height: 24),

          // Weather Details Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildWeatherDetail(
                icon: Icons.thermostat,
                label: 'Feels like',
                value: '${weather.feelsLike.round()}°',
                isDark: isDark,
              ),
              _buildWeatherDetail(
                icon: Icons.water_drop,
                label: 'Humidity',
                value: '${weather.humidity}%',
                isDark: isDark,
              ),
              _buildWeatherDetail(
                icon: Icons.air,
                label: 'Wind',
                value: '${weather.windSpeed.toStringAsFixed(1)} m/s',
                isDark: isDark,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherDetail({
    required IconData icon,
    required String label,
    required String value,
    required bool isDark,
  }) {
    return Column(
      children: [
        Icon(icon, color: isDark ? Colors.white60 : Colors.black54, size: 20),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isDark ? Colors.white60 : Colors.black54,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
      ],
    );
  }
}
