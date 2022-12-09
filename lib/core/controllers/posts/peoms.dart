import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_pro/config/wp_config.dart';
import 'package:news_pro/core/controllers/posts/categories_post_controller.dart';
import 'package:news_pro/core/controllers/posts/poems_tag_view.dart';
import 'package:news_pro/core/routes/app_routes.dart';

class Peoms extends StatelessWidget {
  const Peoms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: WPConfig.primaryColor,
        centerTitle: true,
        title: const Text(
          'Poems',
          style: TextStyle(
            fontSize: 17,
            color: Colors.white,
            fontFamily: 'Avenir',

          ),
        ),
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
          Container(
            height: MediaQuery.of(context).size.height,
            width: 200,
            color: Theme.of(context).cardColor,
            child: PoemsTagView(
              arguments: CategoryPostsArguments(
                categoryId: 213,
                isHome: true,
              ),
              key: const ValueKey(
                213,
              ),
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
  }
}
