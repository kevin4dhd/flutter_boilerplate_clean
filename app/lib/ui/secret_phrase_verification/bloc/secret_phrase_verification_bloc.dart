import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:resources/resources.dart';
import 'package:shared/shared.dart';

import '../../../app.dart';
import 'secret_phrase_verification.dart';

@Injectable()
class SecretPhraseVerificationBloc extends BaseBloc<
    SecretPhraseVerificationEvent, SecretPhraseVerificationState> {
  SecretPhraseVerificationBloc()
      : super(const SecretPhraseVerificationState()) {
    on<PageInitiated>(
      _onPageInitiated,
      transformer: log(),
    );

    on<SelectWord>(
      _onSelectWord,
      transformer: log(),
    );

    on<TapOnContinue>(
      _onTapOnContinue,
      transformer: exhaustMap(),
    );
  }

  FutureOr<void> _onPageInitiated(
      PageInitiated event, Emitter<SecretPhraseVerificationState> emit) {
    return runBlocCatching(
      action: () async {
        final secretPhrase = event.secretPhrase;
        final words = secretPhrase.words;

        final shuffledWords = List<WordTuple>.generate(
          secretPhrase.length.words,
          (x) => WordTuple(index: x, word: words[x]),
        )..shuffle();

        final shuffledWords2 = List<WordTuple>.from(shuffledWords)..shuffle();
        final randomIndexes =
            shuffledWords2.take(UiConstants.wordsToVerify).toList();

        Log.d('words: ${words.join(', ')}');
        Log.d(
            'shuffledWords: ${shuffledWords.map((x) => '${x.index + 1}.${x.word}').join(', ')}');
        for (int i = 0; i < UiConstants.wordsToVerify; i++) {
          final tuple = randomIndexes[i];
          Log.d('word ${i + 1}: ${tuple.index + 1}.${tuple.word}');
        }

        emit(state.copyWith(
          shuffledWords: shuffledWords,
          randomIndexes: randomIndexes,
          isLoading: false,
        ));
      },
      handleLoading: false,
    );
  }

  FutureOr<void> _onSelectWord(
      SelectWord event, Emitter<SecretPhraseVerificationState> emit) {
    return runBlocCatching(
      action: () async {
        if (state.isProcessing) {
          return;
        }

        final word = event.word;
        final index = word.index;

        final selectedWords = List<WordTuple>.from(state.selectedWords);
        if (selectedWords.any((x) => x.index == index)) {
          selectedWords.removeWhere((x) => x.index == index);
        } else if (selectedWords.length < UiConstants.wordsToVerify) {
          selectedWords.add(word);
        }

        emit(state.copyWith(
          selectedWords: selectedWords,
          verificationError: '',
        ));
      },
      handleLoading: false,
    );
  }

  FutureOr<void> _onTapOnContinue(
      TapOnContinue event, Emitter<SecretPhraseVerificationState> emit) {
    return runBlocCatching(
      action: () async {
        emit(state.copyWith(
          isProcessing: true,
        ));

        String? verificationError;
        try {
          final selectedWords = state.selectedWords;
          final randomIndexes = state.randomIndexes;
          if (!SecretPhraseUtils.areSelectedWordsValid(
              selectedWords, randomIndexes)) {
            verificationError = S.current.sequenceMismatch;
          } else {
            await navigator.replaceAll([AppRouteInfo.registerUserInfo()]);
          }
        } on String catch (error) {
          navigator.showErrorSnackBar(error);
        } catch (error) {
          Log.e(error);
          navigator.showErrorSnackBar(S.current.somethingWrong);
        }

        emit(state.copyWith(
          verificationError: verificationError ?? '',
          isProcessing: false,
        ));
      },
      handleLoading: false,
    );
  }
}
