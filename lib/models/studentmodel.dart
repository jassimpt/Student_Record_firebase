class StudentModel {
  String? name;
  String? address;
  String? course;
  String? age;
  String? image;
  String? id;
  StudentModel({
    required this.image,
    required this.address,
    required this.name,
    required this.age,
    required this.course,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
        image: json["image"],
        address: json['address'],
        name: json["name"],
        age: json['age'] as String,
        course: json['course']);
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "address": address,
      "age": age,
      "course": course,
      "image": image
    };
  }
}
