import 'package:intl/intl.dart';

class RegistrationModel {
  late int id;
  late String firstName;
  late String lastName;
  late String userName;
  late String createdAt;
  late String phoneNumber;
  late int gender;
  late String email;
  late DateTime birthDate;
  late String address;
  RegistrationModel();

  RegistrationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    gender = json['gender'];
    // birthDate =
    //     DateFormat('dd.MM.yyyy').format(DateTime.parse(json['birthDate']));
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['gender'] = gender;
    data['userName'] = userName;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['birthDate'] = DateFormat('yyyy-MM-ddTHH:mm:ss').format(birthDate);
    data['address'] = address;
    data['isClient'] = true;
    return data;
  }
}
