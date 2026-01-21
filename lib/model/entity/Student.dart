import 'package:floor/floor.dart';

@entity
class Student {
  @primaryKey
  final int? id;

  @ColumnInfo(name: 'name')
  final String name;

  @ColumnInfo(name: 'age')
  final int age;

  const Student({this.id, required this.name, required this.age});
}
