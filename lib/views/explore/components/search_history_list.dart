import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/responsive.dart';

import '../../../core/components/headline_with_row.dart';
import '../../../core/constants/constants.dart';
import '../../../core/controllers/posts/search_post_controller.dart';
import '../../../core/repositories/others/search_local.dart';

class SearchHistoryList extends ConsumerWidget {
  const SearchHistoryList({
    Key? key,
    required this.animatedListKey,
    required this.onTap,
  }) : super(key: key);

  final GlobalKey<AnimatedListState> animatedListKey;
  final void Function(String) onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(searchHistoryController);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppDefaults.padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeadlineRow(headline: 'recent_search', isHeader: false),
              AppSizedBox.h10,
              // Recent Searches
              history.map(
                data: (data) => data.value.isNotEmpty
                    ? AnimatedList(
                        key: animatedListKey,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index, animation) {
                          final current = data.value[index];
                          return SearchTile(
                            current: current,
                            animation: animation,
                            key: ValueKey(current.query),
                            onTap: () => onTap(current.query),
                            onDelete: () {
                              ref
                                  .read(searchHistoryController.notifier)
                                  .deleteEntry(current);

                              final currentItem = data.value[index];
                              animatedListKey.currentState?.removeItem(
                                index,
                                (context, animation) => SearchTile(
                                  current: currentItem,
                                  onDelete: () {},
                                  animation: animation,
                                  onTap: () {},
                                ),
                              );
                            },
                          );
                        },
                        initialItemCount: data.value.length,
                      )
                    : const SearchHistoryEmpty(),
                error: (t) => const Text('Error faced while fetching data'),
                loading: (t) => const CircularProgressIndicator(),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class SearchHistoryEmpty extends StatelessWidget {
  const SearchHistoryEmpty({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Responsive(
            mobile: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(AppDefaults.padding),
                child: Image.asset(AppImages.illustrationSearch),
              ),
            ),
            tablet: SizedBox(
              width: MediaQuery.of(context).size.width * 0.35,
              child: Padding(
                padding: const EdgeInsets.all(AppDefaults.padding),
                child: Image.asset(AppImages.illustrationSearch),
              ),
            ),
          ),
          AppSizedBox.h16,
          Text(
            'No history here',
            style: Theme.of(context).textTheme.headline6,
          ),
          AppSizedBox.h16,
          Text(
            'After you go through some\nthey will be added here',
            style: Theme.of(context).textTheme.caption,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class SearchTile extends StatelessWidget {
  const SearchTile({
    Key? key,
    required SearchModel current,
    required this.onDelete,
    required this.animation,
    required this.onTap,
  })  : _current = current,
        super(key: key);

  final SearchModel _current;
  final void Function() onDelete;
  final Animation<double> animation;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: animation,
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ListTile(
          onTap: onTap,
          leading: const Icon(IconlyLight.timeSquare, size: 36),
          title: Text(_current.query),
          subtitle: Text(
            '${DateFormat.yMEd(context.locale.toLanguageTag()).format(_current.time)} | ${DateFormat.jm(context.locale.toLanguageTag()).format(_current.time)}',
          ),
          trailing: IconButton(
            onPressed: onDelete,
            icon: const Icon(IconlyLight.closeSquare),
          ),
        ),
      ),
    );
  }
}
