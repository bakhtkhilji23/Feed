import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_pro/core/constants/app_colors.dart';
import 'package:news_pro/core/controllers/posts/poems_tag_view.dart';
import 'package:news_pro/core/models/article.dart';
import 'package:share_plus/share_plus.dart';

import '../../../views/home/post_page/components/save_post_button.dart';
import '../../routes/app_routes.dart';
import '../../services/firestore_service.dart';
import '../comments/comments_controllers.dart';

class PoemPage extends StatelessWidget {
  final ArticleModel article;

  const PoemPage({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: _buildBottomSheet(context),
      backgroundColor: const Color(0xfff6e7ca),
      appBar: AppBar(
        backgroundColor: const Color(0xfff6e7ca),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          _buildImage(),
          const SizedBox(height: 30),
          _buildTitle(context),
          const SizedBox(height: 10),
          const Divider(
            color: AppColors.primary,
            thickness: 1,
          ),
          const SizedBox(height: 20),
          _buildContent(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TimeWidget(data: article),
            ],
          ),
          SizedBox(height: Platform.isIOS ? 80 : 50,),
        ],
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Container(
      color: const Color(0xfff6e7ca),
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
            await Share.share(article.link);
            fireStoreService.incrementArticleShare(articleId: article.id);
          },
          child: SvgPicture.asset(
            'assets/icons/share.svg',
            width: 20,
            height: 20,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: 8),
        StreamBuilder<DocumentSnapshot>(
            stream: fireStoreService.streamArticle(articleId: article.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  '${snapshot.data?.get('shares')}',
                  style: TextStyle(fontSize: 15, color: AppColors.primary),
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
                arguments: article);
          },
          child: Image.asset('assets/icons/comment.png',
              width: 20, height: 20, color: AppColors.primary),
        ),
        const SizedBox(width: 8),
        Consumer(builder: (context, ref, child) {
          final commentProvider =
          ref.watch(postCommentController(article.id));
          final controller =
          ref.watch(postCommentController(article.id).notifier);
          return Text(
            '${commentProvider.comments.length}',
            style: TextStyle(
              fontSize: 15,
              color: AppColors.primary,
            ),
          );
        }),
      ],
    );
  }

  Widget _saveButton() => Row(
    children: [
      SavePostButton(
        article: article,
        disabledColor: Colors.grey,
      ),
      const SizedBox(width: 8),
      StreamBuilder<DocumentSnapshot>(
          stream:
          fireStoreService.streamArticle(articleId: article.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(
                '${snapshot.data?.get('likes')}',
                style: TextStyle(fontSize: 15, color: AppColors.primary),
              );
            } else {
              return const CupertinoActivityIndicator();
            }
          }),
    ],
  );


  Row _buildTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(article.title,
            maxLines: 2,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Freight')),
      ],
    );
  }

  Widget _buildContent() {
    return Html(
      data: article.content,
      // tagsList: const ['html', 'body', 'figure', 'video'],
      // style: {
      //   'body': Style(
      //     margin: EdgeInsets.zero,
      //     padding: EdgeInsets.zero,
      //   ),
      //   'figure': Style(
      //     margin: EdgeInsets.zero,
      //     padding: EdgeInsets.zero,
      //   ),
      // },
      // onLinkTap: (String? url, RenderContext renderCtx,
      //     Map<String, String> attributes, _) {
      //   if (url != null) {
      //     AppUtil.openLink(url);
      //   } else {
      //     Fluttertoast.showToast(msg: 'Cannot launch this url');
      //   }
      // },
      // customRender: {
      //   'video': (RenderContext renderContext, Widget child) {
      //     return AppVideo(
      //       url: renderContext.tree.element!.attributes['src'].toString(),
      //     );
      //   },
      // },
    );
  }

  Container _buildImage() {
    return Container(
      height: 90,
      width: 90,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(15),
      child: SvgPicture.asset('assets/illustration/feathermain.svg',
          color: Colors.white),
    );
  }
}
