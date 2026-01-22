import 'package:gestion_alumnos/model/entity/Student.dart';
import 'package:gestion_alumnos/model/dao/StudentDao.dart';
import 'package:gestion_alumnos/connection/app_database.dart';

class StudentRepository {
  AppDatabase? _database;
  StudentDao? _dao;

  StudentRepository._();

  // Instancia única del repositorio. La podemos crear directamente
  // en la inicialización
  static final StudentRepository _instance = StudentRepository._();

  // Cuando se nos pida el repositorio, se devuelve la instancia única.
  factory StudentRepository() {
    return _instance;
  }

  // Connexión a la base de datos
  Future<void> connectDB() async {
    // Creamos la BD únicamentes si no se ha creado ya
    _database ??= await $FloorAppDatabase
        .databaseBuilder('app_database.db')
        .build();

    // Creamos el DAO
    _dao = _database?.studentDao;
  }

  Stream<List<Student>> streamAllStudents() {
    return _dao?.streamAllStudents() ?? const Stream.empty();
  }

  Future<List<Student>> getAllStudents() {
    return _dao?.getAllStudents() ?? Future.value([]);
  }

  Future<void> insertStudent(Student student) {
    return _dao?.insertStudent(student) ?? Future.value();
  }

  Future<void> deleteStudentById(int id) {
    return _dao?.deleteStudentById(id) ?? Future.value();
  }

  Future<void> updateStudent(Student student) {
    return _dao?.updateStudent(student) ?? Future.value();
  }
}
