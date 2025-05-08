// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequestModel _$RegisterRequestModelFromJson(
  Map<String, dynamic> json,
) => RegisterRequestModel(
  name: json['name'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String,
  dob: json['dob'] as String,
  gender: json['gender'] as String,
  password: json['password'] as String,
  confirmPassword: json['confirmPassword'] as String,
  address: Address.fromJson(json['address'] as Map<String, dynamic>),
  about: json['about'] as String,
  terms: json['terms'] as bool,
);

Map<String, dynamic> _$RegisterRequestModelToJson(
  RegisterRequestModel instance,
) => <String, dynamic>{
  'name': instance.name,
  'email': instance.email,
  'phone': instance.phone,
  'dob': instance.dob,
  'gender': instance.gender,
  'password': instance.password,
  'confirmPassword': instance.confirmPassword,
  'address': instance.address,
  'about': instance.about,
  'terms': instance.terms,
};

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
  street: json['street'] as String,
  state: json['state'] as String,
  country: json['country'] as String,
);

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
  'street': instance.street,
  'state': instance.state,
  'country': instance.country,
};
