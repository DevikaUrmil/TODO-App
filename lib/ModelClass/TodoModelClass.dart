import 'package:hive/hive.dart';
part 'TodoModelClass.g.dart';

@HiveType(typeId: 0)
class TodoModelClass extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String status;

  @HiveField(4)
  final int time;

  TodoModelClass(this.id, this.title, this.description, this.status, this.time);
}


/*
import 'package:hive/hive.dart';
part 'TodoModelClass.g.dart';

@HiveType(typeId: 0)
class TodoModelClass extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? title;

  @HiveField(2)
  String? description;

  @HiveField(3)
  String? status;

  @HiveField(4)
  int? time;

  TodoModelClass({
    this.id,
    this.title,
    this.description,
    this.status,
    this.time,
  });

  TodoModelClass.fromJson(Map<String, dynamic> json) {
    id = json['name'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    time = json['time'];
  }
}
*/
