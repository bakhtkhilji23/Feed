import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/post_tag.dart';
import '../../repositories/tags/tags_repository.dart';

final tagsProvider = FutureProvider.family
    .autoDispose<List<PostTag>, List<int>>((ref, tagIDList) async {
  final repo = TagRepository();
  final tags = await repo.getTagsNameById(tagIDList);
  return tags;
});
