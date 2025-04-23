import 'package:equatable/equatable.dart';
import 'package:app2/data/models/statistics_model.dart';
import 'package:app2/form_bloc/data_fetch.dart';

class StatisticsState extends Equatable {
  final StatisticsModel? fetchedData;
  final DataFetch formSubmissionStatus;

  const StatisticsState({
    this.fetchedData,
    this.formSubmissionStatus = const DataFetchedLoading(),
  });

  StatisticsState copyWith({
    StatisticsModel? fetchedData,
    DataFetch? formSubmissionStatus,
  }) {
    return StatisticsState(
      fetchedData: fetchedData ?? this.fetchedData,
      formSubmissionStatus: formSubmissionStatus ?? this.formSubmissionStatus,
    );
  }

  @override
  List<Object?> get props => [fetchedData, formSubmissionStatus];
}
