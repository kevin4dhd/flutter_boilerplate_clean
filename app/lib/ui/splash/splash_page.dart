import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
// import 'package:resources/resources.dart';

import '../../app.dart';
import '../../resource/generated/fonts.gen.dart';
import 'bloc/splash.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends BasePageState<SplashPage, SplashBloc> {
  @override
  void initState() {
    super.initState();
    bloc.add(const SplashPageInitiated());
  }

  @override
  Widget buildPage(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CommonScaffold(
      appBar: CommonAppBar(
        height: 0,
      ),
      body: CustomPaint(
        painter: DottedLinePainter(),
        child: Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 5),
              Container(
                width: 240,
                height: 240,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Assets.svg.hiGLogo.svg(),
              ),
              const SizedBox(height: 10),
              Column(
                children: [
                  Assets.images.group19.image(
                    filterQuality: FilterQuality.high,
                  ),
                  Stack(
                    children: [
                      Assets.images.group20.image(
                        filterQuality: FilterQuality.high,
                      ),
                      Positioned(
                        top: 4.6,
                        left: 175,
                        child: Container(
                          height: 20,
                          width: 31,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColors.current.secondaryColor,
                          ),
                          child: Assets.images.vector.image(),
                        ),
                      ),
                      Positioned(
                        top: 24,
                        left: 175,
                        child: Text(
                          '\$90.00',
                          style: AppTextStyles.s10BoldSecondary(),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Assets.images.msgCard.image(
                        filterQuality: FilterQuality.high,
                      ),
                      Positioned(
                        top: 18.6,
                        left: 177,
                        child: Transform.rotate(
                          angle: 0.087,
                          child: Container(
                            height: 20,
                            width: 31,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.current.secondaryColor,
                            ),
                            child: Assets.images.vector.image(),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 38,
                        left: 175,
                        child: Transform.rotate(
                          angle: 0.087,
                          child: Text(
                            '\$10.00',
                            style: AppTextStyles.s10BoldSecondary(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                child: Text(
                  'Connect,\nExchange,\nThrive!',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.s60w400Primary(
                    fontFamily: FontFamily.ntr,
                  ),
                ),
              ),
              const SizedBox(height: 36),
            ],
          ),
        ),
      ),
    );
  }
}

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF43388A)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(size.width * 0.96, size.height * 0.35);
    path.lineTo(size.width * -0.5, size.height * 0.8);
    path.lineTo(size.width * 2.5, size.height * 0.36);
    path.lineTo(size.width * -1.0, size.height * 1.2);
    path.lineTo(size.width * -1.0, size.height * 2);

    createDashedPath(canvas, path, paint);
  }

  void createDashedPath(Canvas canvas, Path path, Paint paint) {
    const dashWidth = 8.0;
    const dashSpace = 4.0;
    final totalLength = path.computeMetrics().first.length;
    double distance = 0.0;

    for (final metric in path.computeMetrics()) {
      while (distance < totalLength) {
        final nextDistance = distance + dashWidth;
        canvas.drawPath(metric.extractPath(distance, nextDistance), paint);
        distance = nextDistance + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
