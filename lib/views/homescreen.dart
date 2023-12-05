import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:student_record/models/studentmodel.dart';
import 'package:student_record/service/database_service.dart';
import 'package:student_record/views/widgets/add_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_record/views/widgets/edit_dialogue.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DatabaseService databaseService = DatabaseService();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Student Record',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AddDialog();
              },
            );
          },
          child: const Icon(Icons.add)),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              child: StreamBuilder(
                stream: databaseService.getStudents(),
                builder: (context, snapshot) {
                  List studentdata = snapshot.data?.docs ?? [];
                  if (studentdata.isEmpty) {
                    return const Center(
                      child: Text('Add Student'),
                    );
                  }
                  return ListView.builder(
                    itemCount: studentdata.length,
                    itemBuilder: (context, index) {
                      StudentModel student = studentdata[index].data();
                      final id = studentdata[index].id;
                      print(student.name);
                      return ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: FileImage(File(student.image!)),
                        ),
                        title: Text(student.name!),
                        subtitle: Text(student.age!),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return EditDialog(
                                        id: id,
                                        student: student,
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(Iconsax.edit)),
                            IconButton(
                                onPressed: () {
                                  databaseService.deleteStudent(id);
                                },
                                icon: const Icon(Iconsax.profile_delete)),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
