import 'dart:convert';

import 'package:exaroton_api/src/services/account_service.dart';
import 'package:exaroton_api/src/services/server_service.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

import 'exceptions/api_exception.dart';

class ExarotonClient {
  final String _baseUrl = "https://api.exaroton.com/v1";
  final String _token;
  final http.Client _client = http.Client();
  late final Map headers;
  ExarotonClient(this._token) {
    headers = {
      "Authorization": "Bearer $_token",
      "Content-Type": "application/json",
      "User-Agent": "exaroton-api-dart/0.1.0"
    };
  }

  late final AccountService accountService = AccountService(this);
  late final ServerService serverService = ServerService(this);

  Future<http.Response> request(String endpoint,
      {String method = "GET", Map<String, dynamic>? body}) async {
    final uri = Uri.parse("$_baseUrl$endpoint");
    final headers = {
      "Authorization": "Bearer $_token",
      "Content-Type": "application/json",
      "User-Agent": "exaroton-api-dart/0.1.0"
    };

    late final http.Response response;

    switch (method.toUpperCase()) {
      case "POST":
        response =
            await _client.post(uri, headers: headers, body: jsonEncode(body));
      default:
        response = await _client.get(uri, headers: headers);
    }

    if (jsonDecode(response.body)["error"] != null) {
      throw ApiException(jsonDecode(response.body)["error"]);
    }
    return response;
  }

  WebSocketChannel connect(String serverId) {
    final uri = Uri.parse("wss://api.exaroton.com/v1/servers/$serverId/websocket");
    return WebSocketChannel.connect(uri, protocols: ["Authorization", _token]);
  }
}
