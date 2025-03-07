import 'application.dart';
import 'device.dart';

class DailyPackageRequest {
  late int id;
  late String firstName;
  late String lastName;
  late String email;
  late String phoneNumber;
  late int status;
  late DateTime dateFrom;
  late DateTime dateTo;
  late int deviceId;
  late Device device;
  late int applicationId;
  late Application application;

  DailyPackageRequest();

  DailyPackageRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    status = json['status'];
    dateFrom= DateTime.parse(json['dateTimeFrom']);
    dateTo= DateTime.parse(json['dateTimeTo']);
    deviceId = json['deviceId'];
    if (json['device'] != null) {
      device = Device.fromJson(json['device']);
    }
    applicationId = json['applicationId'];

    if (json['application'] != null) {
      application = Application.fromJson(json['application']);
    }
  }
}
