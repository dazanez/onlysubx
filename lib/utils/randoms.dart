import 'package:uuid/uuid.dart';

class Randoms {
  static String getUuid() {
    return const Uuid().v4();
  }
}
