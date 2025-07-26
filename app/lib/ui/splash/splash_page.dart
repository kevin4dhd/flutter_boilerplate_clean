import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../app.dart';
import 'package:shared/shared.dart';
import 'bloc/splash.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends BasePageState<SplashPage, SplashBloc>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: DurationConstants.defaultSplashDuration,
    )..repeat();
    bloc.add(const SplashPageInitiated());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      body: Center(
        child: RotationTransition(
          turns: _controller,
          child: const FlutterLogo(size: 100),
        ),
      ),
    );
  }
}
