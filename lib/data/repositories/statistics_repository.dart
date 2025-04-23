import 'package:app2/data/models/statistics_model.dart';
import 'package:app2/data/services/statistics_services.dart';

class StatisticRepository{
  final StatisticsService _service=StatisticsService();
  Future<StatisticsModel> getData()async{
    return await _service.statisticService();
  }
}