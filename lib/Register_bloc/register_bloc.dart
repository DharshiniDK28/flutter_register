import 'package:app2/data/models/register_model.dart';
import 'package:app2/data/repositories/register_repository.dart';
import 'package:app2/form_bloc/form_submission_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterRepository registerRepository;

  RegisterBloc({required this.registerRepository}) : super(const RegisterState()) {
    on<NameChanged>((event, emit) {
      emit(state.copyWith(
        name: event.name,
        isNameValid: event.name.isNotEmpty,
        formStatus: FormEditing(),
      ));
    });

    on<EmailChanged>((event, emit) {
      final emailValid = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(event.email);
      emit(state.copyWith(
        email: event.email,
        isEmailValid: emailValid,
        formStatus: FormEditing(),
      ));
    });

    on<PhoneChanged>((event, emit) {
      final phoneValid = RegExp(r'^\d{10}$').hasMatch(event.phone);
      emit(state.copyWith(
        phone: event.phone,
        isPhoneValid: phoneValid,
        formStatus: FormEditing(),
      ));
    });

    on<DobChanged>((event, emit) {
      emit(state.copyWith(
        dob: event.dob,
        isDobValid: event.dob.isNotEmpty,
        formStatus: FormEditing(),
      ));
    });

    on<GenderChanged>((event, emit) {
      emit(state.copyWith(
        gender: event.gender,
        isGenderValid: event.gender.isNotEmpty,
        formStatus: FormEditing(),
      ));
    });

    on<StreetChanged>((event, emit) {
      emit(state.copyWith(
        street: event.street,
        isStreetValid: event.street.isNotEmpty,
        formStatus: FormEditing(),
      ));
    });

    on<StateChanged>((event, emit) {
      emit(state.copyWith(
        state: event.state, // Avoid conflict with `state` keyword
        isStateValid: event.state.isNotEmpty,
        formStatus: FormEditing(),
      ));
    });

    on<CountryChanged>((event, emit) {
      emit(state.copyWith(
        country: event.country,
        isCountryValid: event.country.isNotEmpty,
        formStatus: FormEditing(),
      ));
    });

    on<AboutChanged>((event, emit) {
      emit(state.copyWith(
        about: event.about,
        isAboutValid: event.about.isNotEmpty && event.about.length <= 50,
        formStatus: FormEditing(),
      ));
    });

    on<PasswordChanged>((event, emit) {
      final validPassword = event.password.length >= 6;
      final confirmValid = event.password == state.confirmPassword;
      emit(state.copyWith(
        password: event.password,
        isPasswordValid: validPassword,
        isConfirmPasswordValid: confirmValid,
        formStatus: FormEditing(),
      ));
    });

    on<ConfirmPasswordChanged>((event, emit) {
      final confirmValid = state.password == event.confirmPassword;
      emit(state.copyWith(
        confirmPassword: event.confirmPassword,
        isConfirmPasswordValid: confirmValid,
        formStatus: FormEditing(),
      ));
    });

    on<TermsChanged>((event, emit) {
      emit(state.copyWith(
        termsAccepted: event.termsAccepted,
        isTermsAccepted: event.termsAccepted,
        formStatus: FormEditing(),
      ));
    });

    on<SubmitRegister>((event, emit) async {
      emit(state.copyWith(
          isNameValid: state.name.isNotEmpty,
          isEmailValid:RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(state.email),
          isPhoneValid: RegExp(r'^\d{10}$').hasMatch(state.phone),
          isDobValid: state.dob.isNotEmpty,
          isGenderValid: state.gender.isNotEmpty,
          isStreetValid: state.street.isNotEmpty,
          isStateValid: state.state.isNotEmpty,
          isCountryValid: state.country.isNotEmpty,
          isAboutValid: state.about.isNotEmpty && state.about.length <= 50,
          isPasswordValid: state.password.length >= 6,
          isConfirmPasswordValid: state.password == state.confirmPassword,
          isTermsAccepted: state.termsAccepted,
          formStatus: FormLoading()));

      final isValid = state.name.isNotEmpty &&
          RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(state.email) &&
          RegExp(r'^\d{10}$').hasMatch(state.phone) &&
          state.dob.isNotEmpty &&
          state.street.isNotEmpty &&
          state.state.isNotEmpty &&
          state.country.isNotEmpty &&
          state.gender.isNotEmpty &&
          state.about.isNotEmpty &&
          state.password.length >= 6 &&
          state.password == state.confirmPassword &&
          state.termsAccepted;

      if (isValid) {
        final address = Address(
          street: state.street,
          state: state.state,
          country: state.country,
        );

        final userData = RegisterRequestModel(
          name: state.name,
          email: state.email,
          phone: state.phone,
          dob: state.dob,
          gender: state.gender,
          password: state.password,
          confirmPassword: state.confirmPassword,
          address: address,
          about: state.about,
          terms: state.termsAccepted,
        );

        try {
          await registerRepository.register(userData);
          emit(state.copyWith(formStatus: SubmissionSuccess("Registration Successful")));
        } catch (e) {
          emit(state.copyWith(formStatus: SubmissionFailed("Server error: ${e.toString()}")));
        }
      } else {
        emit(state.copyWith(formStatus: SubmissionFailed("Please correct the errors")));
      }
    });
  }
}
