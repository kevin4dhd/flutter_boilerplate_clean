import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';
import 'package:shared/shared.dart';

import '../../app.dart';
import 'bloc/secret_phrase_verification.dart';
import 'widgets/widgets.dart';

@RoutePage()
class SecretPhraseVerificationPage extends StatefulWidget {
  const SecretPhraseVerificationPage({
    required this.params,
    super.key,
  });

  final SecretPhraseVerificationParams params;

  @override
  State<StatefulWidget> createState() {
    return _SecretPhraseVerificationPageState();
  }
}

class _SecretPhraseVerificationPageState extends BasePageState<
    SecretPhraseVerificationPage, SecretPhraseVerificationBloc> {
  final _rows = (UiConstants.wordsToVerify / 2).ceil() - 1;
  final _isEven = UiConstants.wordsToVerify % 2 == 0;

  @override
  void initState() {
    super.initState();
    bloc.add(PageInitiated(secretPhrase: widget.params.secretPhrase));
  }

  @override
  Widget buildPage(BuildContext context) {
    final dimen = AppDimen.current;
    final width = dimen.screenWidth;
    final height = dimen.screenHeight;

    return BlocBuilder<SecretPhraseVerificationBloc,
        SecretPhraseVerificationState>(
      buildWhen: (previous, current) =>
          previous.isLoading != current.isLoading ||
          previous.isProcessing != current.isProcessing ||
          previous.selectedWords != current.selectedWords ||
          previous.verificationError != current.verificationError,
      builder: (context, state) {
        final selectedWords = state.selectedWords;
        final randomIndexes = state.randomIndexes;

        final enabled = !state.isProcessing &&
            selectedWords.length == UiConstants.wordsToVerify;

        return CommonScaffold(
          appBar: CommonAppBar(
            automaticallyImplyLeading: false,
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
          body: state.isLoading
              ? SizedBox.shrink()
              : SafeArea(
                  child: Container(
                    width: width,
                    height: height,
                    padding: const EdgeInsets.symmetric(
                        horizontal: UiConstants.commonP),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.current.confirmSeedPhraseTitle,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.s18w500Primary(
                              fontFamily: FontFamily.poppins,
                            ),
                          ),
                          SizedBox(height: height * 0.05),
                          Padding(
                            padding: const EdgeInsets.all(UiConstants.commonP),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  S.current.confirmSeedPhraseInstruction,
                                  style: AppTextStyles.s14w400Shade(
                                    fontFamily: FontFamily.poppins,
                                  ),
                                ),
                                SizedBox(height: height * 0.05),
                                ...List<Widget>.generate(
                                  _rows,
                                  (row) {
                                    final index = 2 * row;
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          bottom: height * 0.02),
                                      child: Row(
                                        children: [
                                          WordViewer(
                                            index: index,
                                            randomIndexes: randomIndexes,
                                            selectedWords: selectedWords,
                                          ),
                                          SizedBox(width: width * 0.02),
                                          WordViewer(
                                            index: index + 1,
                                            randomIndexes: randomIndexes,
                                            selectedWords: selectedWords,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                Row(
                                  children: _isEven
                                      ? [
                                          WordViewer(
                                            index:
                                                UiConstants.wordsToVerify - 2,
                                            randomIndexes: randomIndexes,
                                            selectedWords: selectedWords,
                                          ),
                                          SizedBox(width: width * 0.02),
                                          WordViewer(
                                            index:
                                                UiConstants.wordsToVerify - 1,
                                            randomIndexes: randomIndexes,
                                            selectedWords: selectedWords,
                                          ),
                                        ]
                                      : [
                                          Spacer(flex: 1),
                                          WordViewer(
                                            index:
                                                UiConstants.wordsToVerify - 1,
                                            randomIndexes: randomIndexes,
                                            selectedWords: selectedWords,
                                            flex: 2,
                                          ),
                                          Spacer(flex: 1),
                                        ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: height * 0.05),
                          WordsViewer(
                            words: state.shuffledWords,
                            selectedWords: selectedWords,
                            onTapWord: (word) =>
                                bloc.add(SelectWord(word: word)),
                          ),
                          ErrorAlertBox(text: state.verificationError),
                          SizedBox(height: height * 0.05),
                          ElevatedButton(
                            onPressed: enabled
                                ? () => bloc.add(
                                      TapOnContinue(
                                        params: widget.params,
                                      ),
                                    )
                                : null,
                            style: AppButtonStyles.getBasicStyle(),
                            child: Container(
                              alignment: Alignment.center,
                              width: width,
                              child: Text(S.current.continue_),
                            ),
                          ),
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
