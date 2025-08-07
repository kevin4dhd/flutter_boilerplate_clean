import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:ticker_text/ticker_text.dart';

class AppTicker extends StatelessWidget {
  const AppTicker({
    super.key,
    this.child,
    this.text,
    this.style,
  });

  final Widget? child;
  final String? text;
  final TextStyle? style;

  final _tickerDuration = DurationConstants.tickerDuration;
  final _tickerReturnDuration = DurationConstants.tickerReturnDuration;

  @override
  Widget build(BuildContext context) {
    return TickerText(
      scrollDirection: Axis.horizontal,
      speed: 20,
      startPauseDuration: _tickerDuration,
      endPauseDuration: _tickerDuration,
      returnDuration: _tickerReturnDuration,
      primaryCurve: Curves.linear,
      returnCurve: Curves.easeOut,
      child: child ??
          Text(
            text ?? '',
            style: style,
          ),
    );
  }
}
