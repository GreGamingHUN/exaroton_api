import 'dart:convert';

import 'package:exaroton_api/exaroton_api.dart';

class AccountService {
  final ExarotonClient _client;

  AccountService(this._client);


  /// Get the account's information
  Future<Account> getAccount() async {
    final response = await _client.request("/account");
    final responseBody = jsonDecode(response.body);
    return Account.fromJson(responseBody["data"]);
  }
}