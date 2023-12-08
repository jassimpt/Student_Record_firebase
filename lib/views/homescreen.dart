import 'dart:io';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:student_record/controller/data_provider.dart';
import 'package:student_record/models/studentmodel.dart';

import 'package:student_record/views/widgets/add_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_record/views/widgets/edit_dialogue.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            Expanded(
              child: SizedBox(
                child: Consumer<DataProvider>(
                  builder: (context, value, child) {
                    return StreamBuilder(
                      stream: value.getStudents(),
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

                            return ListTile(
                              leading: CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      NetworkImage(student.image!)),
                              title: Text(student.name!),
                              subtitle: Text(student.course!),
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
                                        value.deleteStudent(id);
                                      },
                                      icon: const Icon(Iconsax.profile_delete)),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
