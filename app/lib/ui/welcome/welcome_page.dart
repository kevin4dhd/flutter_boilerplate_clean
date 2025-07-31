import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
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
            RichText(
              text: TextSpan(
                children: _buildSpans(S.current.terms_privacy_consent),
                style: AppTextStyles.s12w400Primary(),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 37),
          ],
        ),
      ),
    );
  }

  List<TextSpan> _buildSpans(String text) {
    final spans = <TextSpan>[];

    int pivot = 0;
    while (true) {
      final sText = text.substring(pivot);
      final fIndex = sText.indexOf('{');

      if (fIndex == -1) {
        spans.add(TextSpan(text: sText));
        break;
      }

      if (fIndex > 0) {
        spans.add(TextSpan(text: sText.substring(0, fIndex)));
      }

      final lIndex = sText.indexOf('}');
      final parts = sText.substring(fIndex + 1, lIndex).split(',');

      String content;
      int? parsed = int.tryParse(parts.first);
      if (parsed == null) {
        parsed = int.tryParse(parts.last);
        content = parts.first;
      } else {
        content = parts.last;
      }

      spans.add(
        TextSpan(
          text: content,
          style: TextStyle(
            color: AppColors.current.iconsColor,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = parsed == 1 ? callBack1 : callBack2,
        ),
      );

      pivot += lIndex + 1;
    }

    return spans;
  }

  void callBack1() {
    bloc.add(const ClickOnTerms());
  }

  void callBack2() {
    bloc.add(const ClickOnPrivacity());
  }
}
