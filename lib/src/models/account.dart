class Account {
  final String name;
  final String email;
  final bool verified;
  final int credits;

  Account({required this.name, required this.email, required this.verified, required this.credits});

  static Account fromJson(Map<String, dynamic> json) {
    return Account(
      name: json["name"],
      email: json["email"],
      verified: json["verified"],
      credits: json["credits"]
    );
  }

  @override
  String toString() {
    return 'Account{name: $name, email: $email, verified: $verified, credits: $credits}';
  }

}