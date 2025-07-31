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
    return CommonScaffold(
      appBar: CommonAppBar(height: 0),
      body: Container(
        width: width,
        height: size.height,
        padding: const EdgeInsets.symmetric(horizontal: UiConstants.commonP),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(height: 45),
            Container(
              width: 240,
              height: 250,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Assets.svg.hiGLogo.svg(),
            ),
            const SizedBox(height: 110),
            SizedBox(
              child: Text(
                'Connect, Exchange,\nThrive!',
                textAlign: TextAlign.center,
                style: AppTextStyles.s42w400Primary(
                  fontFamily: FontFamily.ntr,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => bloc.add(const ClickOnContinue()),
              style: AppButtonStyles.basicButton,
              child: Container(
                alignment: Alignment.center,
                width: width,
                child: Text(S.current.continue_),
              ),
            ),
            RichText(
              text: TextSpan(
                children: _buildSpans(S.current.terms_privacy_consent),
                style: AppTextStyles.s10w400Primary(),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
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

/*"de": {
 "terms_privacy_consent": "Durch Tippen auf „Weiter“ stimmst du unseren {Nutzungsbedingungen,1} und unserer {Datenschutzrichtlinie,2} zu.",
},
"fr": {
 "terms_privacy_consent": "En appuyant sur « Continuer », vous acceptez nos {Conditions d'utilisation,1} et notre {Politique de confidentialité,2}.",
},
"tr": {
 "terms_privacy_consent": "\"Devam\" seçeneğine dokunarak, {Hizmet Şartlarımızı,1} ve {Gizlilik Politikamızı,2} kabul etmiş olursunuz.",
},
"ar": {
 "terms_privacy_consent": "بالنقر على \"متابعة\"، فإنك توافق على {1,شروط الخدمة الخاصة بنا،1} و{2,سياسة الخصوصية الخاصة بنا}.",
},
"it": {
 "terms_privacy_consent": "Toccando \"Continua\", accetti e acconsenti ai nostri {Termini di servizio,1} e alla nostra {Informativa sulla privacy,2}.",
}*/
