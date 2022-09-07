import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/user_model.dart';

class UserService {
  String endPoint = "https://reqres.in/api/users?page=2";

  Future<List<UserModel>> getUser() async {
    http.Response response = await http.get(Uri.parse(endPoint));

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      return result.map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
