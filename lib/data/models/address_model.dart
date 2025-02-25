import 'package:logic_app/core/utils/app_format.dart';

class AddressModel {
  final String id;
  final String type;
  final String phoneNumber;
  final String address;
  final String address2;
  final String city;
  final String stateNo;
  final String homeNo;
  final String country;
  final String postalCode;
  final String notes;
  final String latitude;
  final String longitude;
  final bool isDefault;

  AddressModel({
    required this.id,
    required this.type,
    required this.phoneNumber,
    required this.address,
    required this.address2,
    required this.city,
    required this.stateNo,
    required this.homeNo,
    required this.country,
    required this.postalCode,
    required this.notes,
    required this.latitude,
    required this.longitude,
    required this.isDefault,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: AppFormat.toStr(json['id']),
      type: AppFormat.toStr(json['type']),
      phoneNumber: AppFormat.toStr(json['phone_number']),
      address: AppFormat.toStr(json['address']),
      address2: AppFormat.toStr(json['address_2']),
      city: AppFormat.toStr(json['city']),
      stateNo: AppFormat.toStr(json['state_no']),
      homeNo: AppFormat.toStr(json['home_no']),
      country: AppFormat.toStr(json['country']),
      postalCode: AppFormat.toStr(json['postal_code']),
      notes: AppFormat.toStr(json['notes']),
      latitude: AppFormat.toStr(json['latitude']),
      longitude: AppFormat.toStr(json['longitude']),
      isDefault: json['is_default'] ?? false,
    );
  }
}
