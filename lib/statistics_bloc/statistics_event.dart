import 'package:app2/data/models/statistics_model.dart';
import 'package:equatable/equatable.dart';

abstract class StatisticsEvent extends Equatable {
  const StatisticsEvent();

  @override
  List<Object?> get props => [];

  get fetchedData => null;
}

class StaticPageLoad extends StatisticsEvent {}

class StatisticDataFetch extends StatisticsEvent {
  final StatisticsModel fetchedData;

  const StatisticDataFetch({required this.fetchedData});

  @override
  List<Object?> get props => [fetchedData];
}