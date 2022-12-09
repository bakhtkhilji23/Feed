import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../../../config/wp_config.dart';
import '../../models/article.dart';
import 'post_local_repository.dart';

final postRepoProvider = Provider<PostRepository>((ref) {
  final localRepo = ref.read(postLocalRepoProvider);
  final repo = PostRepository(localRepo);
  return repo;
});

abstract class PostRepoAbstract {
  /// Get All Posts [Paginated]
  Future<List<ArticleModel>> getAllPost({required int pageNumber});

  /// Get Post By Category
  Future<List<ArticleModel>> getPostByCategory({
    required int pageNumber,
    required int categoryID,
  });

  Future<List<ArticleModel>> getPostByTag({
    required int pageNumber,
    required int tagID,
  });

  /// Get Post
  Future<ArticleModel?> getPost({required int postID});

  /// Get Popular Posts
  ///
  /// [isPlugin] This is because sometimes the popular post plugin returns an empty
  /// array or you wanna just add a feature post by yourself, which
  /// in this case this is required
  Future<List<ArticleModel>> getPopularPosts({bool isPlugin = true});

  /// Search Posts
  Future<List<ArticleModel>> searchPost({required String keyword});

  /// Retrieve all saved posts
  Future<List<ArticleModel>> getsavedPosts();

  /// Get Post From Slug
  Future<ArticleModel?> getPostFromUrl({required String requestedURL});
}

/// [PostRepository] that is responsible for posts getting
/// It is an implementation from the above abstract class
class PostRepository extends PostRepoAbstract {
  PostRepository(this._postLocalRepo);
  final PostLocalRepository _postLocalRepo;

  /* <---- Get All Posts -----> */
  @override
  Future<List<ArticleModel>> getAllPost({
    required int pageNumber,
  }) async {
    final client = http.Client();
    String url =
        'https://${WPConfig.url}/wp-json/wp/v2/posts/?page=$pageNumber';
    List<ArticleModel> articles = [];
    try {
      final response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final posts = jsonDecode(response.body) as List;
        articles = posts.map(((e) => ArticleModel.fromMap(e))).toList();
      }
      return articles;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return [];
    } finally {
      client.close();
    }
  }

  /* <---- Get Post By Category -----> */
  @override
  Future<List<ArticleModel>> getPostByCategory({
    required int pageNumber,
    required int categoryID,
  }) async {
    final client = http.Client();
    String url =
        'https://${WPConfig.url}/wp-json/wp/v2/posts/?categories=$categoryID&page=$pageNumber';
    List<ArticleModel> articles = [];
    try {
      final response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final posts = jsonDecode(response.body) as List;
        articles = posts.map((e) => ArticleModel.fromMap(e)).toList();
      }
      return articles;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return [];
    } finally {
      client.close();
    }
  }

  @override
  Future<List<ArticleModel>> getPostByTag({
    required int pageNumber,
    required int tagID,
  }) async {
    final client = http.Client();
    String url =
        'https://${WPConfig.url}/wp-json/wp/v2/posts/?tags=$tagID&page=$pageNumber';
    List<ArticleModel> articles = [];
    try {
      final response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final posts = jsonDecode(response.body) as List;
        articles = posts.map((e) => ArticleModel.fromMap(e)).toList();
      }
      return articles;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return [];
    } finally {
      client.close();
    }
  }

  /* <---- Get Popular Posts -----> */
  @override
  Future<List<ArticleModel>> getPopularPosts({
    bool isPlugin = true,
    int featureCategory = 1,
  }) async {
    final client = http.Client();
    List<ArticleModel> articles = [];

    /// Fetching from Plugin
    if (isPlugin) {
      String url =
          'https://${WPConfig.url}/wp-json/wordpress-popular-posts/v1/popular-posts/';
      try {
        final response = await client.get(Uri.parse(url));
        if (response.statusCode == 200) {
          final posts = jsonDecode(response.body) as List;
          articles = posts.map(((e) => ArticleModel.fromMap(e))).toList();
        }
      } on Exception catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      } finally {
        client.close();
      }
      return articles;
    }

    /// If not plugin then we are going to fetch feature category
    else {
      String url =
          'https://${WPConfig.url}/wp-json/wp/v2/posts/?categories=$featureCategory';
      try {
        final response = await client.get(Uri.parse(url));
        if (response.statusCode == 200) {
          final posts = jsonDecode(response.body) as List;
          articles = posts.map(((e) => ArticleModel.fromMap(e))).toList();
        }
      } on Exception catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      } finally {
        client.close();
      }
      return articles;
    }
  }

  /* <---- Get a Post -----> */
  @override
  Future<ArticleModel?> getPost({required int postID}) async {
    final client = http.Client();
    String url = 'https://${WPConfig.url}/wp-json/wp/v2/posts/$postID';

    try {
      final response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return ArticleModel.fromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      client.close();
    }
    return null;
  }
  getFormateDate(DateTime? date,bool isStart){
    if(date != null){
      return date.year.toString() + '-' + (date.month.toString().length == 1 ? ('0' + date.month.toString()) : date.month.toString()) + '-' + (date.day.toString().length == 1 ? ('0' + date.day.toString()) : date.day.toString()) + (isStart ? 'T00:00:00':'T23:59:59') ;
    }else{
      return '';
    }
  }
  /* <---- Search a post -----> */
  @override
  Future<List<ArticleModel>> searchPost(
      {required String keyword, DateTime? end, DateTime? start}) async {
    final client = http.Client();
    String url = 'https://${WPConfig.url}/wp-json/wp/v2/posts/?search=$keyword&after=${getFormateDate(start,true)}&before=${getFormateDate(end,false)}';
    List<ArticleModel> articles = [];

    try {
      final response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final posts = jsonDecode(response.body) as List;
        articles = posts.map(((e) => ArticleModel.fromMap(e))).toList();
      }

      return articles;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return [];
    } finally {
      client.close();
    }
  }

  @override
  Future<ArticleModel?> getPostFromUrl({required String requestedURL}) async {
    final theUrl = Uri.parse(requestedURL);
    final host = theUrl.host;
    String stripVersion = theUrl.path.replaceAll(RegExp(r'[^\w\s]+'), ' ');
    debugPrint('Stripped Version: $stripVersion');
    String postParameter = stripVersion;

    if (host == WPConfig.url) {
      final articles = await searchPost(keyword: postParameter);
      final article = articles.isNotEmpty ? articles.first : null;
      debugPrint(article.toString());
      return article;
    } else {
      debugPrint('This is not our app content');
    }
    return null;
  }

  @override
  Future<List<ArticleModel>> getsavedPosts() async {
    try {
      final ids = await _postLocalRepo.getSavedPostsID();
      List<ArticleModel> allPosts = [];
      for (var id in ids) {
        final post = await getPost(postID: id);
        if (post != null) allPosts.add(post);
      }
      return allPosts;
    } catch (exception) {
      return [];
    }
  }
}
