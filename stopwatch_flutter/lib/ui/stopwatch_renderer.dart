import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stopwatch_flutter/ui/clock_hand.dart';
import 'package:stopwatch_flutter/ui/clock_markers.dart';

import 'elapsed_time_text.dart';

class StopwatchRenderer extends StatelessWidget {
  const StopwatchRenderer({
    super.key,
    required this.elapsed,
    required this.radius,
  });

  final Duration elapsed;
  final double radius;

  @override
  Widget build(BuildContext context) {
    const color = Colors.orange;
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
        Positioned(
          left: radius,
          top: radius,
          child: ClockHand(
            rotationZAngle: pi +
                (2 * pi / Duration.millisecondsPerMinute) *
                    elapsed.inMilliseconds,
            handThickness: 2,
            handLength: radius,
            color: color,
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: radius * 1.3,
          child: ElapsedTimeText(
            elapsed: elapsed,
          ),
        ),
      ],
    );
  }
}
