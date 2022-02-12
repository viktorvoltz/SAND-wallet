import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<Map<String, dynamic>> getData() async {
  final response = await http.get(
    Uri.parse('https://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=USD,JPY,EUR&api_key=7b79ddb622e1ee13e5d625a35bd9de8c1e5fa88b075562af450cbd687cb6eda7'
        ),
  );
  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(response.body);
    return data;
  } else {
    throw Exception('Failed to Load Crypto Price.');
  }
}
