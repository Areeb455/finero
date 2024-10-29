import 'dart:convert';
import 'package:http/http.dart' as http;
import '../crypto model/crypto model.dart';

const String apiUrl = 'https://api.coingecko.com/api/v3/coins/markets';


Future<List<Crypto>> fetchCryptoMarketData() async {
  final response = await http.get(Uri.parse(
      '$apiUrl?vs_currency=usd&order=market_cap_desc&per_page=1000&page=1&sparkline=false'));

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => Crypto.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load crypto market data');
  }
}

Future<List<dynamic>> fetchCoinMarketData() async {
  final response = await http.get(Uri.parse('https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=10&page=1&sparkline=false'));

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data;
  } else {
    throw Exception('Failed to load market data');
  }
}
