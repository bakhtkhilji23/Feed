import 'package:flutter/material.dart';
import 'package:news_pro/config/wp_config.dart';
import 'package:news_pro/views/ten_minutes_transformation/components/tab_body_widget.dart';
import 'package:news_pro/views/ten_minutes_transformation/models/book_model.dart';

List<BookModel> eBookBookInfoList = [
  BookModel(
    'Awakening',
    'assets/others/book_1.png',
    'Along with wisdom, inspiration, and lessons from the other side, Suzanne’s free e-book, “Awakening” contains a fascinating description of the afterlife that was given to Suzanne by her guides in spirit.',
    pdfPath: 'assets/others/Awakening-eBook_4.pdf',
  ),
  BookModel(
    'Mastering Meditation',
    'assets/others/book_2.png',
    'Mastering Meditation does not have to be complicated or time consuming, Suzanne shares her own experience, advice from her guides in spirit and many tools to help you get started with or expand your meditation practice.',
    pdfPath: 'assets/others/Mastering-Meditation-2020-1.pdf',
  ),
  BookModel(
    'Messages Of Hope',
    'assets/others/book_3.png',
    'Messages of Hope Booklet of Poems. The first year of daily messages from Suzanne’s guides were in the form of poems. A selection were brought together in a printed booklet. The original booklet is out of print.',
    pdfPath: 'assets/others/MOH-Booklet.3.pdf',
  ),
];

