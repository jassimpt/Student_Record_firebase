import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_record/models/studentmodel.dart';
import 'package:student_record/service/database_service.dart';
import 'package:student_record/views/widgets/add_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DatabaseService databaseService = DatabaseService();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Record'),
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
                    return Center(
                      child: Text('Add Student'),
                    );
                  }
                  return ListView.builder(
                    itemCount: studentdata.length,
                    itemBuilder: (context, index) {
                      StudentModel student = studentdata[index].data();
                      print(student.name);
                      return Text(
                        student.address != null
                            ? student.address!
                            : 'No Address',
                        style: TextStyle(color: Colors.black, fontSize: 20),
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
