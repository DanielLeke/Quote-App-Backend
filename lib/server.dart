import 'dart:convert';
import 'dart:io';
import 'package:quote_app_backend/get_quote.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

final port = int.parse(Platform.environment['PORT'] ?? '8080');
late final HttpServer server;

final router = Router();

Future<void> createServer() async {
  await _getRandomQuote();

  server = await io.serve(router.call, InternetAddress.anyIPv4, port);
  print("Server created at $port");
}

Future<void> _getRandomQuote() async {
  router.get('/randomquote', (request) async {
    Quote randomQuote = await getQuote();
    Map<String, String> quoteDetails = {
      'author': randomQuote.author,
      'quote': randomQuote.quote,
    };
    final jsonResponse = jsonEncode(quoteDetails);
    return shelf.Response.ok(
      jsonResponse,
      headers: {'Content-Type': 'application/json'},
    );
  });
}
