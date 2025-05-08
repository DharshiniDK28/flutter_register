import 'package:app2/form_bloc/form_submission_status.dart';
import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String dob;
  final String gender;
  final String street;
  final String state;
  final String country;
  final String about;
  final String password;
  final String confirmPassword;
  final bool termsAccepted;
  final bool isNameValid;
  final bool isEmailValid;
  final bool isPhoneValid;
  final bool isDobValid;
  final bool isGenderValid;
  final bool isStreetValid;
  final bool isStateValid;
  final bool isCountryValid;
  final bool isAboutValid;
  final bool isPasswordValid;
  final bool isConfirmPasswordValid;
  final bool isTermsAccepted;
  final FormSubmissionStatus formStatus;

  const RegisterState({
    this.name = '',
    this.email = '',
    this.phone = '',
    this.dob = '',
    this.gender = '',
    this.street = '',
    this.state = '',
    this.country = '',
    this.about = '',
    this.password = '',
    this.confirmPassword = '',
    this.termsAccepted = false,
    this.isNameValid = true,
    this.isEmailValid = true,
    this.isPhoneValid = true,
    this.isDobValid = true,
    this.isGenderValid = true,
    this.isStreetValid = true,
    this.isStateValid = true,
    this.isCountryValid = true,
    this.isAboutValid = true,
    this.isPasswordValid = true,
    this.isConfirmPasswordValid = true,
    this.isTermsAccepted = false,
    this.formStatus = const InitialFormStatus(),
  });

  RegisterState copyWith({
    String? name,
    String? email,
    String? phone,
    String? dob,
    String? gender,
    String? street,
    String? state,
    String? country,
    String? about,
    String? password,
    String? confirmPassword,
    bool? termsAccepted,
    bool? isNameValid,
    bool? isEmailValid,
    bool? isPhoneValid,
    bool? isDobValid,
    bool? isGenderValid,
    bool? isStreetValid,
    bool? isStateValid,
    bool? isCountryValid,
    bool? isAboutValid,
    bool? isPasswordValid,
    bool? isConfirmPasswordValid,
    bool? isTermsAccepted,
    FormSubmissionStatus? formStatus,
  }) {
    return RegisterState(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      street: street ?? this.street,
      state: state ?? this.state,
      country: country ?? this.country,
      about: about ?? this.about,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      termsAccepted: termsAccepted ?? this.termsAccepted,
      isNameValid: isNameValid ?? this.isNameValid,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPhoneValid: isPhoneValid ?? this.isPhoneValid,
      isDobValid: isDobValid ?? this.isDobValid,
      isGenderValid: isGenderValid ?? this.isGenderValid,
      isStreetValid: isStreetValid ?? this.isStreetValid,
      isStateValid: isStateValid ?? this.isStateValid,
      isCountryValid: isCountryValid ?? this.isCountryValid,
      isAboutValid: isAboutValid ?? this.isAboutValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isConfirmPasswordValid: isConfirmPasswordValid ?? this.isConfirmPasswordValid,
      isTermsAccepted: isTermsAccepted ?? this.isTermsAccepted,
      formStatus: formStatus ?? this.formStatus,
    );
  }

  // Define the isFormValid getter
  bool get isFormValid {
    return isNameValid &&
        isEmailValid &&
        isPhoneValid &&
        isDobValid &&
        isGenderValid &&
        isStreetValid &&
        isStateValid &&
        isCountryValid &&
        isAboutValid &&
        isPasswordValid &&
        isConfirmPasswordValid &&
        isTermsAccepted;
  }

  @override
  List<Object> get props => [
    name,
    email,
    phone,
    dob,
    gender,
    street,
    state,
    country,
    about,
    password,
    confirmPassword,
    termsAccepted,
    isNameValid,
    isEmailValid,
    isPhoneValid,
    isDobValid,
    isGenderValid,
    isStreetValid,
    isStateValid,
    isCountryValid,
    isAboutValid,
    isPasswordValid,
    isConfirmPasswordValid,
    isTermsAccepted,
    formStatus,
  ];
}
