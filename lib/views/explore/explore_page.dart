import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/controllers/category/categories_controller.dart';
import '../../core/repositories/others/internet_state.dart';
import '../home/home_page/components/internet_not_available.dart';
import 'components/categories_list.dart';
import 'components/search_bar.dart';

class ExplorePage extends ConsumerStatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends ConsumerState<ExplorePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final data = ref.watch(categoriesController);
    final internetAvailable = ref.watch(internetStateProvider(context));
    if (internetAvailable) {
      return Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SafeArea(
          child: Column(
            children: [
              const SearchButton(),
              Expanded(
                child:

                    /// We will not pass [Feature Category] here. Because it's not
                    /// from our server
                    CategoriesList(
                  categories:
                      data.where((element) => element != data.first).toList(),
                ),
              ),
            ],
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
