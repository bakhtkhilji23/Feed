import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final postLocalRepoProvider = Provider<PostLocalRepository>((ref) {
  final repo = PostLocalRepository();
  return repo;
});

/// Used for saving and managing saved Posts
abstract class PostLocalAbstract {
  /// Save a Post to Database
  Future<void> savePostID(int postID);

  /// Delete a Post from Database
  Future<void> deletePostID(int postID);

  /// Retrieve all saved posts ID
  Future<List<int>> getSavedPostsID();
}

/// Used for saving and managing saved Posts
class PostLocalRepository extends PostLocalAbstract {
  /* <---- Local -----> */
  final String _dataBaseName = 'savedPostBox';
  final String _fieldKey = 'savedPosts';

  Future<void> init() async {
    await Hive.openBox(_dataBaseName);
  }

  @override
  Future<List<int>> getSavedPostsID() async {
    var box = Hive.box(_dataBaseName);
    final data = box.get(_fieldKey) as List<int>?;
    if (data != null) {
      return data;
    } else {
      return <int>[];
    }
  }

  @override
  Future<void> savePostID(int postID) async {
    var box = Hive.box(_dataBaseName);
    final data = box.get(_fieldKey) as List<int>?;
    if (data != null) {
      if (data.contains(postID)) {
      } else {
        data.add(postID);
        await box.put(_fieldKey, data);
      }
    } else {
      await box.put(_fieldKey, [postID]);
    }
  }

  @override
  Future<void> deletePostID(int postID) async {
    var box = await Hive.openBox(_dataBaseName);
    final data = box.get(_fieldKey) as List<int>?;
    if (data != null) {
      if (data.contains(postID)) {
        data.remove(postID);
        await box.put(_fieldKey, data);
      }
    }
  }
}
