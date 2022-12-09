import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/wp_config.dart';
import '../../core/components/headline_with_row.dart';
import '../../core/constants/constants.dart';
import '../../core/controllers/posts/saved_post_controller.dart';
import '../../core/repositories/others/internet_state.dart';
import '../home/home_page/components/internet_not_available.dart';
import '../home/home_page/components/loading_posts_responsive.dart';
import 'components/save_list_view.dart';

class SavedPage extends ConsumerStatefulWidget {
  final bool isComingFromDrawer;
  const SavedPage({Key? key, this.isComingFromDrawer = false})
      : super(key: key);

  @override
  ConsumerState<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends ConsumerState<SavedPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final provider = ref.watch(savedPostController);
    final notifier = ref.read(savedPostController.notifier);
    final internetAvailable = ref.watch(internetStateProvider(context));
    if (internetAvailable) {
      return Material(
        child: Container(
          color: Theme.of(context).cardColor,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: WPConfig.primaryColor,
              leading: Row(children: [
                if (widget.isComingFromDrawer) ...[
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )),
                  // const SizedBox(width: 10),
                ],
              ]),
              title: const HeadlineRow(headline: 'saved'),
            ),
            body: Container(
              padding: const EdgeInsets.all(AppDefaults.padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  provider.map(
                    data: (data) => Expanded(
                      child: SavedListViewBuilder(
                        data: data.value,
                        listKey: notifier.animatedListKey,
                        onRefresh: notifier.onRefresh,
                      ),
                    ),
                    error: (t) => Center(child: Text(t.toString())),
                    loading: (t) => const Expanded(
                      child: LoadingPostsResponsive(isInSliver: false),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return const InternetNotAvailablePage();
    }
  }

  @override
  bool get wantKeepAlive => true;
}
