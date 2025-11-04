import 'dart:convert';
import 'package:http/http.dart' as http;

final randomQuotesUrl = Uri.parse("https://zenquotes.io/api/random");

class Quote {
  String quote;
  String author;

  Quote({required this.quote, required this.author});

  factory Quote.fromJson(Map<String, dynamic> jsonData) {
    String quote = jsonData['q'];
    String author = jsonData['a'];

    return Quote(quote: quote, author: author);
  }
}

Future<Map<String, dynamic>> getRandomQuote() async {
  final randomQuote = await http.get(randomQuotesUrl);
  String originalJson = randomQuote.body;
  final filteredJson = originalJson.replaceAll('[', '').replaceAll(']', '');
  final jsonData = json.decode(filteredJson);
  return jsonData;
}

Future<Quote> getQuote() async {
  Map<String, dynamic> jsonData = await getRandomQuote();
  Quote quote = Quote.fromJson(jsonData);
  return quote;
}
