import 'package:flutter_dotenv/flutter_dotenv.dart';

class URLImages {
  static String image(String filename) {
    if (filename.isEmpty) return '';
    if (filename.startsWith('https')) return filename;
    final baseUrl = dotenv.env['BASE_URL'] ?? '';
    return '$baseUrl/$filename';
  }
}
