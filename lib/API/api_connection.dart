import 'package:http/http.dart' as http;

class ApiConnection {
  String url = "https://min-api.cryptocompare.com";

  String getUrl(String endpoint) {
    return url + endpoint;
  }

  String getUrlWithParams(String endpoint, Map<String, String> params) {
    String url = this.url + endpoint;
    return "$url?${params.entries.map((entry) => "${entry.key}=${entry.value}").join("&")}";
  }
}