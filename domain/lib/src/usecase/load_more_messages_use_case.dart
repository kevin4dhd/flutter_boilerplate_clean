import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../../domain.dart';

part 'load_more_messages_use_case.freezed.dart';

@Injectable()
class LoadMoreMessagesUseCase
    extends BaseLoadMoreUseCase<LoadMoreMessagesInput, Message> {
  LoadMoreMessagesUseCase(this._repository) : super(initPage: 2);

  final Repository _repository;

  @protected
  @override
  Future<PagedList<Message>> buildUseCase(LoadMoreMessagesInput input) {
    return _repository.getLocalMessages(
      page: page,
      limit: PagingConstants.itemsPerPage,
    );
  }
}

@freezed
class LoadMoreMessagesInput extends BaseInput with _$LoadMoreMessagesInput {
  const factory LoadMoreMessagesInput() = _LoadMoreMessagesInput;
}
