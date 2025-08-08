import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_bloc_event.dart';

part 'splash_event.freezed.dart';

abstract class SplashEvent extends BaseBlocEvent {
  const SplashEvent();
}

@freezed
class PageInitiated extends SplashEvent with _$PageInitiated {
  const factory PageInitiated() = _PageInitiated;
}
