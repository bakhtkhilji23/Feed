import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../../core/components/app_shimmer.dart';
import '../../../../core/components/column_builder.dart';
import '../../../../core/constants/app_defaults.dart';
import '../../../../core/models/comment.dart';

class UserComment extends StatelessWidget {
  const UserComment({
    Key? key,
    required this.userName,
    required this.comment,
    required this.userImage,
    required this.timeStamp,
    required this.replies,
    required this.onReply,
  }) : super(key: key);

  final String comment;
  final String userName;
  final String userImage;
  final String timeStamp;
  final List<CommentModel> replies;
  final void Function() onReply;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(userImage),
          ),
          title: Text(
            userName,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
          subtitle: Text(timeStamp),
          trailing: TextButton(onPressed: onReply, child: const Text('Reply')),
        ),
        Row(
          children: [
            /// This will act as a empty space
            /// so we can align with the userpicture above
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Opacity(opacity: 0.0, child: CircleAvatar()),
            ),
            Expanded(
              child: Html(
                data: comment,
                style: {
                  'body': Style(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    fontSize: const FontSize(16.0),
                    lineHeight: const LineHeight(1.4),
                  ),
                },
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: AppDefaults.padding * 2),
          child: ColumnBuilder(
              itemBuilder: (context, index) {
                return ReplyComment(reply: replies[index]);
              },
              itemCount: replies.length),
        ),
        const Divider(),
      ],
    );
  }
}

class ReplyComment extends StatelessWidget {
  const ReplyComment({
    Key? key,
    required this.reply,
  }) : super(key: key);

  final CommentModel reply;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(color: Colors.grey),
        ),
      ),
      child: Column(
        children: [
          ListTile(
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.grey,
                  height: 15,
                  width: 1,
                ),
                Container(
                  color: Colors.grey,
                  height: 1,
                  width: 10,
                ),
                CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(reply.avatarURL),
                ),
              ],
            ),
            title: Text(
              reply.authorName,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
            subtitle: Text(
              DateFormat.yMMMMEEEEd(context.locale.toLanguageTag())
                  .format(reply.time),
            ),
          ),
          Row(
            children: [
              /// This will act as a empty space
              /// so we can align with the userpicture above
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Opacity(opacity: 0.0, child: CircleAvatar()),
              ),
              Expanded(
                child: Html(
                  data: reply.content,
                  style: {
                    'body': Style(
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      fontSize: const FontSize(14.0),
                      lineHeight: const LineHeight(1.4),
                    ),
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DummyUserComment extends StatelessWidget {
  const DummyUserComment({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const AppShimmer(child: CircleAvatar()),
          title: AppShimmer(
            child: Container(
              margin: EdgeInsets.only(
                right: MediaQuery.of(context).size.width / 3.5,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: AppDefaults.borderRadius,
              ),
              child: const Text('App Text'),
            ),
          ),
          subtitle: AppShimmer(
            child: Container(
              margin: EdgeInsets.only(
                top: 8,
                right: MediaQuery.of(context).size.width / 3,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: AppDefaults.borderRadius,
              ),
              child: const Text('App Text'),
            ),
          ),
          trailing: const AppShimmer(child: Icon(Icons.more_horiz_rounded)),
        ),
        Row(
          children: [
            /// This will act as a empty space
            /// so we can align with the userpicture above
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Opacity(opacity: 0.0, child: CircleAvatar()),
            ),
            Expanded(
              child: AppShimmer(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: AppDefaults.borderRadius,
                  ),
                  child: const Text(
                      'Hello there, this is a test comment with some comment to show some dummy users'),
                ),
              ),
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
