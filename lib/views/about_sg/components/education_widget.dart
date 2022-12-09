import 'package:flutter/material.dart';
import 'package:news_pro/config/wp_config.dart';
import 'package:news_pro/views/about_sg/components/dummy_text_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class EducationWidget extends StatelessWidget {
  const EducationWidget({
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
    return const Padding(
      padding: EdgeInsets.only(left: 25, right: 25, top: 10),
      child: Text(
        'Suzanne has a Bachelor’s Degree in foreign languages and speaks fluent Spanish She earned a Master’s Degree in National Security Affairs. In addition to her command tour and duties as special assistant to the Chief of Naval Operations, and ultimately as aide to the Chairman of the Joint Chiefs of Staff, she served tours in naval intelligence, taught political science at the U.S. Naval Academy, and was a plans and policy officer for the U.S. Southern Command. Her overseas assignments were in Panama and Japan. Her military decorations include the Combat Action Ribbon and the Defense Superior Service Medal.',
        style: TextStyle(
          fontSize: 16.5,
          fontFamily: 'Avenir',
          wordSpacing: 1.3,
          letterSpacing: 0.7,
          height: 1.2,
        ),
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
          'Education',
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
                  'assets/others/education.jpeg',
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
