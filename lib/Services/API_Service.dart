import 'dart:convert';
import 'package:MoneyBee/Models/Model.dart';
import 'package:http/http.dart' as http;


class ExchangeRateService {
  static const String _url =
      'https://open.er-api.com/v6/latest/USD';

  static Future<ExchangeRateModel> fetchRate() async {
    try {
      final response = await http.get(Uri.parse(_url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return ExchangeRateModel.fromJson(data);
      } else {
        throw Exception('Failed to load exchange rate');
      }
    } catch (e) {
      throw Exception('Network error');
    }
  }
}