import 'package:foxShop/core/utils/app_format.dart';

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

  // CopyWith method
  AddressModel copyWith({
    String? id,
    String? type,
    String? phoneNumber,
    String? address,
    String? address2,
    String? city,
    String? stateNo,
    String? homeNo,
    String? country,
    String? postalCode,
    String? notes,
    String? latitude,
    String? longitude,
    bool? isDefault,
  }) {
    return AddressModel(
      id: id ?? this.id,
      type: type ?? this.type,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      address2: address2 ?? this.address2,
      city: city ?? this.city,
      stateNo: stateNo ?? this.stateNo,
      homeNo: homeNo ?? this.homeNo,
      country: country ?? this.country,
      postalCode: postalCode ?? this.postalCode,
      notes: notes ?? this.notes,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}
