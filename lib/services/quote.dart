import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String url = 'https://api.quotable.io/random';

Future<String> getRandomQuote() async {
  final response = await http.get(url);
  String quote = jsonDecode(response.body)['content'];
  print(quote);
  return quote;
}
