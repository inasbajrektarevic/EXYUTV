import 'base.dart';

class AppUser {
  late int id;
  late String firstName;
  late String lastName;
  late bool isActive;
  late String userName;
  late String email;
  late String phoneNumber;
  late DateTime birthDate;
  late String address;

  AppUser();

  AppUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    isActive = json['isActive'];
    userName = json['userName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    birthDate = DateTime.parse(json['birthDate']);
    address = json['address'];
  }
}
