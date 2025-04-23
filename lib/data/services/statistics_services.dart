import 'dart:convert';
import 'package:app2/data/models/statistics_model.dart';
import 'package:http/http.dart' as http;

class StatisticsService {
  Future<StatisticsModel> statisticService() async {
    final url = Uri.parse('https://api.rootnet.in/covid19-in/stats/latest');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);
        final summary = StatisticsModel.fromJson(jsonData['data']['summary']);
        return summary;
      } else {
        throw Exception('Failed to load statistics');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
