import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/article.dart';
import '../../repositories/others/search_local.dart';
import '../../repositories/posts/post_repository.dart';

/* <---- Search Post -----> */
final searchPostController = FutureProvider.autoDispose
    .family<List<ArticleModel>, String>((ref, query) async {
  final postRepo = ref.read(postRepoProvider);
  return await postRepo.searchPost(keyword: query);
});

/* <---- Search history -----> */
final searchHistoryController = StateNotifierProvider.autoDispose<
    SearchHistoryNotifier, AsyncValue<List<SearchModel>>>((ref) {
  return SearchHistoryNotifier(SearchLocalRepo());
});

class SearchHistoryNotifier
    extends StateNotifier<AsyncValue<List<SearchModel>>> {
  SearchHistoryNotifier(this.repo) : super(const AsyncData([])) {
    {
      _init();
    }
  }

  final SearchLocalRepo repo;

  _init() async {
    state = const AsyncLoading();
    final data = await repo.getEntries();
    state = AsyncData(data);
  }

  addEntry(String query) async {
    await repo.saveEntry(query: query);
    final data = await repo.getEntries();
    state = AsyncData(data);
  }

  deleteEntry(SearchModel query) async {
    await repo.deleteEntry(query: query);
    final newList = state.value?.where((element) => element != query).toList();
    state = AsyncData(newList!);
  }

  deleteAll() async {
    await repo.deleteAll();
    state = const AsyncData([]);
  }
}
