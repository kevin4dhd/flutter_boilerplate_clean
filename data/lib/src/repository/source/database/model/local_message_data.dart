import 'package:objectbox/objectbox.dart';

@Entity()
class LocalMessageData {
  LocalMessageData({this.id = 0, this.text});

  @Id()
  int id;
  String? text;
}
