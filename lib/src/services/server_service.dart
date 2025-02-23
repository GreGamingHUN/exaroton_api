import 'dart:convert';

import 'package:exaroton_api/exaroton_api.dart';
import 'package:exaroton_api/src/models/server.dart';
import 'package:http/http.dart';

class ServerService {
  final ExarotonClient _client;

  ServerService(this._client);


  /// Returns a list of the account's servers.
  Future<List<Server>> getServers() async {
    final response = await _client.request("/servers");
    final responseBody = jsonDecode(response.body);
    List<Server> servers = [];
    for (var server in responseBody["data"]) {
      servers.add(Server.fromJson(server));
    }
    return servers;
  }


  /// Returns a server by its serverId.
  Future<Server> getServerById(String serverId) async {
    final response = await _client.request("/servers/$serverId");
    final responseBody = jsonDecode(response.body);
    return Server.fromJson(responseBody["data"]);
  }


  /// Returns a server's logs.
  Future<String?> getServerLogs(String serverId) async {
    final response = await _client.request("/servers/$serverId/logs");
    final responseBody = jsonDecode(response.body);
    return responseBody["data"]["content"];
  }


  /// Returns how much RAM the server has in Gigabytes.
  Future<int?> getServerRam(String serverId) async {
    final response = await _client.request("/servers/$serverId/options/ram");
    final responseBody = jsonDecode(response.body);
    return responseBody["data"]["ram"];
  }

  /// Sets the server's RAM in Gigabytes.
  Future<Response> setServerRam(String serverId, int ram) async {
    return _client.request("/servers/$serverId/options/ram", method: "POST", body: {"ram": ram});
  }

  Future<String?> getServerMotd(String serverId) async {
    final response = await _client.request("/servers/$serverId/options/motd");
    final responseBody = jsonDecode(response.body);
    return responseBody["data"]["motd"];
  }

  Future<Response> setServerMotd(String serverId, String motd) async {
    return _client.request("/servers/$serverId/options/motd", method: "POST", body: {"motd": motd});
  }

  Future<Response> startServer(String serverId) async {
    return _client.request("/servers/$serverId/start");
  }

  Future<Response> stopServer(String serverId) async {
    return _client.request("/servers/$serverId/stop");
  }

  Future<Response> restartServer(String serverId) async {
    return _client.request("/servers/$serverId/restart");
  }

  Future<Response> sendCommand(String serverId, String command) async {
    return _client.request("/servers/$serverId/command", method: "POST", body: {"command": command});
  }

  Future<List<String>> getPlayerLists(String serverId) async {
    Response response = await _client.request("/servers/$serverId/playerlists");
    return jsonDecode(response.body)["data"];
  }

  Future<List<String>> getPlayerList(String serverId, String playerList) async {
    Response response = await _client.request("/servers/$serverId/playerlists/$playerList");
    return jsonDecode(response.body)["data"];
  }

  Future<Response> addPlayerToPlayerList(String serverId, String playerList, String player) async {
    return _client.request("/servers/$serverId/playerlists/$playerList", method: "PUT", body: {"entries": player});
  }

  Future<Response> removePlayerToPlayerList(String serverId, String playerList, String player) async {
    return _client.request("/servers/$serverId/playerlists/$playerList", method: "DELETE", body: {"entries": player});
  }
}