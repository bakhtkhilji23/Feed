import 'package:flutter/material.dart';
import 'package:news_pro/config/wp_config.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'biography_widget.dart';

class FamilyWidget extends StatelessWidget {
  const FamilyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ImageWidget(),
        NameWidget(),
        SizedBox(
          height: 10,
        ),
        InfoWidget(),
      ],
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
          const Text(
            'This award-winning documentary has been shown to audiences around the globe in private viewings. It was selected as one of only 20 films worldwide to be featured at the Awakened World International Film Festival. After showings on the big screen and at 8 international film festivals, the documentary is now available on Amazon Prime.\n\nEnjoy these short clips as Suzanne introduces “Messages of Hope – The Documentary” and shares a behind-the-scenes magical moment that you won’t see in the documentary.',
            style: TextStyle(
              fontSize: 16.5,
              fontFamily: 'Avenir',
              wordSpacing: 1.3,
              letterSpacing: 0.7,
              height: 1.2,

            ),
          ),
          VideoWidget(videoId: YoutubePlayer.convertUrlToId('https://www.youtube.com/watch?v=Wh66XXBoLB0&feature=emb_logo&ab_channel=SuzanneGiesemann')!,margin: EdgeInsets.symmetric(vertical: 10)),
          VideoWidget(videoId: YoutubePlayer.convertUrlToId('https://www.youtube.com/watch?v=-6XEeTvYFPA&feature=emb_logo&ab_channel=SuzanneGiesemann')!,margin: EdgeInsets.symmetric(vertical: 10)),
          VideoWidget(videoId: YoutubePlayer.convertUrlToId('https://www.youtube.com/watch?v=5jJnXvT92FA&feature=emb_logo&ab_channel=SuzanneGiesemann')!,margin: EdgeInsets.symmetric(vertical: 10)),
          const Text(
            'Enjoy Suzanne’s introduction of “Messages of Hope” given before one of the live viewings.',
            style: TextStyle(
              fontSize: 16.5,
              fontFamily: 'Avenir',
              wordSpacing: 1.3,
              letterSpacing: 0.7,
              height: 1.2,

            ),
          ),
          VideoWidget(videoId: YoutubePlayer.convertUrlToId('https://www.youtube.com/watch?v=lZKRbE1ykWo&feature=emb_logo&ab_channel=SuzanneGiesemann')!,margin: EdgeInsets.symmetric(vertical: 10)),
          const Text(
            'Suzanne shares thoughts and questions for you after viewing the documentary.'
                '\n\nThis documentary was produced by Chris Lavelle. Chis and Suzanne shared the spotlight on the red carpet during the Awakened World Film Festival.',
            style: TextStyle(
              fontSize: 16.5,
              fontFamily: 'Avenir',
              wordSpacing: 1.3,
              letterSpacing: 0.7,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 10,),
          Image.asset(
            'assets/others/doc1.jpeg',
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 10,),
          const Text('The documentary premiered in The Villages, FL on April 23 and 24, 2012 to a sold-out theater on both days.',
            style: TextStyle(
              fontSize: 16.5,
              fontFamily: 'Avenir',
              wordSpacing: 1.3,
              letterSpacing: 0.7,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 10,),
          Image.asset(
            'assets/others/doc2.jpg',
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 10,),
          const Text('This documentary is perfect for people in our lives who don\’t understand our interest in mediumship or the afterlife. It takes the ‘scary’ out and helps them wrap their heads around it” ( this must be italic)',
            style: TextStyle(
              fontSize: 16.5,
              fontFamily: 'Avenir',
              wordSpacing: 1.3,
              letterSpacing: 0.7,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 20,),
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
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Text(
          'Documentary',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Freight',
            fontWeight: FontWeight.w500,
          ),
        ),
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
                  'assets/others/mag.png',
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
