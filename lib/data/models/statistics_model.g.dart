// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistics_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatisticsModel _$StatisticsModelFromJson(Map<String, dynamic> json) =>
    StatisticsModel(
      affected: (json['confirmedCasesIndian'] as num?)?.toInt() ?? 0,
      death: (json['deaths'] as num?)?.toInt() ?? 0,
      recovered: (json['discharged'] as num?)?.toInt() ?? 0,
      active: (json['totalConfirmed'] as num?)?.toInt() ?? 0,
      serious: (json['confirmedCasesForeign'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$StatisticsModelToJson(StatisticsModel instance) =>
    <String, dynamic>{
      'confirmedCasesIndian': instance.affected,
      'deaths': instance.death,
      'discharged': instance.recovered,
      'totalConfirmed': instance.active,
      'confirmedCasesForeign': instance.serious,
    };
