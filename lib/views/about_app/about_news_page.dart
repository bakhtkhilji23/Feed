import 'package:flutter/material.dart';
import 'package:news_pro/views/about_app/components/cards_slider.dart';
import 'package:news_pro/views/about_app/components/expandable_widget.dart';
import 'package:news_pro/views/about_app/components/one_numbered_widget.dart';
import 'package:news_pro/views/about_sg/components/biography_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../ten_minutes_transformation/ten_minutes_transformation_page.dart';

class AboutNewsPage extends StatefulWidget {
  const AboutNewsPage({Key? key}) : super(key: key);

  @override
  State<AboutNewsPage> createState() => _AboutNewsPageState();
}

class _AboutNewsPageState extends State<AboutNewsPage> {
  String id1 = '';
  String id2 = '';
  @override
  initState() {
    id1 = YoutubePlayer.convertUrlToId(
        'https://www.youtube.com/watch?v=La6HHyAD7Dk&t=2s')!;
    id2 = YoutubePlayer.convertUrlToId(
        'https://www.youtube.com/watch?v=vJupQzoMA34')!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff006199),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'The Awakened Way',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontFamily: 'Avenir',
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 30, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/others/ab.png',
                      fit: BoxFit.cover,
                      //height: 130,
                      width: MediaQuery.of(context).size.width * 0.70,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "A PATH TO KNOWING WHO YOU ARE AND WHY YOU’RE HERE.\nTHE AWAKENED WAY℠ IS NOT A SYSTEM, NOT A PROCESS, NOT A RELIGION. IT IS AN AWAKENED APPROACH TO LIVING A CONSCIOUSLY CONNECTED AND DIVINELY GUIDED LIFE.",
                    textAlign: TextAlign.center,

