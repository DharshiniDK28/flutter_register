part of 'register_bloc.dart';


class RegisterState extends Equatable{
  final String name;
  final String email;
  final String phone;
  final String dob;
  final String gender;
  final String password;
  final String address;
  final String street;
  final String state;
  final String country;
  final String about;
  final bool termsAccepted;
  final FormSubmissionStatus formStatus;

  const RegisterState({
    this.name='',
    this.email='',
    this.phone='',
    this.dob='',
    this.gender='',
    this.password='',
    this.address='',
    this.street='',
    this.state='',
    this.country='',
    this.about='',
    this.termsAccepted=false,
    this.formStatus=const InitialFormStatus(),
});
  RegisterState copyWith({
    String? name,
    String? email,
    String? phone,
    String? dob,
    String? gender,
    String? password,
    String? address,
    String? street,
    String? state,
    String? country,
    String? about,
    bool? termsAccepted,
    FormSubmissionStatus? formStatus,
}){
    return RegisterState(
      name: name?? this.name,
      email: email?? this.email,
      phone: phone?? this.phone,
      dob: dob?? this.dob,
      gender: gender?? this.gender,
      password: password?? this.password,
      address: address?? this.address,
      street: street?? this.street,
      state: state?? this.state,
      country: country?? this.country,
      about: about?? this.about,
      termsAccepted: termsAccepted?? this.termsAccepted,
      formStatus: formStatus?? this.formStatus,
    );
  }
  @override
  List<Object?>get props=>[
    name,
    email,
    phone,
    dob,
    gender,
    password,
    address,
    street,
    state,
    country,
    about,
    termsAccepted,
    formStatus,
  ];
}
