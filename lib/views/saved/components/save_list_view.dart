import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../core/constants/constants.dart';
import '../../../core/models/article.dart';
import '../../../core/utils/responsive.dart';
import 'empty_saved_list.dart';
import 'saved_article_tile.dart';
import 'saved_article_tile_tab.dart';

class SavedListViewBuilder extends StatelessWidget {
  const SavedListViewBuilder({
    Key? key,
    required this.data,
    required this.listKey,
    required this.onRefresh,
  }) : super(key: key);

  final List<ArticleModel> data;
  final GlobalKey<AnimatedListState> listKey;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const EmptySavedList();
    } else {
      return Responsive(
        mobile: _MobileListView(
          onRefresh: onRefresh,
          listKey: listKey,
          data: data,
        ),
        tablet: _TabletListView(
          onRefresh: onRefresh,
          listKey: listKey,
          data: data,
        ),
      );
    }
  }
}

class _MobileListView extends StatelessWidget {
  const _MobileListView({
    Key? key,
    required this.onRefresh,
    required this.listKey,
    required this.data,
  }) : super(key: key);

  final Future<void> Function() onRefresh;
  final GlobalKey<AnimatedListState> listKey;
  final List<ArticleModel> data;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: AnimatedList(
        padding: const EdgeInsets.only(top: 15),
        key: listKey,
        initialItemCount: data.length,
        itemBuilder: (context, index, animation) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: AppDefaults.duration,
            child: SlideAnimation(
              child: SavedArticleTile(
                article: data[index],
                animation: animation,
                index: index,
                onRefresh: onRefresh,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _TabletListView extends StatelessWidget {
  const _TabletListView({
    Key? key,
    required this.onRefresh,
    required this.listKey,
    required this.data,
  }) : super(key: key);

  final Future<void> Function() onRefresh;
  final GlobalKey<AnimatedListState> listKey;
  final List<ArticleModel> data;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: AnimatedList(
        padding: const EdgeInsets.only(top: 16),
        key: listKey,
        initialItemCount: data.length,
        itemBuilder: (context, index, animation) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: AppDefaults.duration,
            child: SlideAnimation(
              child: Responsive(
                mobile: SavedArticleTile(
                  article: data[index],
                  animation: animation,
                  index: index,
                  onRefresh: onRefresh,
                ),
                tablet: SavedArticleTileTab(
                  article: data[index],
                  animation: animation,
                  index: index,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
