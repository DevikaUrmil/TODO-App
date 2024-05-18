import 'package:hive/hive.dart';
part 'TodoModelClass.g.dart';

@HiveType(typeId: 0)
class TodoModelClass extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  String status;

  @HiveField(4)
  int time;

  TodoModelClass(this.id, this.title, this.description, this.status, this.time);
}
