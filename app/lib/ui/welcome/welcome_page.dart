import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';
import 'package:shared/shared.dart';

import '../../app.dart';
import '../../shared_view/text/text.dart';
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
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return CommonScaffold(
      appBar: CommonAppBar(height: 0),
      body: Container(
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
              style: AppButtonStyles.basicButton,
              child: Container(
                alignment: Alignment.center,
                width: width,
                child: Text(S.current.continue_),
              ),
            ),
            const SizedBox(height: 22),
            ClickableRichText(
              text: S.current.terms_privacy_consent,
              onLinkTap: _onLinkTap,
              textAlign: TextAlign.center,
              textStyle: AppTextStyles.s12w400Primary(),
            ),
            const SizedBox(height: 37),
          ],
        ),
      ),
    );
  }

  void _onLinkTap(int linkId, String linkText) {
    switch (linkId) {
      case 1:
        bloc.add(const ClickOnTerms());
        break;
      case 2:
        bloc.add(const ClickOnPrivacity());
        break;
      default:
        // Handle unknown links if needed
        break;
    }
  }
}
