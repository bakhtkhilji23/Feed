import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../../../config/wp_config.dart';
import '../../models/author.dart';

class UserRepository {
  static Future<AuthorData?> getUserNamebyID(int id) async {
    final url = 'https://${WPConfig.url}/wp-json/wp/v2/users/$id';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        final author = AuthorData.fromMap(decodedData);
        return author;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error happened while fetching author data');
      return null;
    }
    return null;
  }

  static Future<void> deleteUsers(String token) async {
    const url = 'https://${WPConfig.url}/wp-json/remove_user/v1/user/me';
    try {
      final response = await http.delete(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        debugPrint('User deleted successfully');
        debugPrint(response.body.toString());
      } else {
        debugPrint(response.statusCode.toString());
        debugPrint(response.body.toString());
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error happened while deleting user');
    }
  }
}
