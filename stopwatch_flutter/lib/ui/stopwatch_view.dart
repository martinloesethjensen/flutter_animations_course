import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stopwatch_flutter/ui/reset_button.dart';
import 'package:stopwatch_flutter/ui/start_stop_button.dart';
import 'package:stopwatch_flutter/ui/stopwatch_renderer.dart';

class StopwatchView extends StatefulWidget {
  const StopwatchView({super.key});

  @override
  State<StopwatchView> createState() => _StopwatchViewState();
}

class _StopwatchViewState extends State<StopwatchView>
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

  void _toggleStartStop() =>
      _stopwatch.isRunning ? _stopwatch.stop() : _stopwatch.start();

  @override
  Widget build(BuildContext context) {
    const buttonDimension = 120.0;
    return LayoutBuilder(
      builder: (context, constraints) {
        final radius = constraints.maxWidth / 2;
        return Stack(
          children: [
            StopwatchRenderer(
              elapsed: _stopwatch.elapsed,
              radius: radius,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: SizedBox.square(
                dimension: buttonDimension,
                child: ResetButton(onPressed: _stopwatch.reset),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox.square(
                dimension: buttonDimension,
                child: StartStopButton(
                  isRunning: _stopwatch.isRunning,
                  onPressed: _toggleStartStop,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
