class Software {
  final String id;
  final String name;
  final String version;

  Software({required this.id, required this.name, required this.version});
  
  static Software fromJson(Map<String, dynamic> json) {
    return Software(
      id: json["id"],
      name: json["name"],
      version: json["version"]
    );
  }
}