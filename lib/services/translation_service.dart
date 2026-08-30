import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// Service for dynamic live translation of user-generated content (posts, descriptions, bios)
class TranslationService {
  /// Translates dynamic text into target language (default 'gu' for Gujarati)
  static Future<String> translateText(String text, {String targetLanguage = 'gu'}) async {
    if (text.trim().isEmpty) return text;

    try {
      final url = Uri.parse(
        'https://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl=$targetLanguage&dt=t&q=${Uri.encodeComponent(text)}',
      );

      final response = await http.get(url).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        if (data.isNotEmpty && data[0] is List) {
          final StringBuffer translatedBuffer = StringBuffer();
          for (var item in data[0]) {
            if (item is List && item.isNotEmpty && item[0] != null) {
              translatedBuffer.write(item[0]);
            }
          }
          final result = translatedBuffer.toString();
          return result.isNotEmpty ? result : text;
        }
      }
    } catch (e) {
      debugPrint('Google Translate API error: $e');
    }

    return text; // Return original text if translation fails
  }
}
