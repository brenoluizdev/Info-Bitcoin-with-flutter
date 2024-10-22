import 'dart:convert';
import 'package:http/http.dart' as http;

class CryptoService {
  final String _baseUrl = 'https://api.coingecko.com/api/v3';

  Future<List<dynamic>> getCryptos() async {
    final response =
        await http.get(Uri.parse('$_baseUrl/coins/markets?vs_currency=usd'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Erro ao carregar os dados de criptomoedas');
    }
  }
}