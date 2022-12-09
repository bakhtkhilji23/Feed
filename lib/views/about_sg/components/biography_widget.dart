import 'package:flutter/material.dart';
import 'package:news_pro/config/wp_config.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BiographyWidget extends StatelessWidget {
  const BiographyWidget({
    Key? key,
  }) : super(key: key);

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ImageWidget(),
        const NameWidget(),
        const InfoWidget(),
        VideoWidget(videoId: 'Kb1prDWp6X8'),
        const Padding(
          padding: EdgeInsets.only(left: 25, right: 25, top: 0),
          child: Text(
            'She is a member of the Evolutionary Leaders Circle, a group of thought leaders from diverse disciplines who come together to help support a global shift in consciousness.',
            style: TextStyle(
              fontSize: 16.5,
              fontFamily: 'Avenir',
              wordSpacing: 1.3,
              letterSpacing: 0.7,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 25, right: 25, top: 20),
          child: Text(
            "Suzanne leads both online and in-person classes, workshops and retreats, teaching people around the world about their true nature and how to connect with higher consciousness.  She serves as faculty with The Shift Network and with Humanity’s Team, sharing the mission of helping people throughout the world awaken to the interconnectedness of all life.",
            style: TextStyle(
              fontSize: 16.5,
              fontFamily: 'Avenir',
              wordSpacing: 1.3,
              letterSpacing: 0.7,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 25, right: 25, top: 20),
          child: Text(
            "Suzanne is the founder of The Awakened Way™, a path to living a consciously connected and divinely guided life.  She is the creator of the BLESS ME© method of connecting to Higher Consciousness and the popular SIP of the Divine© meditation.  Suzanne’s gift of communication with those on the other side has been verified and recognized as highly credible by noted afterlife researchers. Her messages bring not only hope, but healing and love that go straight to the heart.",
            style: TextStyle(
              fontSize: 16.5,
              fontFamily: 'Avenir',
              wordSpacing: 1.3,
              letterSpacing: 0.7,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 25, right: 25, top: 20),
          child: Text(
            "For the many gifts Suzanne’s work offers, please visit-",
            style: TextStyle(
              fontSize: 16.5,
              fontFamily: 'Avenir',
              wordSpacing: 1.3,
              letterSpacing: 0.7,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 25, right: 25, top: 0),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/icons/website.svg',
                color: WPConfig.primaryColor,
                width: 20,
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  launchUrl(Uri.parse('https://www.suzannegiesemann.com'));
                },
                child: Text(
                  "www.suzannegiesemann.com",
                  style: TextStyle(
                    fontSize: 16.5,
                    fontFamily: 'Avenir',
                    wordSpacing: 1.3,
                    letterSpacing: 0.7,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}

class VideoWidget extends StatefulWidget {
  const VideoWidget({
    Key? key,
    required this.videoId,
    this.autoPlay = false,
    this.margin = const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
  }) : super(key: key);

  final String videoId;
  final bool autoPlay;
  final EdgeInsetsGeometry margin;

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late final YoutubePlayerController youtubeController;

  @override
  void initState() {
    super.initState();

    youtubeController = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(
        autoPlay: widget.autoPlay,
      ),
    );
  }

  @override
  void dispose() {
    youtubeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin,
      child: YoutubePlayer(
        controller: youtubeController,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.grey.shade400,
        topActions: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                youtubeController.metadata.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
        bottomActions: [
          CurrentPosition(),
          ProgressBar(
            isExpanded: true,
            controller: youtubeController,
            colors: const ProgressBarColors(
              playedColor: WPConfig.primaryColor,
              handleColor: Colors.amberAccent,
            ),
          ),
          RemainingDuration(),
          const PlaybackSpeedButton(),
        ],
      ),
    );
  }
}

class InfoWidget extends StatelessWidget {
  const InfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25, right: 25, top: 10),
      child: Column(
        children: [
          Text(
            'Suzanne Is Recognized On Watkins’ Mind Body Spirit Magazine’s 2022 List Of The 100 Most Spiritually Influential Living People.\n',
            style: TextStyle(
              fontSize: 16.5,
              fontFamily: 'Avenir',
              wordSpacing: 1.3,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.7,
            ),
          ),
          Image.asset(
            'assets/others/mag.png',
            fit: BoxFit.cover,
          ),
          Text(
            ' \n\“You can imagine my emotions when the 2022 Watkins list was announced and I saw my name there with many who have inspired me through the years. I do believe this is the greatest honor of my life to date.\” – Suzanne',
            style: TextStyle(
              fontSize: 16.5,
              fontFamily: 'Avenir',
              wordSpacing: 1.3,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.7,
            ),
          ),

          Text(
            '\nSuzanne Giesemann is a spiritual teacher, author, and Messenger of Hope who guides people to the certainty that love never dies and that we are part of a multidimensional universe.  She is recognized on Watkins’ Mind Body Spirit Magazine’s 2022 list of the 100 Most Spiritually Influential Living People.',
            style: TextStyle(
              fontSize: 16.5,
              fontFamily: 'Avenir',
              wordSpacing: 1.3,
              letterSpacing: 0.7,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Suzanne is a former U.S. Navy Commander, commanding officer, and aide to the Chairman of the Joint Chiefs of Staff.  Her transition from senior military officer to her current work is featured in the award-winning documentary, Messages of Hope, based on her memoir by the same name.  She has authored 13 books and written and narrated 6 Hemi-Sync recordings.  She produces the Daily Way inspirational messages read by tens of thousands each day and hosts the top-ranking weekly Messages of Hope podcast.  She is a sought-after keynote speaker at major international conferences, and her many YouTube videos have reached millions of viewers.',
            style: TextStyle(
              fontSize: 16.5,
              fontFamily: 'Avenir',
              wordSpacing: 1.3,
              letterSpacing: 0.7,
            ),
          ),
        ],
      ),
    );
  }
}

class NameWidget extends StatelessWidget {
  const NameWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Suzanne Giesemann ',
            style: TextStyle(
              fontSize: 23,
              fontFamily: 'Freight',
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: WPConfig.primaryColor,
                  width: 3,
                )),
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.asset(
                  'assets/others/about.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
