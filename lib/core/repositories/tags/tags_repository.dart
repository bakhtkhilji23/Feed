import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../config/wp_config.dart';
import '../../models/post_tag.dart';

class TagRepository {
  Future<List<PostTag>> getTagsNameById(List<int> ids) async {
    List<PostTag> allTags = [];

    for (var i = 0; i < ids.length; i++) {
      final url = 'https://${WPConfig.url}/wp-json/wp/v2/tags/${ids[i]}';
      try {
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          allTags.add(PostTag.fromJson(response.body));
        } else {}
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    return allTags;
  }
}
