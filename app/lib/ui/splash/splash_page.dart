import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../app.dart';
import 'package:shared/shared.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  late final Animation<double> _scaleAnimation;
  late final Animation<Color?> _startColorAnimation;
  late final Animation<Color?> _endColorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: DurationConstants.defaultSplashDuration,
    )..repeat(reverse: true);
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _startColorAnimation = ColorTween(
      begin: const Color(0xFF001b4e),
      end: const Color(0xFF004e92),
    ).animate(_controller);
    _endColorAnimation = ColorTween(
      begin: const Color(0xFF0f2b72),
      end: const Color(0xFF2a5298),
    ).animate(_controller);
    bloc.add(const SplashPageInitiated());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget buildPage(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CommonScaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _startColorAnimation.value ?? const Color(0xFF001b4e),
                  _endColorAnimation.value ?? const Color(0xFF2a5298),
                ],
              ),
            ),
            child: Center(
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: SvgPicture.asset(
                  'assets/images/app_logo.svg',
                  width: 120,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
