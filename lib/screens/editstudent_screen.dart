import 'package:flutter/material.dart';
import 'package:gestion_alumnos/model/entity/Student.dart';
import 'package:gestion_alumnos/provider/student_provider.dart';
import 'package:provider/provider.dart';

class FormEditStudent extends StatelessWidget {
  FormEditStudent(this.student, {super.key});

  final Student student;

  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<StudentProvider>(context);

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
            height: 270,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
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
                              Navigator.pop(
                                context,
                              ); // Importante cerrar el diálogo al terminar
                            },
                            child: const Text('Save'),
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
