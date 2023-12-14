import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:student_record/models/studentmodel.dart';
import 'package:student_record/service/database_service.dart';

class DataProvider extends ChangeNotifier {
  DatabaseService _databaseService = DatabaseService();
  String uniquename = DateTime.now().microsecondsSinceEpoch.toString();
  String downloadurl = '';

  Stream<QuerySnapshot> getStudents() {
    return _databaseService.studentref.snapshots();
  }

  imageUploader(image) async {
    Reference childfolder = _databaseService.root.child('images');
    Reference? imageUpload = childfolder.child("${uniquename}.jpg");
    try {
      await imageUpload.putFile(image);
      downloadurl = await imageUpload.getDownloadURL();
    } catch (e) {
      throw Exception(e);
    }
  }

  updateImage(imageurl, newimage) async {
    try {
      if (newimage != null && newimage.existsSync()) {
        Reference storedimage = FirebaseStorage.instance.refFromURL(imageurl);
        await storedimage.putFile(newimage);
        downloadurl = await storedimage.getDownloadURL();
      } else {
        downloadurl = imageurl;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  deleteImage(imageurl) async {
    Reference storedimage = FirebaseStorage.instance.refFromURL(imageurl);
    await storedimage.delete();
  }

  addStudent(StudentModel student) async {
    _databaseService.studentref.add(student);
    notifyListeners();
  }

  deleteStudent(id) async {
    _databaseService.studentref.doc(id).delete();
    notifyListeners();
  }

  updateStudent(id, StudentModel student) async {
    _databaseService.studentref.doc(id).update(student.toJson());
    notifyListeners();
  }
}
