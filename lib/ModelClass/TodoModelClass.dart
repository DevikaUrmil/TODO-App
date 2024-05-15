import 'package:hive/hive.dart';
part 'TodoModelClass.g.dart';

@HiveType(typeId: 0)
class TodoModelClass extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final String status;

  @HiveField(3)
  final int time;
  TodoModelClass(this.title, this.description, this.status, this.time);
}
