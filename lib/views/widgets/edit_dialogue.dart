import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_record/controller/Basic_provider.dart';
import 'package:student_record/controller/data_provider.dart';
import 'package:student_record/models/studentmodel.dart';
import 'package:student_record/service/database_service.dart';

class EditDialog extends StatefulWidget {
  StudentModel student;
  String id;
  EditDialog({super.key, required this.id, required this.student});

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  TextEditingController namecontroller = TextEditingController();

  TextEditingController agecontroller = TextEditingController();

  TextEditingController addresscontroller = TextEditingController();

  TextEditingController coursecontroller = TextEditingController();
  bool clicked = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    namecontroller = TextEditingController(text: widget.student.name);
    agecontroller = TextEditingController(text: widget.student.age);
    addresscontroller = TextEditingController(text: widget.student.address);
    coursecontroller = TextEditingController(text: widget.student.course);
    Provider.of<BasicProvider>(context, listen: false).selectedcourse =
        widget.student.course;
    Provider.of<BasicProvider>(context, listen: false).selectedimage =
        File(widget.student.image!);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Consumer<BasicProvider>(
            builder: (context, value, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Edit Student',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 80),
                  child: CircleAvatar(
                    backgroundImage: !clicked
                        ? FileImage(File(value.selectedimage!.path))
                        : NetworkImage(widget.student.image!) as ImageProvider,
                    radius: 60,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          value.imagePicker(source: ImageSource.camera);
                          clicked = !clicked;
                        },
                        child: const Text('Camera')),
                    const SizedBox(
                      width: 30,
                    ),
                    TextButton(
                        onPressed: () {
                          value.imagePicker(source: ImageSource.gallery);
                          clicked = !clicked;
                        },
                        child: const Text('Gallery')),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: namecontroller,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Name'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: addresscontroller,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Address'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: agecontroller,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Age'),
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButton<String>(
                  value: value.selectedcourse,
                  items: value.courses.map((course) {
                    return DropdownMenuItem<String>(
                      child: Text(course),
                      value: course,
                    );
                  }).toList(),
                  onChanged: (values) {
                    value.dropDownchanger(values);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          editStudent(context, widget.student.image);
                        },
                        child: const Text('Save')),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  editStudent(context, imageurl) async {
    final pro = Provider.of<BasicProvider>(context, listen: false);
    final prodata = Provider.of<DataProvider>(context, listen: false);
    final editedname = namecontroller.text;
    final editedage = agecontroller.text;
    final editedaddress = addresscontroller.text;
    final editedcourse = pro.selectedcourse;

    await prodata.updateImage(imageurl, File(pro.selectedimage!.path));
    final updatedstudent = StudentModel(
        image: prodata.downloadurl,
        address: editedaddress,
        name: editedname,
        age: editedage,
        course: editedcourse);

    prodata.updateStudent(widget.id, updatedstudent);
    Navigator.pop(context);
  }
}
