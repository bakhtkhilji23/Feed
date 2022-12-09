import 'package:flutter/material.dart';
import 'package:news_pro/config/wp_config.dart';
import 'package:news_pro/views/about_sg/components/dummy_text_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SpiritualWidget extends StatelessWidget {
  const SpiritualWidget({
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
          Text(
            'The tragic death of Suzanne’s step-daughter, Susan, a sergeant in the Marine Corps who was struck and killed by lightning along with her unborn son, propelled Suzanne in a new direction in search of life’s deepest truths. When she first began researching and writing the Hay House published book, The Priest and the Medium, she never dreamed that she would one day connect with the unseen world herself.',
            style: TextStyle(
              fontSize: 16.5,
              fontFamily: 'Avenir',
              wordSpacing: 1.3,
              letterSpacing: 0.7,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'After years of meditation, she began to have intuitive experiences, which led her to several classes on mediumship and to an intensive course at the respected Arthur Findlay College of Psychic Sciences in Stansted, England. Her eye-opening experiences there allowed her to develop her contact with the unseen world to the point where she is now in demand for her readings and her classes in evidence-based mediumship.',
            style: TextStyle(
              fontSize: 16.5,
              fontFamily: 'Avenir',
              wordSpacing: 1.3,
              letterSpacing: 0.7,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Suzanne receives messages daily from her guides in spirit, a group of advanced teachers known as Sanaya. These are published daily on her blog, The Daily Way, as well as her Facebook Page.',
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
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Text(
          'Spiritual',
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
                  'assets/others/spirit.jpeg',
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
