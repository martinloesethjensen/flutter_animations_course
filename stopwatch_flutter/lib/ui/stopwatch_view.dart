import 'package:flutter/material.dart';
import 'package:stopwatch_flutter/ui/reset_button.dart';
import 'package:stopwatch_flutter/ui/start_stop_button.dart';
import 'package:stopwatch_flutter/ui/stopwatch_renderer.dart';
import 'package:stopwatch_flutter/ui/stopwatch_ticker_ui.dart';

class StopwatchView extends StatefulWidget {
  const StopwatchView({super.key});

  @override
  State<StopwatchView> createState() => _StopwatchViewState();
}

class _StopwatchViewState extends State<StopwatchView> {
  final GlobalKey<StopwatchTickerUiState> _tickerUiKey = GlobalKey();
  bool _isRunning = true;

  @override
  Widget build(BuildContext context) {
    const buttonDimension = 120.0;
    return LayoutBuilder(
      builder: (context, constraints) {
        final radius = constraints.maxWidth / 2;
        final tickerUiState = _tickerUiKey.currentState;
        return Stack(
          children: [
            StopwatchRenderer(radius: radius),
            StopwatchTickerUi(key: _tickerUiKey, radius: radius),
            Align(
              alignment: Alignment.bottomLeft,
              child: SizedBox.square(
                dimension: buttonDimension,
                child: ResetButton(onPressed: tickerUiState?.reset),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox.square(
                dimension: buttonDimension,
                child: StartStopButton(
                  isRunning: _isRunning,
                  onPressed: () {
                    setState(() {
                      _isRunning
                          ? tickerUiState?.stop()
                          : tickerUiState?.start();
                      _isRunning = !_isRunning;
                    });
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