List<BookModel> mediationList = [
  BookModel(
    'Journey Of Remembrance',
    'assets/others/jor.png',
    'Feel the freedom from fear as Suzanne’s teachers in spirit – a group called Sanaya – take your hand and walk you through “The Sacred Seven” innate aspects of your soul.',
    soundcloud: '<iframe width="100%" height="166" scrolling="no" frameborder="no" allow="autoplay" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/791560699&color=a13a39&hide_related=true&show_comments=false&show_teaser=false"></iframe><div style="font-size: 10px; color: #cccccc;line-break: anywhere;word-break: normal;overflow: hidden;white-space: nowrap;text-overflow: ellipsis; font-family: Interstate,Lucida Grande,Lucida Sans Unicode,Lucida Sans,Garuda,Verdana,Tahoma,sans-serif;font-weight: 100;"><a href="https://soundcloud.com/user-445920771" title="Suzanne Giesemann" target="_blank" style="color: #cccccc; text-decoration: none;">Suzanne Giesemann</a> · <a href="https://soundcloud.com/user-445920771/journey-of-remembrance" title="Journey of Remembrance" target="_blank" style="color: #cccccc; text-decoration: none;">Journey of Remembrance</a></div>',
    youTubeLink: 'https://www.youtube.com/watch?v=x_J83Qid6Lg&feature=emb_logo&ab_channel=SuzanneGiesemann'
  ),
  BookModel(
    'BLESS ME Method',
    'assets/others/bless.png',
    '“BLESS ME” is a memory device in which each of the seven letters represents a specific stage of this simple meditative process. Each step flows seamlessly from one to the next.',
      pdfPath: 'assets/others/sample.pdf',
      youTubeLink: 'https://www.youtube.com/watch?v=vkD5gDeUeAc&ab_channel=SuzanneGiesemann'
  ),
  BookModel(
    'Journey Of Consciousness',
    'assets/others/joc.png',
    'Enjoy this inspired journey as you are led to the memory of who you really are as part of All That Is. Feel the incredible energy of peace and knowing as you are taken to the place of Oneness that is always within.',
      soundcloud: '<iframe width="100%" height="166" scrolling="no" frameborder="no" allow="autoplay" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/791560744&color=a13a39&hide_related=true&show_comments=false&show_teaser=false"></iframe><div style="font-size: 10px; color: #cccccc;line-break: anywhere;word-break: normal;overflow: hidden;white-space: nowrap;text-overflow: ellipsis; font-family: Interstate,Lucida Grande,Lucida Sans Unicode,Lucida Sans,Garuda,Verdana,Tahoma,sans-serif;font-weight: 100;"><a href="https://soundcloud.com/user-445920771" title="Suzanne Giesemann" target="_blank" style="color: #cccccc; text-decoration: none;">Suzanne Giesemann</a> · <a href="https://soundcloud.com/user-445920771/journey-of-consciousness" title="Journey Of Consciousness" target="_blank" style="color: #cccccc; text-decoration: none;">Journey Of Consciousness</a></div>',
      youTubeLink: 'https://www.youtube.com/watch?v=qLI3Ma8mIPk&feature=emb_logo&ab_channel=SuzanneGiesemann'
  ),
  BookModel(
      'Making The Connection',
      'assets/others/making.jpeg',
      'A 20-minute session to connect with higher consciousness and enjoy the experience of divine love while in a state of expanded awareness. You are invited to take a question into this state of communion and ask it as guided.',
      soundcloud: '<iframe width="100%" height="166" scrolling="no" frameborder="no" allow="autoplay" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/791717434&color=a13a39&hide_related=true&show_comments=false&show_teaser=false"></iframe><div style="font-size: 10px; color: #cccccc;line-break: anywhere;word-break: normal;overflow: hidden;white-space: nowrap;text-overflow: ellipsis; font-family: Interstate,Lucida Grande,Lucida Sans Unicode,Lucida Sans,Garuda,Verdana,Tahoma,sans-serif;font-weight: 100;"><a href="https://soundcloud.com/user-445920771" title="Suzanne Giesemann" target="_blank" style="color: #cccccc; text-decoration: none;">Suzanne Giesemann</a> · <a href="https://soundcloud.com/user-445920771/making-the-connection" title="Making the Connection" target="_blank" style="color: #cccccc; text-decoration: none;">Making the Connection</a></div>',
      youTubeLink: 'https://www.youtube.com/watch?v=qLI3Ma8mIPk&feature=emb_logo&ab_channel=SuzanneGiesemann'
  ),
  BookModel(
      '10-Minute Transformation',
      'assets/others/10.jpeg',
      'A guided experience of “sitting in the Power” to balance the seven main energy centers. The result is increased energy and an improved sense of well-being.',
      soundcloud: '<iframe width="100%" height="166" scrolling="no" frameborder="no" allow="autoplay" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/791717434&color=a13a39&hide_related=true&show_comments=false&show_teaser=false"></iframe><div style="font-size: 10px; color: #cccccc;line-break: anywhere;word-break: normal;overflow: hidden;white-space: nowrap;text-overflow: ellipsis; font-family: Interstate,Lucida Grande,Lucida Sans Unicode,Lucida Sans,Garuda,Verdana,Tahoma,sans-serif;font-weight: 100;"><a href="https://soundcloud.com/user-445920771" title="Suzanne Giesemann" target="_blank" style="color: #cccccc; text-decoration: none;">Suzanne Giesemann</a> · <a href="https://soundcloud.com/user-445920771/making-the-connection" title="Making the Connection" target="_blank" style="color: #cccccc; text-decoration: none;">Making the Connection</a></div>',

  ),
  BookModel(
      'SIP Of The Divine',
      'assets/others/sip.jpeg',
      'Suzanne shares a stunningly simple new method for training the mind to be still and connect to spirit at the same time. This tool was recently given to Suzanne by her guides in spirit. Watch now to find out why it is “SIP” and how it provides answers and peace in 3 minutes. You will be amazed and ready to make a “SIP of the Divine” your new daily habit.',
      youTubeLink: 'https://www.youtube.com/watch?v=1LPuE3rueVY&feature=emb_logo&ab_channel=SuzanneGiesemann'
  ),
  BookModel(
    'Radiant Heart',
    'assets/others/wolf.jpeg',
    'A powerful and healing meditation, taken from Suzanne’s book, Wolf’s Message, designed to bring you to a state of peace, balance, and alignment with the higher self.',
    soundcloud: '<iframe width="100%" height="166" scrolling="no" frameborder="no" allow="autoplay" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/791735788&color=a13a39&hide_related=true&show_comments=false&show_teaser=false"></iframe><div style="font-size: 10px; color: #cccccc;line-break: anywhere;word-break: normal;overflow: hidden;white-space: nowrap;text-overflow: ellipsis; font-family: Interstate,Lucida Grande,Lucida Sans Unicode,Lucida Sans,Garuda,Verdana,Tahoma,sans-serif;font-weight: 100;"><a href="https://soundcloud.com/user-445920771" title="Suzanne Giesemann" target="_blank" style="color: #cccccc; text-decoration: none;">Suzanne Giesemann</a> · <a href="https://soundcloud.com/user-445920771/radiant-heart-meditation" title="Radiant Heart Meditation" target="_blank" style="color: #cccccc; text-decoration: none;">Radiant Heart Meditation</a></div>',

  ),
  BookModel(
      'Heart Centered Meditation Tool',
      'assets/others/heart.jpeg',
      'Enjoy this meditation tool designed by Suzanne Giesemann and animated with the assistance of producer Chris Lavelle of North Island Media. The tool is silent. You may meditate in silence with it, or use any meditation you wish.',
      youTubeLink: 'https://www.youtube.com/watch?v=nz84S-HivZs&feature=emb_logo'
  ),
];
int selected = 0;

