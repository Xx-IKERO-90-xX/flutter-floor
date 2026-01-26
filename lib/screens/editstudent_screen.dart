import 'package:flutter/material.dart';
import 'package:gestion_alumnos/model/entity/Student.dart';
import 'package:gestion_alumnos/provider/student_provider.dart';
import 'package:provider/provider.dart';
import 'package:gestion_alumnos/screens/students_screen.dart';

class FormEditStudent extends StatelessWidget {
  FormEditStudent(this.student, {super.key});

  final Student student;

  get context => null;

  void _showConfirm(StudentProvider appProvider, BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Do you want to keep editing?'),
        content: Row(
          children: [
            TextButton(
              onPressed: () => {Navigator.pop(context)},
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StudentsScreen()),
              ),
              child: const Text('No'),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirm(StudentProvider appProvider, BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Are you sure that you want to delete this Student?'),
        content: Row(
          children: [
            TextButton(
              onPressed: () => {appProvider.deleteStudentById(student.id!)},
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('No'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<StudentProvider>(context);

    const defaultAvatar =
        "https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png?20200919003010";

    Student student = this.student;

    final _formKey = GlobalKey<FormState>();
    final nameController = TextEditingController(text: student.name);
    final ageController = TextEditingController(text: student.age.toString());
    final imgController = TextEditingController(text: student.imgUrl);

    return Scaffold(
      appBar: AppBar(title: const Text('Student Database')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: 490,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Image.network(
                        student.imgUrl ?? defaultAvatar,
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: nameController,
                        // initialValue: name, <-- ELIMINADO PARA EVITAR EL ERROR
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          hintText: 'Enter student name',
                        ),
                        textCapitalization: TextCapitalization.words,
                        autofocus: true,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: ageController,
                        // initialValue: '$age', <-- ELIMINADO PARA EVITAR EL ERROR
                        decoration: const InputDecoration(
                          labelText: 'Age',
                          hintText: 'Enter student age',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: imgController,
                        decoration: const InputDecoration(
                          labelText: 'Image Url',
                          hintText: 'Enter image url',
                        ),
                        textCapitalization: TextCapitalization.words,
                        autofocus: true,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () async {
                              // ... resto de tu lógica de guardado
                              if (nameController.text.isEmpty ||
                                  ageController.text.isEmpty) {
                                SnackBar(
                                  content: const Text(
                                    'Hay campos vacíos, rellenalos!!',
                                  ),
                                );
                                return;
                              }

                              int? ageInput = int.tryParse(ageController.text);
                              if (ageInput == null || ageInput <= 0) {
                                // SnackBar...
                                return;
                              }

                              Student newStudent = student.copyWith(
                                name: nameController.text,
                                age: ageInput,
                                imgUrl: imgController.text,
                              );

                              await appProvider.updateStudent(newStudent);
                              _showConfirm(appProvider, context);
                            },
                            child: const Text('Save'),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () async {
                              _showDeleteConfirm(appProvider, context);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
