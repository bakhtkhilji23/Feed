import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:news_pro/views/ten_minutes_transformation/models/book_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../about_sg/components/biography_widget.dart';
import '../../pdf_viewer/pdf_viewer_page.dart';
import '../ten_minutes_transformation_page.dart';

class TabBodyWidget extends StatelessWidget {
  const TabBodyWidget({
    Key? key,
    required this.books,
    this.pdfPath,
  }) : super(key: key);

  final List<BookModel> books;
  final pdfPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            SliverToBoxAdapter(
              child: ListView.separated(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: books.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        books[index].title,

                        // TODO changed here
                        // style: headerTextStyle.copyWith(
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w500,
                                ),
                      ),
                      const SizedBox(height: 20),
                      Image.asset(
                        books[index].image,
                        width: 200,
                      ),
                      const SizedBox(height: 20),
                      Text(books[index].description),
                      if(books[index].pdfPath != null)
                        const SizedBox(height: 20),
                      if(books[index].pdfPath != null)
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 22,
                            ),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () async {
                            // final file = createFilefromAsset(
                            //     'assets/others/sample.pdf', books[index].title);

                            //final String path = await file.path;
                            print('PATH++>${pdfPath.toString()}');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PdfViewerPage(
                                  index: selected == 0
                                      ? eBookBookInfoList[index].pdfPath
                                      : mediationList[index].pdfPath,
                                  path: pdfPath.toString(),
                                  name: books[index].title,
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'Read now',
                          ),
                        ),
                      const SizedBox(height: 20),
                      if(books[index].soundcloud != null)
                      Center(
                        child: Html(
                          data: books[index].soundcloud,
                          shrinkWrap: true,
                          style: {
                            'body': Style(
                              margin: EdgeInsets.zero,
                              padding: EdgeInsets.zero,
                              fontSize: FontSize(
                                  Theme.of(context).textTheme.headline4?.fontSize ?? 24),
                              maxLines: 1,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            'figure': Style(
                              margin: EdgeInsets.zero,
                              padding: EdgeInsets.zero,
                            ),
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      if(books[index].youTubeLink != null && books[index].youTubeLink != '')
                      VideoWidget(videoId: YoutubePlayer.convertUrlToId(books[index].youTubeLink.toString())!,margin: EdgeInsets.zero),
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 40);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
