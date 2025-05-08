import 'package:equatable/equatable.dart';

abstract class FormSubmissionStatus extends Equatable{
  const FormSubmissionStatus();

  @override
  List<Object?>get props=>[];
}
class InitialFormStatus extends FormSubmissionStatus{
   const InitialFormStatus();
}
class FormEditing extends FormSubmissionStatus{
   const FormEditing();
}
class FormLoading extends FormSubmissionStatus{
   const FormLoading();
}

class FormSubmitting extends FormSubmissionStatus{
    const FormSubmitting();
}

class SubmissionSuccess extends FormSubmissionStatus {
  final String message;

  const SubmissionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class SubmissionFailed extends  FormSubmissionStatus {
  final Object exception;

  const SubmissionFailed(this.exception);


  @override
  List<Object?> get props => [exception];
}
