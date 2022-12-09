import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/components/network_image.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/models/article.dart';
import '../../../../core/routes/app_routes.dart';

class PostOnNotification extends StatelessWidget {
  const PostOnNotification({Key? key, required this.post}) : super(key: key);

  final ArticleModel post;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: AppDefaults.borderRadius,
      ),
      backgroundColor: Theme.of(context).cardColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.3,
                child: NetworkImageWithLoader(post.featuredImage),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: EdgeInsets.zero,
                  ),
                  child: const Icon(Icons.close_rounded),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(4),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Chip(
                    label: Text('New Post'.tr()),
                    avatar:
                        const CircleAvatar(backgroundColor: AppColors.primary),
                    labelStyle: Theme.of(context).textTheme.caption,
                  ),
                  AppSizedBox.w10,
                  Chip(
                    label: Text(
                        '${'Posted On'.tr()}: ${DateFormat.jm(context.locale.toLanguageTag()).format(post.date)}'),
                    avatar: const CircleAvatar(backgroundColor: Colors.green),
                    labelStyle: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AutoSizeText(
              post.title,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              maxLines: 2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, AppRoutes.post, arguments: post);
                },
                child: Text('Show Full Post'.tr()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
