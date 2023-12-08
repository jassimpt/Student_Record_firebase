import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:student_record/models/studentmodel.dart';

const String todoref = "StudentData";

class DatabaseService {
  final firestore = FirebaseFirestore.instance;
  Reference root = FirebaseStorage.instance.ref();

  late final CollectionReference studentref;
  DatabaseService() {
    studentref = firestore.collection(todoref).withConverter<StudentModel>(
        fromFirestore: (snapshots, _) =>
            StudentModel.fromJson(snapshots.data()!),
        toFirestore: (student, _) => student.toJson());
  }
}
