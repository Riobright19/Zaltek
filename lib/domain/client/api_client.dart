import 'package:http/http.dart' as http;

class Postman {
  static Future<http.Response> sendGetRequest(String url) async {
    return http.get(
      Uri.parse(url),
    );
  }
}
