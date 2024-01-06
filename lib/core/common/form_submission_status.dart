abstract class FormSubmissionStatus {
  const FormSubmissionStatus();
}

class FormInitialStatus extends FormSubmissionStatus {
  const FormInitialStatus();
}

class FormSubmitting extends FormSubmissionStatus {}

class FormSubmissionSuccess<T> extends FormSubmissionStatus {
  final String? message;
  final T? data;

  FormSubmissionSuccess({this.message, this.data});
}

class FormSubmissionFailed extends FormSubmissionStatus {
  final String? message;

  FormSubmissionFailed({this.message});
}
