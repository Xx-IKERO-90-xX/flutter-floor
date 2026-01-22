import 'package:floor/floor.dart';

@entity
class Student {
  @primaryKey
  final int? id;

  @ColumnInfo(name: 'name')
  final String name;

  @ColumnInfo(name: 'age')
  final int age;

  @ColumnInfo(name: 'imgUrl')
  final String? imgUrl;

  const Student({this.id, required this.name, required this.age, this.imgUrl});

  Student copyWith({int? id, String? name, int? age, String? imgUrl}) {
    return Student(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      imgUrl: imgUrl ?? this.imgUrl,
    );
  }
}