                    //todo changed here
                    // style: paragrahTextStyle,
                    style: TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w400, height: 2.5),
                  ),
                  const SizedBox(height: 35),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 22,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TenMinutesStransformationPage(),
                            ));
                      },
                      child: const Text(
                        'What is my first step?',
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Text(
                    'The Awakened Way Is Built Upon Three Basic Truths',
                    textAlign: TextAlign.center,
                    //TODO changed
                    //style: headerTextStyle.copyWith(
                    style: Theme.of(context)
                        .primaryTextTheme
                        .headlineSmall
                        ?.copyWith(
                          fontSize: 23,
                          color: Colors.black,
                          height: 1.5,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Freight',
                        ),
                    // style: TextStyle(
                    //   color: Colors.black,
                    // ),
                  ),
                  const SizedBox(height: 30),
                  const OneNumberedWidget(
                    number: '1',
                    text: 'You ',
                    text2: 'are not only human',
                  ),
                  const SizedBox(height: 6),
                  OneNumberedWidget(
                    number: '2',
                    text: 'You ',
                    text2: 'are part of one big web connecting\nall that is.',
                  ),
                  const SizedBox(height: 6),
                  OneNumberedWidget(
                    number: '3',
                    text: 'You ',
                    text2:
                        'find healing and connection through \nexpanded states of consciousness.',
                  ),
                  const SizedBox(height: 10),
                  VideoWidget(
                    videoId: id1,
                    margin: EdgeInsets.symmetric(vertical: 30.0),
                  ),
                  Text(
                    'The Keys To Finding Peace, Tranquility, And Freedom:',
                    textAlign: TextAlign.center,
                    //todo change
                    // style: headerTextStyle.copyWith(fontSize: 20),
                    style: Theme.of(context)
                        .primaryTextTheme
                        .headlineSmall
                        ?.copyWith(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Freight',
                            height: 1.5),

                  ),
                  const SizedBox(height: 30),
                  const ExpandableWidget(
                    header: 'Realize who you are.',
                    body:
                        'Who are you?  Despite appearances, you are not an independent being, but the interdependent manifestation of a shared Consciousness that is infinitely intelligent, creative, and self-aware.  As such, you do not operate apart from other, but as a direct part of a Power far greater than yourself.',
                    isExpanded: true,
                  ),
                  const SizedBox(height: 1),
                  const ExpandableWidget(
                    header: 'Balance your head with your heart.',
                    isExpanded: false,
                    body:
                        'As humans, we need to think, but when we balance thinking with feeling & knowing, we access higher wisdom.',
                  ),
                  const SizedBox(height: 1),
                  const ExpandableWidget(
                    isExpanded: false,
                    header: 'Rise above the duality and observe.',
                    body:
                        'When the drama of this “Earth School” gets to be too much, shift your identification to that of your True Nature, which is pure BE-ing. From this deeper neutral perspective, you can make wiser choices when you re-assume your story.',
                  ),
                  const SizedBox(height: 1),
                  const ExpandableWidget(
                    isExpanded: false,
                    header: 'Spend time with your Highest Self.',
                    body:
                        'The best way to get to know who you really are is to establish a regular practice of Presence and connecting with Higher Consciousness.',
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            CardsSlider(
              cards: [
                CardModel(image: 'assets/others/image (1).png'),
                CardModel(image: 'assets/others/image (2).png'),
                CardModel(image: 'assets/others/image (3).png'),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  const Text(
                    'SANAYA RECENTLY SHARED A STUNNING NEW PERSPECTIVE ON ONENESS.'
                    'OUR ENGLISH LANGUAGE SOMETIMES GETS IN THE WAY OF OUR UNDERSTANDING.  HEAR AN EXPLANATION OF OUR CONNECTION TO THE DIVINE AND TO EACH OTHER DIRECTLY FROM THE SPIRIT REALM. THIS IS LIFE-CHANGING.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      height: 2,
                    ),
                  ),
                  SizedBox(height: 30),
                  VideoWidget(
                    videoId: id2,
                    margin: EdgeInsets.zero,
                  ),
                  SizedBox(height: 30),
                  Text(
                    'You, Awakened!\n',
                    //TODO changed
                    //style: headerTextStyle.copyWith(
                    style: Theme.of(context)
                        .primaryTextTheme
                        .headlineSmall
                        ?.copyWith(
                      fontSize: 23,
                      color: Colors.black,
                      height: 1.5,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Freight',
                    ),
                  ),
                  const Text(
                    'YOU’RE ON THE SPIRITUAL PATH. YOU KNOW THERE’S MORE THAN “THIS.” '
                    '\n\nYOU WANT TO FEEL CONNECTED TO OTHERS AND TO SOMETHING OTHER THAN THIS PHYSICAL WORLD.'
                    '\n\nYOU WANT TO BE SUCCESSFUL, HAPPY, PEACEFUL, AND LIVE A LIFE FILLED WITH JOY.',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      // height: 2,
                    ),
                  ),
                  SizedBox(height: 15),
                  Image.asset(
                    'assets/others/spirit.jpeg',
                    fit: BoxFit.fitWidth,
                  ),
                  SizedBox(height: 15),
                  const Text(
                    'You’ve been to the workshops, attended the seminars, and read the books.  All that inspiration feels and sounds good, and then it’s back to “the real world” with the same old stress and the same “it doesn’t work” loop playing in your head.'
                        '\n\nYou are not the problem!  You are whole and complete already!  Albert Einstein hit the nail on the head when he said:'
                        '\n\n\“No problem can be solved from the same level of consciousness that created it.\”',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      // height: 2,
                    ),
                  ),
                  Text(
                    'How Are You, Awakened?',
                    style: Theme.of(context)
                        .primaryTextTheme
                        .headlineSmall
                        ?.copyWith(
                      fontSize: 23,
                      color: Colors.black,
                      height: 1.5,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Freight',
                    ),
                  ),
                  const Text(
                    '\nYOU HAVE A SENSE OF HUMOR AND DON’T TAKE YOURSELF TOO SERIOUSLY!'
                        '\n\nYou navigate the world and its complexities with ease, comfort, and grace.  Your mind is open, viewing the world from a place of love, curiosity, and passion. Relationships are experienced as an enhancement to your life regardless of their nature. Your heart is open, seeing yourself and all others from a place of compassion, kindness, and love. You are innately magnificent and you know it, shining your beautiful light into a world in need of hope and encouragement.',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 15),
                  Image.asset(
                    'assets/others/spirit.jpeg',
                    fit: BoxFit.fitWidth,
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Why Travel This Path With Suzanne?',
                    style: Theme.of(context)
                        .primaryTextTheme
                        .headlineSmall
                        ?.copyWith(
                      fontSize: 23,
                      color: Colors.black,
                      height: 1.5,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Freight',
                    ),
                  ),
                  const Text(
                    '\nIn both her military career and her work as a visionary way-shower,  Suzanne has learned to guide others in a way that few women do.  As a commanding officer and aide to the Chairman of the Joint Chiefs of Staff, she influenced decision-making at a global level. A woman of great integrity and passion, she touches the lives of tens of thousands on a daily basis with words of inspiration and guidance. Her heartfelt certainty that we can all live the life of The Awakened Way is supported by the superlative testimonials of those who have shared space with her.'
                        '\n\nHer explanation of our interconnectedness and the web of consciousness is insightful and backed up by her experiences in the evidence-based connection with higher consciousness she enjoys. Countless followers report lives utterly transformed by her work. Whether reading her books, attending workshops, conferences, mentoring, or retreats, Suzanne inspires and comforts, assures and promises that life can be magical despite outward circumstances.'
                        '\n\nSuzanne acts as a kind of tuning fork, bringing all who hear her into greater resonance with who we really are: human and spirit, heart and soul. Unleash your own magnificence and shine onto the world.'
                        '\n\n\"Suzanne is described as \'...such a bright light in this world that people can\'t help but be drawn to it\'. Right on - spiritually and intellectually stimulating and in the top tier of World Class speakers\”',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
