import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_record/controller/Basic_provider.dart';
import 'package:student_record/models/studentmodel.dart';
import 'package:student_record/service/database_service.dart';

class AddDialog extends StatelessWidget {
  AddDialog({
    super.key,
  });

  TextEditingController namecontroller = TextEditingController();

  TextEditingController agecontroller = TextEditingController();

  TextEditingController addresscontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final image = Provider.of<BasicProvider>(context);
    return Dialog(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Add Student',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 80),
                child: CircleAvatar(
                  backgroundImage: image.selectedimage != null
                      ? FileImage(image.selectedimage!)
                      : const AssetImage('assets/images/profile.png')
                          as ImageProvider,
                  radius: 60,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        image.imagePicker(source: ImageSource.camera);
                      },
                      child: const Text('Camera')),
                  const SizedBox(
                    width: 30,
                  ),
                  TextButton(
                      onPressed: () {
                        image.imagePicker(source: ImageSource.gallery);
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
              Consumer<BasicProvider>(
                builder: (context, basepro, child) {
                  return DropdownButton<String>(
                    value: basepro.selectedcourse,
                    items: basepro.courses.map((course) {
                      return DropdownMenuItem<String>(
                        child: Text(course),
                        value: course,
                      );
                    }).toList(),
                    onChanged: (value) {
                      basepro.dropDownchanger(value);
                    },
                  );
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
                        addStudent(context);
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
    );
  }

  addStudent(context) {
    final name = namecontroller.text;
    final age = agecontroller.text;
    final address = addresscontroller.text;
    final pro = Provider.of<BasicProvider>(context, listen: false);

    final student = StudentModel(
        address: address,
        name: name,
        age: age,
        course: pro.selectedcourse,
        image: pro.selectedimage!.path);

    DatabaseService().addStudent(student);
    Navigator.pop(context);
  }
}
