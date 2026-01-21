import 'package:flutter/foundation.dart';
import 'package:gestion_alumnos/model/entity/Student.dart';
import 'package:gestion_alumnos/repository/student_repository.dart';

class StudentProvider with ChangeNotifier {
  final StudentRepository _studentRepository = StudentRepository();

  List<Student>? _students;

  StudentProvider() {
    _loadDatabase();
  }

  Future<void> _loadDatabase() async {
    // Esperamos a tener una conexion lista a la BD.
    await _studentRepository.connectDB();
    notifyListeners();
  }

  get listStudents {
    _getAllStudentsAsync();

    return _students;
  }

  void _getAllStudentsAsync() async {
    await Future.delayed(const Duration(seconds: 5));
    _students = await getAllStudents();
    notifyListeners();
  }

  Stream<List<Student>>? streamAllStudents() {
    return _studentRepository.streamAllStudents();
  }

  Future<List<Student>> getAllStudents() {
    return _studentRepository.getAllStudents();
  }

  Future<void> insertStudent(Student student) async {
    await _studentRepository.insertStudent(student);
    notifyListeners();
  }

  Future<void> deleteStudentById(int id) async {
    await _studentRepository.deleteStudentById(id);
    notifyListeners();
  }
}
