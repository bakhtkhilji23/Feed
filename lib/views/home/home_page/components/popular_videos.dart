import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../config/wp_config.dart';
import '../../../about_sg/components/biography_widget.dart';

class PopularVideosPage extends StatefulWidget {
  //
  PopularVideosPage() : super();

  final String title = 'Popular Videos';

  @override
  PopularVideosPageState createState() => PopularVideosPageState();
}

class PopularVideosPageState extends State<PopularVideosPage> {
  List<String> videosList = [
    'https://www.youtube.com/watch?v=1LPuE3rueVY',
    'https://www.youtube.com/watch?v=J6fC1Z6kUZQ',
    'https://www.youtube.com/watch?v=vkD5gDeUeAc',
    'https://www.youtube.com/watch?v=ZSyOx_BmbMg',
    'https://www.youtube.com/watch?v=SkwvSfCJvvM',
  ];
  String? _title;
  static const String loadingFeedMsg = 'Loading Popular Videos...';
  static const String feedLoadErrorMsg = 'Error Loading Videos.';
  static const String feedOpenErrorMsg = 'Error Opening Videos.';
  static const String placeholderImg = 'images/no_image.png';
  GlobalKey<RefreshIndicatorState>? _refreshKey;

  updateTitle(title) {
    setState(() {
      _title = title;
    });
  }

  openVideo(String id) async {
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
                  child: VideoWidget(
                    videoId: id,
                    margin: EdgeInsets.zero,
                    autoPlay: true,
                  )),
            ),
          );
        });
  }
  // load() async {
  //   updateTitle(loadingFeedMsg);
  //   loadFeed().then((result) {
  //     if (null == result || result.toString().isEmpty) {
  //       updateTitle(feedLoadErrorMsg);
  //       return;
  //     }
  //     updateFeed(result);
  //     updateTitle(_feed!.title);
  //   });
  // }

  Future<String> getTitle(String videoUrl) async {
    var jsonData = await getVideoDetails(videoUrl);
    return jsonData['title'];
  }

  Future<dynamic> getVideoDetails(String userUrl) async {
    String embedUrl = "https://www.youtube.com/oembed?url=$userUrl&format=json";

    //store http request response to res variable
    var res = await http.get(Uri.parse(embedUrl));
    print("get youtube detail status code: " + res.statusCode.toString());

    try {
      if (res.statusCode == 200) {
        //return the json from the response
        return json.decode(res.body);
      } else {
        //return null if status code other than 200
        return null;
      }
    } on FormatException catch (e) {
      print('invalid JSON' + e.toString());
      //return null if error
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _refreshKey = GlobalKey<RefreshIndicatorState>();
    updateTitle(widget.title);
    // load();
  }

  title(String title) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.white),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  list() {
    return ListView.builder(
      itemCount: videosList.length,
      itemBuilder: (BuildContext context, int index) {
        final String item = videosList[index];
        var linkParts = item.split('=');
        final image =
            "https://img.youtube.com/vi/${linkParts[1]}/hqdefault.jpg";
        return InkWell(
          onTap: () => openVideo(linkParts[1]),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            height: 200,
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            padding: EdgeInsets.all(5),
            child: Stack(
              //mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: image,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) =>
                      Center(child: CupertinoActivityIndicator()),
                  errorWidget: (context, url, error) => Center(
                      child: Icon(
                    Icons.error,
                    color: Colors.grey,
                  )),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 40,
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    color: WPConfig.primaryColor,
                    child: FutureBuilder<String>(
                        future: getTitle(videosList[index]),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Row(
                              children: <Widget>[
                                Expanded(
                                  child: title(snapshot.data!),
                                ),
                              ],
                            );
                          } else {
                            return Center(
                              child: CupertinoActivityIndicator(
                                color: Colors.white,
                              ),
                            );
                          }
                        }),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: WPConfig.primaryColor,
                    ),
                    height: 40,
                    padding: EdgeInsets.all(8),
                    width: 45,
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  isFeedEmpty() {
    return videosList.isEmpty;
  }

  body() {
    return isFeedEmpty()
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : RefreshIndicator(
            key: _refreshKey,
            child: list(),
            onRefresh: () async {
              return;
            },
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
        title: Text('Popular Videos',
            style: TextStyle(
                fontFamily: 'Avenir', fontSize: 17, color: Colors.white)),
        backgroundColor: WPConfig.primaryColor,
      ),
      body: body(),
    );
  }
}
