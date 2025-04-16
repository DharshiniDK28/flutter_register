import 'package:json_annotation/json_annotation.dart';

part 'register_model.g.dart';

@JsonSerializable()
class RegisterRequestModel{
  @JsonKey(name:'name')
  final String name;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'phone')
  final String phone;
  @JsonKey(name: 'dob')
  final String dob;
  @JsonKey(name: 'gender')
  final String gender;
  @JsonKey(name: 'password')
  final String password;
  @JsonKey(name: 'address')
  final String address;
  @JsonKey(name: 'about')
  final String about;
  @JsonKey(name: 'terms')
  final bool terms;


  RegisterRequestModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.dob,
    required this.gender,
    required this.password,
    required this.address,
    required this.about,
    required this.terms

});
  factory RegisterRequestModel.fromJson(Map<String,dynamic>json)=>_$RegisterRequestModelFromJson(json);

  Map<String,dynamic>toJson()=>_$RegisterRequestModelToJson(this);
}

@JsonSerializable()
class Address {
  final String street;
  final String state;
  final String country;

  Address({
    required this.street,
    required this.state,
    required this.country
  });

  factory Address.fromJson(Map<String, dynamic>json)=> _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}