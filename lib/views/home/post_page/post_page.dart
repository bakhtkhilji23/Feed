import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:news_pro/views/home/post_page/components/save_post_button.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../config/wp_config.dart';
import '../../../core/components/app_video.dart';
import '../../../core/constants/constants.dart';
import '../../../core/controllers/comments/comments_controllers.dart';
import '../../../core/models/article.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/services/firestore_service.dart';
import '../../../core/utils/app_utils.dart';
import '../../../core/utils/responsive.dart';
import 'components/post_page_body.dart';

class PostPage extends StatefulWidget {
  PostPage({
    Key? key,
    required this.article,
    this.isHeroDisabled = false,
    this.isSpecialSession = false,
  }) : super(key: key);
  ArticleModel article;
  final bool isHeroDisabled;
  final bool isSpecialSession;

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> with TickerProviderStateMixin {
  bool isloading = false;
  late ArticleModel articleToshow;
  late final AnimationController _controller;

  Future<bool> getPost() async {
    // print("object");
    // setState(() {
    //   isloading = true;
    // });
    final client = http.Client();
    List<int> postIds = [26, 180];
    var rng = Random();
    int randomId = postIds[rng.nextInt(postIds.length)];
    //use randomNumber instead of 10 on the next line
    String url = 'https://${WPConfig.url}/wp-json/wl/v1/posts/$randomId';
    // String url =
    //     'https://awakenedwayapp.suzannegiesemann.com/wp-json/wl/v1/posts/10';
    try {
      final response = await client.post(Uri.parse(url));
      print('StatusCode==${response.statusCode}');
      if (response.statusCode == 200) {
        var isCheck = jsonDecode(response.body);

        dev.log('Response${jsonDecode(response.body).runtimeType}');
        PostModel refreshedPost = PostModel.fromJson(jsonDecode(response.body));
        print('title p ${refreshedPost.postTitle}');
        print('title p ${refreshedPost.postContent}');
        print('title p ${refreshedPost.postDate}');
        print('title p ${refreshedPost.id}');
        print('title p ${refreshedPost.postTitle}');
        setState(
          () {
            articleToshow = articleToshow.copyWith(
                title: refreshedPost.postTitle,
                heroTag: refreshedPost.postTitle,
                content: refreshedPost.postContent,
                id: refreshedPost.id,
                date: refreshedPost.postDate,
                featuredImage: refreshedPost.thumbnail
                //commentCount: refreshedPost.comment_count,
                );
          },
        );

        // print('Articless==>>${articleToshow!.title}');

        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: 'Try Again');
    } finally {
      client.close();
      isloading = false;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    articleToshow = widget.article;
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: _buildBottomSheet(context),
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          articleToshow.title,
          style: const TextStyle(
              color: Colors.white, fontSize: 20, fontFamily: 'Avenir'),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              articleToshow.featuredImage,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  FittedBox(
                    child: Html(
                      data: articleToshow.content,
                      customRender: {
                        'p': (RenderContext renderContext, Widget child) {
                          if (renderContext.tree.element!.text
                                  .contains('[fusion_builder') ||
                              renderContext.tree.element!.text
                                  .contains('[/fusion_text')) {
                            return Container();
                          }
                        },
                      },
                      onLinkTap: (url, renderContext, map, element) {
                        // ignore: deprecated_member_use
                        launch(
                          url!,
                        );
                      },
                      tagsList: Html.tags..remove('img'),
                      style: {
                        'body': Style(
                          color: Colors.white,
                          margin: EdgeInsets.zero,
                          padding: EdgeInsets.zero,
                          fontSize: FontSize(18),
                          lineHeight: const LineHeight(1.4),
                          fontWeight: FontWeight.w500,
                          // maxLines: 3,
                          // textOverflow: TextOverflow.ellipsis,
                        ),
                        'figure': Style(
                            margin: EdgeInsets.zero, padding: EdgeInsets.zero),
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/clock.svg',
                        width: 20,
                        height: 20,
                        color: Colors.orange,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        DateFormat.yMMMd().format(articleToshow.date),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  !widget.isSpecialSession
                      ? InkResponse(
                          onTap: () async {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    elevation: 0.0,
                                    alignment: Alignment.center,
                                    backgroundColor: Colors.transparent,
                                    child: Center(
                                      child: Container(
                                        height: 250,
                                        child: Column(
                                          children: [
                                            Container(
                                                width: 200,
                                                height: 100,
                                                margin:
                                                    EdgeInsets.only(bottom: 15),
                                                decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Center(
                                                  child: Lottie.asset(
                                                    'assets/animations/animation_done.json',
                                                    controller: _controller,
                                                    frameRate: FrameRate.max,
                                                    onLoaded: (composition) {
                                                      // Configure the AnimationController with the duration of the
                                                      // Lottie file and start the animation.
                                                      _controller
                                                        ..duration =
                                                            composition.duration
                                                        ..forward()
                                                            .whenComplete(() =>
                                                                {
                                                                  setState(
                                                                      () {})
                                                                });
                                                    },
                                                  ),
                                                )),
                                            Text(
                                              'Loading ...',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Avenir',
                                                  fontSize: 18),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                            await getPost().then(
                              (value) {
                                if (value) {
                                  Navigator.pop(context);
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => CustomVideoRenderer(
                                  //         article: articleToshow!),
                                  //   ),
                                  // );
                                } else {
                                  Navigator.pop(context);
                                }
                              },
                            );

                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => PostPageBody(article: articleToshow, onRefresh: getPost),
                            //     ));
                          },
                          child: Container(
                            height: 80,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFF4EEE0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/full.svg',
                                    width: 30,
                                    height: 23,
                                    color: WPConfig.primaryColor,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'INSPIRE',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Platform.isIOS ? 80 : 50,
            ),
          ],
        ),
      ),
    );
    //  Scaffold(
    // body:
    // SafeArea(
    //   bottom: false,
    //   top: article.tags.contains(WPConfig.videoTagID),
    //   child: Scrollbar(
    //     child: CustomScrollView(
    //       physics: const BouncingScrollPhysics(),
    //       slivers: [
    //         /// AppBar
    //         SliverAppBar(
    //           pinned: true,
    //           backgroundColor: Colors.transparent,
    //           leadingWidth: Responsive.isMobile(context)
    //               ? MediaQuery.of(context).size.width * 0.2
    //               : MediaQuery.of(context).size.width * 0.1,
    //           leading: ElevatedButton(
    //             style: ElevatedButton.styleFrom(
    //               shape: const CircleBorder(),
    //               primary: AppColors.cardColorDark.withOpacity(0.3),
    //               elevation: 0,
    //             ),
    //             onPressed: () => Navigator.pop(context),
    //             child: Icon(
    //               Icons.adaptive.arrow_back_rounded,
    //               color: Colors.white,
    //               size: 18,
    //             ),
    //           ),
    //           actions: [
    //             ElevatedButton(
    //               onPressed: () async => await Share.share(article.link),
    //               style: ElevatedButton.styleFrom(
    //                 shape: const CircleBorder(),
    //                 primary: AppColors.cardColorDark.withOpacity(0.3),
    //                 elevation: 0,
    //               ),
    //               child: const Icon(
    //                 IconlyLight.send,
    //                 color: Colors.white,
    //                 size: 18,
    //               ),
    //             ),
    //             SavePostButton(article: article),
    //           ],
    //           expandedHeight: Responsive.isMobile(context)
    //               ? MediaQuery.of(context).size.height * 0.3
    //               : MediaQuery.of(context).size.height * 0.5,
    //           flexibleSpace: article.tags.contains(WPConfig.videoTagID)
    //               ? CustomVideoRenderer(article: article)
    //               : FlexibleSpaceBar(
    //                   background: AspectRatio(
    //                     aspectRatio: AppDefaults.aspectRatio,
    //                     child: isHeroDisabled
    //                         ? NetworkImageWithLoader(
    //                             article.featuredImage,
    //                             fit: BoxFit.cover,
    //                             borderRadius: BorderRadius.zero,
    //                           )
    //                         : Hero(
    //                             tag: article.heroTag,
    //                             child: NetworkImageWithLoader(
    //                               article.featuredImage,
    //                               fit: BoxFit.cover,
    //                               borderRadius: BorderRadius.zero,
    //                             ),
    //                           ),
    //                   ),
    //                 ),
    //         ),
    //         SliverToBoxAdapter(
    //           child: PostPageBody(article: article),
    //         ),

    //         SliverStack(
    //           children: [
    //             SliverPositioned.fill(
    //                 child: Container(
    //                     decoration: BoxDecoration(
    //                         color: Theme.of(context).cardColor))),
    //             MoreRelatedPost(
    //               categoryID: article.categories.isNotEmpty
    //                   ? article.categories.first
    //                   : 0,
    //               currentArticleID: article.id,
    //             ),
    //           ],
    //         ),

    //         const SliverToBoxAdapter(
    //             child: AdConfig.isAdOn ? BannerAdWidget() : SizedBox()),

    //         SliverToBoxAdapter(
    //           child: Padding(
    //             padding: const EdgeInsets.all(AppDefaults.padding),
    //             child: SizedBox(
    //               width: double.infinity,
    //               child: ElevatedButton(
    //                 onPressed: () => Navigator.pop(context),
    //                 child: Text('go_back'.tr()),
    //               ),
    //             ),
    //           ),
    //         ),
    //         const SliverToBoxAdapter(
    //           child: Padding(
    //             padding: EdgeInsets.all(8.0),
    //             child: Text('.'),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // ),
    // floatingActionButton: Consumer(builder: (context, ref, child) {
    //   return FloatingActionButton.extended(
    //     foregroundColor: Colors.white,
    //     onPressed: () {
    //       Navigator.pushNamed(context, AppRoutes.comment, arguments: article);
    //     },
    //     label: Text('load_comments'.tr()),
    //     icon: const Icon(Icons.comment_rounded),
    //   );
    // }),
    // );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Container(
      color: AppColors.primary,
      height: Platform.isIOS ? 80 : 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _saveButton(),
          _commentButton(context),
          _shareButton(),
        ],
      ),
    );
  }

  Widget _shareButton() {
    return Row(
      children: [
        GestureDetector(
          onTap: () async {
            await Share.share(articleToshow.link);
            fireStoreService.incrementArticleShare(articleId: articleToshow.id);
          },
          child: SvgPicture.asset(
            'assets/icons/share.svg',
            width: 20,
            height: 20,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 8),
        StreamBuilder<DocumentSnapshot>(
            stream: fireStoreService.streamArticle(articleId: articleToshow.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  '${snapshot.data?.get('shares')}',
                  style: TextStyle(fontSize: 15, color: AppColors.separator),
                );
              } else {
                return const CupertinoActivityIndicator();
              }
            }),
      ],
    );
  }

  Widget _commentButton(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.comment,
                arguments: articleToshow);
          },
          child: Image.asset('assets/icons/comment.png',
              width: 20, height: 20, color: Colors.orange),
        ),
        const SizedBox(width: 8),
        Consumer(builder: (context, ref, child) {
          final commentProvider =
              ref.watch(postCommentController(articleToshow.id));
          final controller =
              ref.watch(postCommentController(articleToshow.id).notifier);
          return Text(
            '${commentProvider.comments.length}',
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          );
        }),
      ],
    );
  }

  Widget _saveButton() => Row(
        children: [
          SavePostButton(
            article: articleToshow,
          ),
          const SizedBox(width: 8),
          StreamBuilder<DocumentSnapshot>(
              stream:
                  fireStoreService.streamArticle(articleId: articleToshow.id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    '${snapshot.data?.get('likes')}',
                    style: TextStyle(fontSize: 15, color: AppColors.separator),
                  );
                } else {
                  return const CupertinoActivityIndicator();
                }
              }),
        ],
      );
}

