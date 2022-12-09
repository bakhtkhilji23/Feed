import 'package:flutter/material.dart';
import 'package:news_pro/config/wp_config.dart';
import 'package:news_pro/views/about_sg/components/dummy_text_widget.dart';
import 'package:news_pro/views/about_sg/components/education_widget.dart';

import 'components/biography_widget.dart';
import 'components/family_widget.dart';
import 'components/spiritual_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int indexTab = 0;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // scrolledUnderElevation: 4,
        backgroundColor: WPConfig.primaryColor,
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
          'About Suzanne',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontFamily: 'Avenir',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TabBar(
              onTap: (value) {
                setState(() {
                  indexTab = value;
                });
              },
              controller: tabController,
              isScrollable: true,
              unselectedLabelColor: const Color.fromRGBO(169, 184, 189, 1),
              labelColor: const Color.fromRGBO(50, 68, 82, 1),
              labelStyle: const TextStyle(
                fontSize: 16,
                fontFamily: 'Avenir',
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 16,
                fontFamily: 'Avenir',
              ),
              tabs: const [
                Text('Biography'),
                Text('Education'),
                Text('Spiritual'),
                Text('Documentary'),
                // Text('Family'),
              ],
            ),
            IndexedStack(
              index: indexTab,
              children: const [
                BiographyWidget(),
                EducationWidget(),
                SpiritualWidget(),
                FamilyWidget(),
                DummyTextWidget(
                  text:
                      'Spiritual\n\n Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s,',
                ),
                DummyTextWidget(
                  text:
                      'Family\n\n Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s,',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
