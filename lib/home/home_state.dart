import 'package:app2/form_bloc/form_submission_status.dart';
import 'package:equatable/equatable.dart';


class HomeState extends Equatable {
  final String selectedCountry;
  final int currentIndex;
  final FormSubmissionStatus formStatus;

  const HomeState({
    this.selectedCountry = 'USA',
    this.currentIndex = 0,
    this.formStatus = const InitialFormStatus(),
  });

  HomeState copyWith({
    String? selectedCountry,
    int? pageIndex,
    FormSubmissionStatus? formStatus,
  }) {
    return HomeState(
      selectedCountry: selectedCountry ?? this.selectedCountry,
      currentIndex: pageIndex ?? this.currentIndex,
      formStatus: formStatus ?? this.formStatus,
    );
  }

  @override
  List<Object?> get props => [selectedCountry, currentIndex, formStatus];
}