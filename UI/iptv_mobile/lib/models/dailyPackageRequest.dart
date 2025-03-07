import 'package:intl/intl.dart';

class DailyPackageRequest {
  late int id;
  late String firstName;
  late String lastName;
  late String phoneNumber;
  late int status;
  late String email;
  late DateTime dateTimeFrom;
  late DateTime dateTimeTo;
  late int deviceId;
  late int applicationId;
  DailyPackageRequest();

  DailyPackageRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phoneNumber = json['phoneNumber'];
    status = json['status'];
    email = json['email'];
    dateTimeFrom = json['dateTimeFrom'];
    dateTimeTo = json['dateTimeTo'];
    deviceId = json['deviceId'];
    applicationId = json['applicationId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['phoneNumber'] = phoneNumber;
    data['status'] = 0;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['deviceId'] = deviceId;
    data['applicationId'] = applicationId;
    return data;
  }
}
