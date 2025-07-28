import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../../../../../data.dart';

@Injectable()
class LocalMessageDataMapper extends BaseDataMapper<LocalMessageData, Message>
    with DataMapperMixin {
  @override
  Message mapToEntity(LocalMessageData? data) {
    return Message(
      id: data?.id ?? 0,
      text: data?.text ?? '',
      createdAt: data?.createdAt != null
          ? DateTime.fromMillisecondsSinceEpoch(data!.createdAt!)
          : Message.defaultCreatedAt,
    );
  }

  @override
  LocalMessageData mapToData(Message entity) {
    return LocalMessageData(
      id: entity.id,
      text: entity.text,
      createdAt: entity.createdAt?.millisecondsSinceEpoch,
    );
  }
}
