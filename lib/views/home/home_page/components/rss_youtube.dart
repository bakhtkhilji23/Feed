import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../config/wp_config.dart';

class RssYouTube extends StatefulWidget {
  //
  RssYouTube() : super();

  final String title = 'RSS Feed Demo';

  @override
  RssYouTubeState createState() => RssYouTubeState();
}

class RssYouTubeState extends State<RssYouTube> {
  //
  static const String FEED_URL = 'https://rss.app/feeds/uBQ1mkwUKq6HCikZ.xml';
  RssFeed? _feed;
  String? _title;
  static const String loadingFeedMsg = 'Loading Feed...';
  static const String feedLoadErrorMsg = 'Error Loading Feed.';
  static const String feedOpenErrorMsg = 'Error Opening Feed.';
  static const String placeholderImg = 'images/no_image.png';
  GlobalKey<RefreshIndicatorState>? _refreshKey;

  updateTitle(title) {
    setState(() {
      _title = title;
    });
  }

  updateFeed(feed) {
    setState(() {
      _feed = feed;
    });
  }

  Future<void> openFeed(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: false,
      );
      return;
    }
    updateTitle(feedOpenErrorMsg);
  }

  load() async {
    updateTitle(loadingFeedMsg);
    loadFeed().then((result) {
      if (null == result || result.toString().isEmpty) {
        updateTitle(feedLoadErrorMsg);
        return;
      }
      updateFeed(result);
      updateTitle(_feed!.title);
    });
  }

  Future<RssFeed?> loadFeed() async {
    try {
      final client = http.Client();
      final response = await client.get(Uri.parse(FEED_URL));
      return RssFeed.parse(response.body);
    } catch (e) {
      //
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _refreshKey = GlobalKey<RefreshIndicatorState>();
    updateTitle(widget.title);
    load();
  }

  title(title) {
    return Text(
      title,
      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  subtitle(subTitle) {
    return Text(
      subTitle,
      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w100),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  thumbnail(imageUrl) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        height: 50,
        width: 70,
        alignment: Alignment.center,
        fit: BoxFit.fill,
      ),
    );
  }

  rightIcon() {
    return Icon(
      Icons.keyboard_arrow_right,
      color: Colors.grey,
      size: 30.0,
    );
  }

  list() {
    return ListView.builder(
      itemCount: _feed!.items!.length,
      itemBuilder: (BuildContext context, int index) {
        final item = _feed!.items![index];
        String link = item.link.toString();
        var linkParts = link.split("=");
        final image =
            "https://img.youtube.com/vi/${linkParts[1]}/hqdefault.jpg";
        return ListTile(
          title: title(item.title),
          //subtitle: subtitle(item.pubDate ?? DateTime.now().toString()),
          // leading: thumbnail(
          //     'https://www.ncenet.com/wp-content/uploads/2020/04/No-image-found.jpg'),
          leading: thumbnail(image),
          trailing: rightIcon(),
          contentPadding: EdgeInsets.all(5.0),
          onTap: () => openFeed(item.link!),
        );
      },
    );
  }

  isFeedEmpty() {
    return null == _feed || null == _feed!.items;
  }

  body() {
    return isFeedEmpty()
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : RefreshIndicator(
            key: _refreshKey,
            child: list(),
            onRefresh: () => load(),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(_title!,
            style: TextStyle(
                fontFamily: 'Avenir', fontSize: 17, color: Colors.white)),
        backgroundColor: WPConfig.primaryColor,
      ),
      body: body(),
    );
  }
}
