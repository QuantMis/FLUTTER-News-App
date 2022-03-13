import 'package:http/http.dart' as http;
import 'dart:developer';

class CryptoNewsApiService {
  final String baseUrl =
      "https://crypto-news-live3.p.rapidapi.com/news/cryptonews.com";

  var headers = {
    "x-rapidapi-host": "crypto-news-live3.p.rapidapi.com",
    "x-rapidapi-key": "b2a42a8833mshbdef73e7e9f7f6ep1cd838jsnc315f3ed2e43"
  };
  // Get All News

  Future getCryptoNews() async {
    var url = Uri.parse(baseUrl);
    var response = await http.get(url, headers: headers);
    return response;
  }
}
