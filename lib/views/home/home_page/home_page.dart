import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_pro/config/wp_config.dart';
import 'package:news_pro/core/routes/app_routes.dart';
import 'package:news_pro/drawer/drawer.dart';

import '../../../core/controllers/auth/auth_controller.dart';
import '../../../core/controllers/category/categories_controller.dart';
import '../../../core/controllers/notifications/notification_remote.dart';
import '../../../core/controllers/posts/categories_post_controller.dart';
import '../../../core/controllers/posts/feature_post_controller.dart';
import '../../../core/controllers/posts/saved_post_controller.dart';
import '../../../core/models/category.dart';
import '../../../core/repositories/others/internet_state.dart';
import 'components/category_tab_view.dart';
import 'components/internet_not_available.dart';
import 'components/loading_home_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  /// you can make api calls and put your categories here, but trending should
  /// be always first as it is
  List<CategoryModel> _feturedCategories = [];

  final _isLoading = StateProvider.autoDispose<bool>((ref) => false);

  /// Set Categories and update the UI
  _setCategories() async {
    ref.read(_isLoading.notifier).state = true;
    try {
      _feturedCategories = await ref
          .read(categoriesController.notifier)
          .getAllFeatureCategories();

      _tabController =
          TabController(length: _feturedCategories.length, vsync: this);
    } on Exception {
      _tabController = TabController(length: 1, vsync: this);
    }
    ref.read(_isLoading.notifier).state = false;
  }

  /// Tabs
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _setCategories();
    ref.read(savedPostController);
    ref.read(authController);
    ref.read(remoteNotificationProvider(context).notifier).handlePermission();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    bool isFetching = ref.watch(_isLoading);
    final featurePost = ref.watch(featurePostController);
    final internetAvailable = ref.watch(internetStateProvider(context));
    if (isFetching) {
      return const LoadingHomePage();
      // return Center(
      //     child: CupertinoActivityIndicator(
      //   radius: 30,
      // ));
    } else if (!internetAvailable) {
      return const InternetNotAvailablePage();
    } else {
      return Scaffold(
        drawer: Drawer(
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: DrawerWidget(),
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Daily Messages',
            style: TextStyle(
              fontSize: 17,
              color: Colors.white,
              fontFamily: 'Avenir',

            ),
          ),
          backgroundColor: WPConfig.primaryColor,
          actions: [
            IconButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.search),
              icon: SvgPicture.asset(
                'assets/drawer/filter.svg',
                // height: 20,
                color: Colors.white,
              ),
              // const Icon(IconlyLight.search),
            ),
            IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.notification),
              icon: const Icon(IconlyLight.notification),
            ),
          ],
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        body: ListView(
          children: [
            //
            //
            //
            Container(
              height: MediaQuery.of(context).size.height,
              width: 200,
              color: Theme.of(context).cardColor,
              child: CategoryTabView(
                arguments: CategoryPostsArguments(
                  categoryId: _feturedCategories[1].id,
                  isHome: true,
                ),
                key: ValueKey(_feturedCategories[1].slug),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: 200,
              color: Theme.of(context).cardColor,
              child: CategoryTabView(
                arguments: CategoryPostsArguments(
                  categoryId: _feturedCategories[2].id,
                  isHome: true,
                ),
                key: ValueKey(_feturedCategories[2].slug),
              ),
            ),
          ],
          // children: List.generate(
          //   _feturedCategories.length,
          //   (index) {
          //     print(index);
          //     if (index == 0) {
          //       return SizedBox(
          //         height: 12,
          //         width: 12,
          //       );
          //     } else {
          //       return
          // Container(
          //   height: MediaQuery.of(context).size.height,
          //   width: 200,
          //   color: Theme.of(context).cardColor,
          //   child: CategoryTabView(
          //     arguments: CategoryPostsArguments(
          //       categoryId: _feturedCategories[2].id,
          //       isHome: true,
          //     ),
          //     key: ValueKey(_feturedCategories[2].slug),
          //   ),
          // ),
          //     }
          //   },
          // ),
        ),
      );
      // NestedScrollView(
      //   physics: const BouncingScrollPhysics(),
      //   floatHeaderSlivers: true,
      //   headerSliverBuilder: (context, innerScroller) => [
      //     HomeAppBarWithTab(
      //       categories: _feturedCategories,
      //       tabController: _tabController,
      //       forceElevated: innerScroller,
      //     ),
      //   ],
      //   body:

      // );
    }
  }

  @override
  bool get wantKeepAlive => true;
}