class TenMinutesStransformationPage extends StatefulWidget {
  const TenMinutesStransformationPage({Key? key}) : super(key: key);

  @override
  State<TenMinutesStransformationPage> createState() =>
      _TenMinutesStransformationPageState();
}

class _TenMinutesStransformationPageState
    extends State<TenMinutesStransformationPage> {
  List<String> tabs = ['E-books Gifts', 'Meditation Gifts'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: WPConfig.primaryColor,
        body: SafeArea(
          left: false,
          right: false,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
                    snap: true,
                    floating: true,
                    title: const Text(
                      'Tools for Awakened Living',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontFamily: 'Avenir',
                      ),
                    ),
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    pinned: true,
                    collapsedHeight: kToolbarHeight,
                    expandedHeight: 290.0,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: kToolbarHeight,
                              color: WPConfig.primaryColor,
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Text(
                                    'Gifts to Help You Connect with Spirit',
                                    textAlign: TextAlign.center,
                                    // style: headerTextStyle.copyWith(
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  const SizedBox(height: 15),
                                  const Text(
                                    'IT IS A BLESSING TO OFFER THESE GIFTS TO YOU. MAY YOU FEEL THE LOVING ENERGY IN WHICH THEY WERE CO-CREATED WITH MY TEAM IN SPIRIT.',
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    forceElevated: innerBoxIsScrolled,
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(1),
                      child: TabBar(
                        onTap: (value) {
                          setState(
                            () {
                              selected = value;
                            },
                          );
                        },
                        padding: EdgeInsets.zero,
                        tabs: [
                          Text(
                            'E-books Gifts',
                          ),
                          Text(
                            'Meditation Gifts',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                TabBodyWidget(
                  pdfPath: eBookBookInfoList[2].pdfPath,
                  books: List.generate(
                      eBookBookInfoList.length,
                      (index) => BookModel(
                            eBookBookInfoList[index].title,
                            eBookBookInfoList[index].image,
                            eBookBookInfoList[index].description,
                            pdfPath: eBookBookInfoList[index].pdfPath.toString(),
                      )),
                ),
                TabBodyWidget(
                  pdfPath: mediationList[2].pdfPath,
                  books: List.generate(
                      mediationList.length,
                      (index) => BookModel(
                            mediationList[index].title,
                            mediationList[index].image,
                            mediationList[index].description,
                            pdfPath: mediationList[index].pdfPath,
                            soundcloud: mediationList[index].soundcloud,
                            youTubeLink: mediationList[index].youTubeLink,
                          )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
