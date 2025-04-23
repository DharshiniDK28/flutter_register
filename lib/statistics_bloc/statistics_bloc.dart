import 'package:app2/data/repositories/statistics_repository.dart';
import 'package:app2/form_bloc/data_fetch.dart';
import 'package:app2/statistics_bloc/statistics_event.dart';
import 'package:app2/statistics_bloc/statistics_state.dart';
import 'package:bloc/bloc.dart';


class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  final StatisticRepository statisticsRepo;

  StatisticsBloc({required this.statisticsRepo}) : super(const StatisticsState()) {
    on<StaticPageLoad>(_onStaticPageLoad);
    on<StatisticDataFetch>(_onStatisticDataFetch);
  }

  Future<void> _onStaticPageLoad(
      StaticPageLoad event, Emitter<StatisticsState> emit) async {
    emit(state.copyWith(formSubmissionStatus: const DataFetchedLoading()));
    print("Global Bloc");
    try {
      print("Local Bloc before");
      final data = await statisticsRepo.getData();
      print("Local Bloc");
      emit(state.copyWith(
        fetchedData: data,
        formSubmissionStatus: const DataFetched(),
      ));
    } catch (e) {
      emit(state.copyWith(
        formSubmissionStatus: const DataFetchedFailed(),
      ));
    }
  }

  void _onStatisticDataFetch(
      StatisticDataFetch event, Emitter<StatisticsState> emit) {
    emit(state.copyWith(
      fetchedData: event.fetchedData,
      formSubmissionStatus: const DataFetched(),
    ));
  }
}