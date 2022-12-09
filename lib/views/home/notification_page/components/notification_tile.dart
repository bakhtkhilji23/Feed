import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../config/app_images_config.dart';
import '../../../../core/components/network_image.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/models/notification_model.dart';
import '../../../../core/repositories/posts/post_repository.dart';
import '../../../../core/routes/app_routes.dart';

class NotificationDetailsWidget extends ConsumerWidget {
  const NotificationDetailsWidget({
    Key? key,
    required this.data,
    required this.onDelete,
  }) : super(key: key);

  final NotificationModel data;
  final void Function() onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      borderRadius: AppDefaults.borderRadius,
      onTap: () async {
        if (data.postID != null) {
          context.loaderOverlay.show();
          final repo = ref.read(postRepoProvider);
          final post = await repo.getPost(postID: data.postID!);
          if (post != null) {
            // ignore: use_build_context_synchronously
            Navigator.pushNamed(context, AppRoutes.post, arguments: post);
          }
          context.loaderOverlay.hide();
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(AppDefaults.padding / 2),
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: NetworkImageWithLoader(
                  data.imageURL == '' || data.imageURL == null
                      ? AppImagesConfig.noImageUrl
                      : data.imageURL!,
                  radius: 4,
                ),
              ),
            ),
            AppSizedBox.w10,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Details
                  Text(
                    data.title,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 3,
                  ),

                  if (data.subtitle != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        data.subtitle!,
                        style: Theme.of(context).textTheme.caption?.copyWith(
                              color:
                                  Theme.of(context).textTheme.bodyText1?.color,
                            ),
                        maxLines: 2,
                      ),
                    ),

                  // Time
                  Text(
                    DateFormat.yMMMEd(context.locale.toLanguageTag())
                        .add_jm()
                        .format(data.recievedTime),
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onDelete,
              icon: const Icon(IconlyLight.delete, size: 18),
            ),
          ],
        ),
      ),
    );
  }
}
