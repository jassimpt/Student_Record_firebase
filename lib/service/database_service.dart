import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_record/models/studentmodel.dart';

const String todoref = "StudentData";

class DatabaseService {
  final firestore = FirebaseFirestore.instance;
  late final CollectionReference studentref;
  DatabaseService() {
    studentref = firestore.collection(todoref).withConverter<StudentModel>(
        fromFirestore: (snapshots, _) =>
            StudentModel.fromJson(snapshots.data()!),
        toFirestore: (student, _) => student.toJson());
  }

  Stream<QuerySnapshot> getStudents() {
    return studentref.snapshots();
  }

  addStudent(StudentModel student) async {
    studentref.add(student);
  }

  deleteStudent(id) async {
    studentref.doc(id).delete();
  }

  updateStudent(id, StudentModel student) async {
    studentref.doc(id).update(student.toJson());
  }
}
