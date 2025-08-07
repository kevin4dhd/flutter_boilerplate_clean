import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';
import 'package:shared/shared.dart';

import '../../app.dart';
import 'bloc/secret_phrase_creation.dart';
import 'widgets.dart/widgets.dart';

@RoutePage()
class SecretPhraseCreationPage extends StatefulWidget {
  const SecretPhraseCreationPage({
    required this.passCodeSettings,
    super.key,
  });

  final PassCodeSettings passCodeSettings;

  @override
  State<StatefulWidget> createState() {
    return _SecretPhraseCreationPageState();
  }
}

class _SecretPhraseCreationPageState
    extends BasePageState<SecretPhraseCreationPage, SecretPhraseCreationBloc> {
  @override
  Widget buildPage(BuildContext context) {
    final dimen = AppDimen.current;
    final width = dimen.screenWidth;
    final height = dimen.screenHeight;

    return BlocBuilder<SecretPhraseCreationBloc, SecretPhraseCreationState>(
      buildWhen: (previous, current) =>
          previous.isProcessing != current.isProcessing ||
          previous.isCheck1 != current.isCheck1 ||
          previous.isCheck2 != current.isCheck2,
      builder: (context, state) {
        final secretPhrase = state.secretPhrase;
        final showSecretPhrase = secretPhrase != null;

        final enabled = !state.isProcessing;
        final isCheck1 = state.isCheck1;
        final isCheck2 = state.isCheck2;

        return CommonScaffold(
          appBar: CommonAppBar(
            automaticallyImplyLeading: false,
            text: 'backup',
            leadingIcon: LeadingIcon.none,
            actions: [
              ElevatedButton(
                onPressed: () => navigator.pop(),
                style: AppButtonStyles.getAppBarButtonStyle(),
                child: Text(
                  S.current.cancel,
                  style: AppTextStyles.s18w500Icons(
                    fontFamily: FontFamily.ntr,
                  ),
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
          body: SafeArea(
            child: Container(
              width: width,
              height: height,
              padding:
                  const EdgeInsets.symmetric(horizontal: UiConstants.commonP),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (showSecretPhrase) ...[
                      const SizedBox(height: 60),
                      SecretPhraseViewer(secretPhrase: secretPhrase),
                      const SizedBox(height: 60),
                    ] else
                      const SizedBox(height: 150),
                    Text(
                      'backup_secret_phrase',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.s30w500Primary(
                        fontFamily: FontFamily.ntr,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(horizontal: 60),
                      child: Text(
                        'protect_assets_backup_instruction',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.s20w400Popular(
                          fontFamily: FontFamily.ntr,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    if (showSecretPhrase) ...[
                      ToggleButtonWithLabel(
                        label: 'backup_warning',
                        style: AppTextStyles.s19w400Popular(
                          fontFamily: FontFamily.ntr,
                          letterSpacing: -0.5,
                        ),
                        value: isCheck2,
                        onChanged: enabled
                            ? (isCheck2) =>
                                bloc.add(SetCheck2(isCheck2: isCheck2))
                            : null,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: enabled && isCheck2
                            ? () => bloc.add(const TapOnContinue())
                            : null,
                        style: AppButtonStyles.getBasicStyle(),
                        child: Container(
                          alignment: Alignment.center,
                          width: width,
                          child: Text(S.current.continue_),
                        ),
                      ),
                    ] else ...[
                      ToggleButtonWithLabel(
                        label: 'backup_warning',
                        style: AppTextStyles.s19w400Popular(
                          fontFamily: FontFamily.ntr,
                          letterSpacing: -0.5,
                        ),
                        value: isCheck1,
                        onChanged: enabled
                            ? (isCheck1) =>
                                bloc.add(SetCheck1(isCheck1: isCheck1))
                            : null,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: enabled && isCheck1
                            ? () => bloc.add(const GenerateSecretPhrase())
                            : null,
                        style: AppButtonStyles.getBasicStyle(),
                        child: Container(
                          alignment: Alignment.center,
                          width: width,
                          child: Text('backup_manually'),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
