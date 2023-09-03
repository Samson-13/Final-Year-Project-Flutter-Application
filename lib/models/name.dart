class HotelModel {
  late String name;
  late String age;
  late String gender;

  HotelModel({
    required this.name,
    required this.age,
    required this.gender,
  });

  HotelModel.fromMap(Map<String, dynamic> json) {
    name = json['name'];
    age = json['age'];
    gender = json['gender'];
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "age": age,
      "gender": gender,
    };
  }
}
