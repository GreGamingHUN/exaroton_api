import 'package:exaroton_api/src/models/player.dart';
import 'package:exaroton_api/src/models/software.dart';

class Server {
  final String id;
  final String name;
  final String address;
  final String motd;
  final int status;
  final String? host;
  final int? port;
  final int maxPlayers;
  final int onlinePlayers;
  final List<Player> players;
  final Software? software;
  final bool shared;

  Server({
    required this.id,
    required this.name,
    required this.address,
    required this.motd,
    required this.status,
    this.host,
    this.port,
    required this.maxPlayers,
    required this.onlinePlayers,
    required this.players,
    this.software,
    required this.shared
  });

  static Server fromJson(Map<String, dynamic> json) {
    List players = json["players"]["list"];


    return Server(
      id: json["id"],
      name: json["name"],
      address: json["address"],
      motd: json["motd"],
      status: json["status"],
      host: json["host"],
      port: json["port"],
      maxPlayers: json["players"]["max"],
      onlinePlayers: json["players"]["count"],
      players: List<Player>.from(players.map((x) => Player(name: x))),
      software: json["software"] != null ? Software.fromJson(json["software"]) : null,
      shared: json["shared"]
    );
  }

  @override
  String toString() {
    return "Server{id: $id, name: $name, address: $address, motd: $motd, status: $status, host: $host, port: $port, maxPlayers: $maxPlayers, onlinePlayers: $onlinePlayers, players: $players, software: $software, shared: $shared}";
  }
}