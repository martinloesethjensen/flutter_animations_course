import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'clock_hand.dart';
import 'elapsed_time_text.dart';

class StopwatchTickerUi extends StatefulWidget {
  const StopwatchTickerUi({
    super.key,
    required this.radius,
  });

  final double radius;

  @override
  State<StopwatchTickerUi> createState() => StopwatchTickerUiState();
}

class StopwatchTickerUiState extends State<StopwatchTickerUi>
    with SingleTickerProviderStateMixin {
  late final Stopwatch _stopwatch;
  late final Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch()..start();
    _ticker = createTicker((_) => setState(() {}))..start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void start() {
    _stopwatch.start();
  }

  void stop() {
    _stopwatch.stop();
  }

  void reset() {
    _stopwatch.reset();
  }

  @override
  Widget build(BuildContext context) {
    const color = Colors.orange;
    final radius = widget.radius;
    final elapsed = _stopwatch.elapsed;
    return Stack(children: [
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
    ]);
  }
}
