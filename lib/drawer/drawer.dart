import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_pro/config/wp_config.dart';
import 'package:news_pro/core/controllers/posts/peoms.dart';
import 'package:news_pro/core/controllers/posts/special_sessions.dart';
import 'package:news_pro/core/routes/app_routes.dart';
import 'package:news_pro/views/home/home_page/components/rss_youtube.dart';
import 'package:news_pro/views/saved/saved_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/controllers/auth/auth_controller.dart';
import '../views/home/home_page/components/rss_feed.dart';

class DrawerWidget extends ConsumerWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProvider = ref.watch(authController);
    // ignore: avoid_print
    print(authProvider.member?.toJson());
    return Drawer(
      backgroundColor: Colors.grey.shade100,
      child: ListView(
        padding:
        const EdgeInsets.only(left: 16, top: 20, right: 16, bottom: 16),
        children: [
          SizedBox(
            width: double.infinity,
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage:
                        NetworkImage(authProvider.member?.avatarUrl ?? ''),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '${authProvider.member?.name}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(
                  indent: 12,
                  endIndent: 12,
                  thickness: 3.5,
                  color: Color(0XFFF4EEE0),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 12.0,
            ),
            child: Column(
              children: [
                _buttons(context,
                    path: 'assets/icons/full.svg',
                    text: 'Daily Messages', onTap: () {
                      Navigator.of(context).pop();
                    }),
                _buttons(
                  context,
                  path: 'assets/drawer/about.svg',
                  text: 'The Awakened Way',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AppRoutes.about);
                  },
                ),
                _buttons(
                  context,
                  path: 'assets/icons/me.svg',
                  text: 'About Suzanne',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AppRoutes.aboutme);
                  },
                ),
                _buttons(
                  context,
                  path: 'assets/drawer/tools.svg',
                  text: 'Tools for Awakened Living',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AppRoutes.tenMinnutes);
                  }, // Navigator.pop(context);
                ),
                _buttons(
                  context,
                  path: 'assets/drawer/poems.svg',
                  text: 'Poems',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const Peoms(),
                      ),
                    );
                    // Navigator.pop(context);
                    //  Navigator.pushNamed(context, AppRoutes.);
                  },
                ),
                _buttons(
                  context,
                  path: 'assets/icons/session.svg',
                  text: 'Special Sessions',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SpeicalSession(),
                      ),
                    );
                  },
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RSSDemo(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 10),
                    child: Row(
                      children: [
                        // SvgPicture.asset(
                        //   'assets/icons/feather.png',
                        //   height: 20,
                        //   color: WPConfig.primaryColor,
                        // ),
                        SvgPicture.asset(
                          'assets/icons/date.svg',
                          width: 30,
                          height: 23,
                          color: WPConfig.primaryColor,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Events',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RssYouTube(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 10),
                    child: Row(
                      children: [
                        // SvgPicture.asset(
                        //   'assets/icons/feather.png',
                        //   height: 20,
                        //   color: WPConfig.primaryColor,
                        // ),
                        SvgPicture.asset(
                          'assets/icons/youtube.svg',
                          width: 30,
                          height: 23,
                          color: WPConfig.primaryColor,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Youtube',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                _buttons(
                  context,
                  path: 'assets/drawer/videos.svg',
                  text: 'Popular videos',
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.youtube);
                  },
                ),
                _buttons(
                  context,
                  path: 'assets/drawer/heart.svg',
                  text: 'My Favorites',
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            const SavedPage(isComingFromDrawer: true)));
                  },
                ),
                _buttons(
                  context,
                  path: 'assets/icons/website.svg',
                  text: 'Website',
                  onTap: () {
                    launchUrl(
                      Uri.parse('https://suzannegiesemann.com/'),
                    );
                  },
                ),
                // _buttons(
                //   context,
                //   path: 'assets/drawer/videos.svg',
                //   text: 'Settings',
                //   onTap: () {
                //     // Navigator.pop(context);
                //     // Navigator.pushNamed(context, AppRoutes.settings);
                //   },
                // ),
                _buttons(
                  context,
                  path: 'assets/icons/settings.svg',
                  text: 'Settings',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AppRoutes.settings);
                  },
                ),
                // _buttons(
                //   context,
                //   path: 'assets/drawer/contact.svg',
                //   text: 'Contact',
                //   onTap: () {
                //     Navigator.pushNamed(context, AppRoutes.contact);
                //   },
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttons(
      BuildContext context, {
        required String text,
        required String path,
        VoidCallback? onTap,
      }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        child: Row(
          children: [
            SvgPicture.asset(
              path,
              height: 20,
              color: WPConfig.primaryColor,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
