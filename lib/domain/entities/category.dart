import 'package:only_subx_ui/utils/randoms.dart';

class Category {
  final String id;
  final String name;

  Category({required this.name}):id = Randoms.getUuid();
}
