import 'package:json_annotation/json_annotation.dart';

part 'statistics_model.g.dart';

@JsonSerializable()
class StatisticsModel {
  @JsonKey(name: 'confirmedCasesIndian', defaultValue: 0)
  final int affected;

  @JsonKey(name: 'deaths', defaultValue: 0)
  final int death;

  @JsonKey(name: 'discharged', defaultValue: 0)
  final int recovered;

  @JsonKey(name: 'totalConfirmed', defaultValue: 0)
  final int active;

  @JsonKey(name: 'confirmedCasesForeign', defaultValue: 0)
  final int serious;

  const StatisticsModel({
    required this.affected,
    required this.death,
    required this.recovered,
    required this.active,
    required this.serious,
  });

  factory StatisticsModel.fromJson(Map<String, dynamic> json) =>
      _$StatisticsModelFromJson(json);

  Map<String, dynamic> toJson() => _$StatisticsModelToJson(this);
}
