import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';
import 'package:shared/shared.dart';

import '../../app.dart';
import 'bloc/welcome.dart';

@RoutePage()
class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _WelcomePageState();
  }
}

class _WelcomePageState extends BasePageState<WelcomePage, WelcomeBloc> {
  @override
  Widget buildPage(BuildContext context) {
    final dimen = AppDimen.current;
    final width = dimen.screenWidth;
    final height = dimen.screenHeight;
    return CommonScaffold(
      resizeToAvoidBottomInset: false,
      appBar: CommonAppBar(height: 0),
      body: SafeArea(
        child: Container(
          width: width,
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: UiConstants.commonP),
          child: Column(
            children: [
              SizedBox(height: height * 0.15),
              Expanded(
                child: Container(
                  alignment: Alignment.topCenter,
                  width: 240,
                  height: 250,
                  padding: const EdgeInsets.all(20),
                  child: Assets.svg.hiGLogo.svg(),
                ),
              ),
              SizedBox(
                child: Text(
                  'Connect, Exchange,\nThrive!',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.s42w400Primary(
                    fontFamily: FontFamily.ntr,
                  ),
                ),
              ),
              const SizedBox(height: 22),
              ElevatedButton(
                onPressed: () => bloc.add(const ClickOnContinue()),
                style: AppButtonStyles.getBasicStyle(),
                child: Container(
                  alignment: Alignment.center,
                  width: width,
                  child: Text(S.current.continue_),
                ),
              ),
              const SizedBox(height: 22),
              ClickableRichText(
                text: S.current.termsPrivacyConsent,
                onLinkTap: _onLinkTap,
                textAlign: TextAlign.center,
                textStyle: AppTextStyles.s12w400Primary(),
              ),
              const SizedBox(height: 37),
            ],
          ),
        ),
      ),
    );
  }

  void _onLinkTap(int linkId) {
    switch (linkId) {
      case 1:
        bloc.add(const ClickOnTerms());
        break;
      case 2:
        bloc.add(const ClickOnPrivacity());
        break;
    }
  }
}
