import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

// Field value change events
class NameChanged extends RegisterEvent {
  final String name;
  const NameChanged(this.name);

  @override
  List<Object> get props => [name];
}

class EmailChanged extends RegisterEvent {
  final String email;
  const EmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class PhoneChanged extends RegisterEvent {
  final String phone;
  const PhoneChanged(this.phone);

  @override
  List<Object> get props => [phone];
}

class DobChanged extends RegisterEvent {
  final String dob;
  const DobChanged(this.dob);

  @override
  List<Object> get props => [dob];
}

class GenderChanged extends RegisterEvent {
  final String gender;
  const GenderChanged(this.gender);

  @override
  List<Object> get props => [gender];
}

class StreetChanged extends RegisterEvent {
  final String street;
  const StreetChanged(this.street);

  @override
  List<Object> get props => [street];
}

class StateChanged extends RegisterEvent {
  final String state;
  const StateChanged(this.state);

  @override
  List<Object> get props => [state];
}

class CountryChanged extends RegisterEvent {
  final String country;
  const CountryChanged(this.country);

  @override
  List<Object> get props => [country];
}

class AboutChanged extends RegisterEvent {
  final String about;
  const AboutChanged(this.about);

  @override
  List<Object> get props => [about];
}

class PasswordChanged extends RegisterEvent {
  final String password;
  const PasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class ConfirmPasswordChanged extends RegisterEvent {
  final String confirmPassword;
  const ConfirmPasswordChanged(this.confirmPassword);

  @override
  List<Object> get props => [confirmPassword];
}


// Checkbox event
class TermsChanged extends RegisterEvent {
  final bool termsAccepted;  // Changed from String to bool
  const TermsChanged(this.termsAccepted);

  @override
  List<Object> get props => [termsAccepted];
}

// Submit form
class SubmitRegister extends RegisterEvent {
  const SubmitRegister();

  @override
  List<Object> get props => [];
}
