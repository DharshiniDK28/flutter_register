import 'package:app2/data/models/register_model.dart';
import 'package:app2/data/repositories/register_repository.dart';
import 'package:app2/form_bloc/form_submission_status.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterRepository registerRepository;

  RegisterBloc({required this.registerRepository}) : super(const RegisterState()) {
    on<NameChanged>((event, emit) {
      emit(state.copyWith(name: event.name, formStatus: const FormEditing()));
    });

    on<EmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email, formStatus: const FormEditing()));
    });

    on<PhoneChanged>((event, emit) {
      emit(state.copyWith(phone: event.phone, formStatus: const FormEditing()));
    });

    on<DobChanged>((event, emit) {
      emit(state.copyWith(dob: event.dob, formStatus: const FormEditing()));
    });

    on<GenderChanged>((event, emit) {
      emit(state.copyWith(gender: event.gender, formStatus: const FormEditing()));
    });

    on<PasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password, formStatus: const FormEditing()));
    });

    on<AddressChanged>((event, emit) {
      emit(state.copyWith(address: event.address, formStatus: const FormEditing()));
    });

    on<StreetChanged>((event, emit) {
      emit(state.copyWith(street: event.street, formStatus: const FormEditing()));
    });

    on<StateChanged>((event, emit) {
      emit(state.copyWith(state: event.state, formStatus: const FormEditing()));
    });

    on<CountryChanged>((event, emit) {
      emit(state.copyWith(country: event.country, formStatus: const FormEditing()));
    });

    on<AboutChanged>((event, emit) {
      emit(state.copyWith(about: event.about, formStatus: const FormEditing()));
    });

    on<TermsChanged>((event, emit) {
      emit(state.copyWith(termsAccepted: event.terms, formStatus: const FormEditing()));
    });

    on<SubmitRegister>((event, emit) async {
      emit(state.copyWith(formStatus: const FormSubmitting()));

      try {
        final address = Address(
          street: state.street,
          state: state.state,
          country: state.country,
        );
        final registerRequest = RegisterRequestModel(
          name: state.name,
          email: state.email,
          phone: state.phone,
          dob: state.dob,
          gender: state.gender,
          password: state.password,
          address: state.address,
          about: state.about,
          terms: state.termsAccepted,
        );
        final success = await registerRepository.register(registerRequest);

        if (success) {
          emit(state.copyWith(formStatus: const SubmissionSuccess()));
        } else {
          emit(state.copyWith(formStatus: SubmissionFailed('Registration failed')));
        }
      } catch (e) {
        emit(state.copyWith(formStatus: SubmissionFailed(e.toString())));
      }
    });
  }
}
