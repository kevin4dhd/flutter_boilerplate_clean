import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared/shared.dart';

import '../../app.dart';
import 'bloc/splash.dart';
import 'painters/painters.dart';

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
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    bloc.add(const SplashPageInitiated());
  }

  @override
  Widget buildPage(BuildContext context) {
    final dimen = AppDimen.current;
    final width = dimen.screenWidth;
    final height = dimen.screenHeight;
    return CommonScaffold(
      resizeToAvoidBottomInset: false,
      appBar: CommonAppBar(height: 0),
      body: CustomPaint(
        painter: SplashDecorativePainter(),
        child: Container(
          width: width,
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: UiConstants.commonP),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 5),
              Container(
                width: 240,
                height: 240,
                padding: const EdgeInsets.all(10),
                child: Assets.svg.hiGLogo.svg(),
              ),
              const SizedBox(height: 10),
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
