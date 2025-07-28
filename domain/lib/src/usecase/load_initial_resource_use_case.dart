import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain.dart';

part 'load_initial_resource_use_case.freezed.dart';

@Injectable()
class LoadInitialResourceUseCase extends BaseSyncUseCase<
    LoadInitialResourceInput, LoadInitialResourceOutput> {
  const LoadInitialResourceUseCase();

  @protected
  @override
  LoadInitialResourceOutput buildUseCase(LoadInitialResourceInput input) {
    return const LoadInitialResourceOutput(
      initialRoutes: [InitialAppRoute.splash],
    );
  }
}

@freezed
class LoadInitialResourceInput extends BaseInput
    with _$LoadInitialResourceInput {
  const factory LoadInitialResourceInput() = _LoadInitialResourceInput;
}

@freezed
class LoadInitialResourceOutput extends BaseOutput
    with _$LoadInitialResourceOutput {
  const LoadInitialResourceOutput._();

  const factory LoadInitialResourceOutput({
    @Default([InitialAppRoute.splash]) List<InitialAppRoute> initialRoutes,
  }) = _LoadInitialResourceOutput;
}
