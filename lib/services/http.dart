import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<Map<String, dynamic>> getData() async {
  final response = await http.get(
    Uri.parse(dotenv.env['CRYPTO_API']!
        ),
  );
  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(response.body);
    return data;
  } else {
    throw Exception('Failed to Load Crypto Price.');
  }
}
