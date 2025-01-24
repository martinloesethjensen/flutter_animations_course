import 'package:flutter/material.dart';
import 'package:stopwatch_flutter/ui/clock_markers.dart';

class StopwatchRenderer extends StatelessWidget {
  const StopwatchRenderer({
    super.key,
    required this.radius,
  });

  final double radius;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        for (var i = 0; i < Duration.secondsPerMinute; i++)
          Positioned(
            left: radius,
            top: radius,
            child: ClockSecondsTickMarker(seconds: i, radius: radius),
          ),
        for (var i = 5; i <= Duration.secondsPerMinute; i += 5)
          Positioned(
            left: radius,
            top: radius,
            child: ClockTextMarker(
              value: i,
              maxValue: Duration.secondsPerMinute,
              radius: radius,
            ),
          ),
      ],
    );
  }
}
