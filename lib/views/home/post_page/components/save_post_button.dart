import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/services/firestore_service.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/controllers/posts/saved_post_controller.dart';
import '../../../../core/models/article.dart';

class SavePostButton extends ConsumerWidget {
  SavePostButton({
    Key? key,
    required this.article,
    this.disabledColor = Colors.white,
    this.postSaveCallback,
    this.iconSize = 18,
    this.savedNo,
  }) : super(key: key);

  final ArticleModel article;
  final Function? postSaveCallback;
  final double iconSize;
  final Color disabledColor;
  int? savedNo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isSaved = (ref.watch(savedPostController).value?.contains(article) ==
                null ||
            ref.watch(savedPostController).value?.contains(article) == false)
        ? false
        : true;
    return InkWell(
      onTap: () async {
        final saved = ref.watch(savedPostController);
        if (isSaved) {
          await ref
              .read(savedPostController.notifier)
              .removePostFromSaved(article.id);

          fireStoreService.incrementArticleLikes(
              articleId: article.id, isLike: false);
          // notifier.onRefresh();

          Fluttertoast.showToast(msg: 'article_removed_message'.tr());
        } else {
          await ref.read(savedPostController.notifier).addPostToSaved(article);

          fireStoreService.incrementArticleLikes(
              articleId: article.id, isLike: true);
          // notifier.onRefresh();
          Fluttertoast.showToast(msg: 'article_saved_message'.tr());
        }

        // if (postSaveCallback != null) {
        //   postSaveCallback!();
        // }
      },
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/heart.svg',
            width: 20,
            height: 20,
            color: !isSaved ? disabledColor : Colors.red,
          ),
        ],
      ),
    );
  }
}
