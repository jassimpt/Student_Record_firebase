import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BasicProvider extends ChangeNotifier {
  File? selectedimage;
  List courses = ["Bca", "BBA", "Bcom", "Ec", 'BcomTT', "Multimedia"];

  String? selectedcourse = "Bca";
  imagePicker({required source}) async {
    final returnedimage = await ImagePicker().pickImage(source: source);
    selectedimage = File(returnedimage!.path);
    notifyListeners();
  }

  dropDownchanger(value) {
    if (value != null) {
      selectedcourse = value;
      notifyListeners();
    }
  }
}
