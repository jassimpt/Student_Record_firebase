class StudentModel {
  String? name;
  String? address;
  String? course;
  String? age;
  StudentModel({
    required this.address,
    required this.name,
    required this.age,
    required this.course,
  });

  StudentModel.fromJson(Map<String, dynamic> json) {
    StudentModel(
        address: json['address'],
        name: json["name"],
        age: json['age'] as String,
        course: json['course']);
  }

  StudentModel copyWith(
      {String? name, String? address, String? course, String? age}) {
    return StudentModel(
        address: address ?? this.address,
        name: name ?? this.name,
        age: age ?? this.age,
        course: course ?? this.course);
  }

  Map<String, dynamic> toJson() {
    return {"name": name, "address": address, "age": age, "course": course};
  }
}
