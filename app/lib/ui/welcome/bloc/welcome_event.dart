import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_bloc_event.dart';

part 'welcome_event.freezed.dart';

abstract class WelcomeEvent extends BaseBlocEvent {
  const WelcomeEvent();
}

@freezed
class ClickOnContinue extends WelcomeEvent with _$ClickOnContinue {
  const factory ClickOnContinue() = _ClickOnContinue;
}

@freezed
class ClickOnTerms extends WelcomeEvent with _$ClickOnTerms {
  const factory ClickOnTerms() = _ClickOnTerms;
}

@freezed
class ClickOnPrivacity extends WelcomeEvent with _$ClickOnPrivacity {
  const factory ClickOnPrivacity() = _ClickOnPrivacity;
}
