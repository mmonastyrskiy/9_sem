import 'package:html/parser.dart' as html_parser;
import 'package:http/http.dart' as http;

class Pinterest {
  static const String _userAgent = 
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36';

  Future<String> fetchHtml(String url) async {
    final response = await http.get(
      Uri.parse(url),
      headers: {'User-Agent': _userAgent},
    );
    
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load HTML from $url. Status code: ${response.statusCode}');
    }
  }

  String parseWebsite(String htmlContent) {
    final document = html_parser.parse(htmlContent);

    // Multiple possible selectors for Pinterest images
    final selectors = [
      'div.zI7 img',
      'img[data-testid="pin-image"]',
      '.hCL img',
      '.XiG img'
    ];

    for (final selector in selectors) {
      final imgElement = document.querySelector(selector);
      if (imgElement != null) {
        final imageUrl = imgElement.attributes['src'];
        if (imageUrl != null && imageUrl.isNotEmpty) {
          print('Found image URL: $imageUrl');
          return imageUrl;
        }
      }
    }

    // Fallback: look for any image with src containing specific patterns
    final allImages = document.querySelectorAll('img');
    for (final img in allImages) {
      final src = img.attributes['src'] ?? '';
      print(src);
      if (src.contains('i.pinimg.com') && src.isNotEmpty) {
        print('Found Pinterest image URL: $src');
        return src;
      }
    }

    print('No suitable image found');
    return "";
  }

  Future<String> parse(String url) async {
    try {
      final htmlContent = await fetchHtml(url); // Added 'await' here
      return parseWebsite(htmlContent);
    } catch (e) {
      print('Error parsing Pinterest URL: $e');
      rethrow;
    }
  }
}