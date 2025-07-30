import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_bloc_event.dart';

part 'splash_event.freezed.dart';

abstract class SplashEvent extends BaseBlocEvent {
  const SplashEvent();
}

@freezed
class SplashPageInitiated extends SplashEvent with _$SplashPageInitiated {
  const factory SplashPageInitiated() = _SplashPageInitiated;
}
