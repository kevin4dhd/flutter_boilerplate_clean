import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../../domain.dart';

part 'get_messages_use_case.freezed.dart';

@Injectable()
class GetMessagesUseCase
    extends BaseLoadMoreUseCase<GetMessagesInput, Message> {
  GetMessagesUseCase(this._repository)
      : super(initPage: PagingConstants.initialPage);

  final Repository _repository;

  @protected
  @override
  Future<PagedList<Message>> buildUseCase(GetMessagesInput input) {
    return _repository.getLocalMessages(
      page: page,
      limit: PagingConstants.itemsPerPage,
    );
  }
}

@freezed
class GetMessagesInput extends BaseInput with _$GetMessagesInput {
  const factory GetMessagesInput() = _GetMessagesInput;
}