// /// Used for rendering vidoe on top
// class CustomVideoRenderer extends StatelessWidget {
//   const CustomVideoRenderer({
//     Key? key,
//     required this.article,
//   }) : super(key: key);

//   final ArticleModel article;

//   @override
//   Widget build(BuildContext context) {
//     return FlexibleSpaceBar(
//       titlePadding: EdgeInsets.zero,
//       stretchModes: const [StretchMode.blurBackground],
//       background: Html(
//         data: article.content,
//         tagsList: const ['html', 'body', 'figure', 'video'],
//         style: {
//           'body': Style(
//             margin: EdgeInsets.zero,
//             padding: EdgeInsets.zero,
//           ),
//           'figure': Style(
//             margin: EdgeInsets.zero,
//             padding: EdgeInsets.zero,
//           ),
//         },
//         onLinkTap: (String? url, RenderContext renderCtx,
//             Map<String, String> attributes, _) {
//           if (url != null) {
//             AppUtil.openLink(url);
//           } else {
//             Fluttertoast.showToast(msg: 'Cannot launch this url');
//           }
//         },
//         customRender: {
//           'video': (RenderContext renderContext, Widget child) {
//             return AppVideo(
//               url: renderContext.tree.element!.attributes['src'].toString(),
//             );
//           },
//         },
//       ),
//     );
//   }
// }

