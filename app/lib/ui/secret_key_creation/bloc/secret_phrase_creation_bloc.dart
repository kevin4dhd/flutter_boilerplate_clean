import 'dart:async';

import 'package:bip39_mnemonic/bip39_mnemonic.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../../app.dart';
import 'secret_phrase_creation.dart';

@Injectable()
class SecretPhraseCreationBloc
    extends BaseBloc<SecretPhraseCreationEvent, SecretPhraseCreationState> {
  SecretPhraseCreationBloc() : super(const SecretPhraseCreationState()) {
    on<GenerateSecretPhrase>(
      _onGenerateSecretPhrase,
      transformer: log(),
    );

    on<SetCheck1>(
      _onSetCheck1,
      transformer: log(),
    );

    on<SetCheck2>(
      _onSetCheck2,
      transformer: exhaustMap(),
    );

    on<TapOnContinue>(
      _onTapOnContinue,
      transformer: log(),
    );
  }

  FutureOr<void> _onGenerateSecretPhrase(
      GenerateSecretPhrase event, Emitter<SecretPhraseCreationState> emit) {
    return runBlocCatching(
      action: () async {
        emit(state.copyWith(
          isProcessing: true,
        ));

        Mnemonic? secretPhrase;
        try {
          secretPhrase = SecretPhraseUtils.generate();
        } catch (error) {
          Log.e(error);
          secretPhrase = null;
          navigator.showErrorSnackBar('error_generating_secret_phrase');
        }

        emit(state.copyWith(
          secretPhrase: secretPhrase,
          isProcessing: false,
        ));
      },
      handleLoading: false,
    );
  }

  void _onSetCheck1(SetCheck1 event, Emitter<SecretPhraseCreationState> emit) {
    emit(state.copyWith(
      isCheck1: event.isCheck1,
    ));
  }

  void _onSetCheck2(SetCheck2 event, Emitter<SecretPhraseCreationState> emit) {
    emit(state.copyWith(
      isCheck2: event.isCheck2,
    ));
  }

  FutureOr<void> _onTapOnContinue(
      TapOnContinue event, Emitter<SecretPhraseCreationState> emit) {
    return runBlocCatching(
      action: () async => await navigator.push(
        AppRouteInfo.secretPhraseVerification(
          (
            passCodeSettings: event.passCodeSettings,
            secretPhrase: state.secretPhrase!,
          ),
        ),
      ),
      handleLoading: false,
    );
  }
}
