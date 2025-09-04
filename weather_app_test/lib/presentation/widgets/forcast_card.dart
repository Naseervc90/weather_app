import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/weather.dart';
import '../../core/constants/api_constants.dart';

class ForecastCard extends StatelessWidget {
  final Weather weather;

  const ForecastCard({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isDark ? const Color(0xFF2A3A4C) : Colors.grey.shade100,
      ),
      child: Column(
        children: [
          Text(
            DateFormat('EEE').format(weather.dateTime),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white70 : Colors.black54,
            ),
          ),
          const SizedBox(height: 8),
          CachedNetworkImage(
            imageUrl: '${ApiConstants.iconBaseUrl}${weather.icon}.png',
            width: 32,
            height: 32,
            errorWidget:
                (context, url, error) => Icon(
                  Icons.cloud,
                  size: 32,
                  color: isDark ? Colors.white60 : Colors.black54,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            '${weather.temperature.round()}°',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