FontSize _articleTileFont(BuildContext context) {
  if (Responsive.isMobile(context)) {
    return const FontSize(25);
  } else if (Responsive.isTabletPortrait(context)) {
    return const FontSize(48);
  } else if (Responsive.isTablet(context)) {
    return const FontSize(65);
  } else {
    return const FontSize(25);
  }
}

void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach(
        (match) => debugPrint(match.group(0)),
      );
}

/// Used for rendering vidoe on top
class CustomVideoRenderer extends StatefulWidget {
  const CustomVideoRenderer({
    Key? key,
    required this.article,
  }) : super(key: key);

  final ArticleModel article;

  @override
  State<CustomVideoRenderer> createState() => _CustomVideoRendererState();
}

class _CustomVideoRendererState extends State<CustomVideoRenderer> {
  var article1;

  @override
  void initState() {
    // TODO: implement initState
    article1 = widget.article;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print('HIII${article1.article.content}');
    printWrapped('article: ${article1.content}');
    return Html(
      data: article1.content,
      tagsList: const ['html', 'body', 'figure', 'video'],
      style: {
        'body': Style(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
        ),
        'figure': Style(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
        ),
      },
      onLinkTap: (String? url, RenderContext renderCtx,
          Map<String, String> attributes, _) {
        if (url != null) {
          AppUtil.openLink(url);
        } else {
          Fluttertoast.showToast(msg: 'Cannot launch this url');
        }
      },
      customRender: {
        'video': (RenderContext renderContext, Widget child) {
          return AppVideo(
            url: renderContext.tree.element!.attributes['src'].toString(),
          );
        },
      },
    );
  }
}
