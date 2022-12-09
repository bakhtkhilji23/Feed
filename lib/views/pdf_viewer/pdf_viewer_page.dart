import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_pro/config/wp_config.dart';
import 'package:news_pro/views/ten_minutes_transformation/models/book_model.dart';

class PdfViewerPage extends StatefulWidget {
  final String name;
  final String path;
  final index;

  const PdfViewerPage({
    Key? key,
    required this.path,
    required this.name,
    this.index,
  }) : super(key: key);

  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage>
    with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        centerTitle: true,
        title: Text(
          widget.name,
          //todo changed
          // style: headerAvenirStyle,
          style: Theme.of(context).primaryTextTheme.headlineSmall,
        ),
      ),
      body: Stack(
        children: <Widget>[
          // PDFView(
          //   filePath: widget.path,
          //   enableSwipe: true,
          //   swipeHorizontal: false,
          //   autoSpacing: false,
          //   pageFling: true,
          //   pageSnap: true,
          //   defaultPage: currentPage!,
          //   fitPolicy: FitPolicy.BOTH,
          //   preventLinkNavigation:
          //       false, // if set to true the link is handled in flutter
          //   onRender: (pages) {
          //     setState(() {
          //       this.pages = pages;
          //       isReady = true;
          //       isLastPage = pages == 1;
          //     });
          //   },
          //   onError: (error) {
          //     setState(() {
          //       errorMessage = error.toString();
          //     });
          //     print(error.toString());
          //   },
          //   onPageError: (page, error) {
          //     setState(() {
          //       errorMessage = '$page: ${error.toString()}';
          //     });
          //     print('$page: ${error.toString()}');
          //   },
          //   onViewCreated: (PDFViewController pdfViewController) {
          //     _controller.complete(pdfViewController);
          //   },
          //   onLinkHandler: (String? uri) {
          //     print('goto uri: $uri');
          //   },
          //   onPageChanged: (int? page, int? total) {
          //     print('page change: $page/$total');
          //     setState(() {
          //       currentPage = page;
          //       isLastPage = page == ((total ?? 1) - 1);
          //     });
          //   },
          // ),

          PDF(
            enableSwipe: true,
            swipeHorizontal: true,
            autoSpacing: false,
            pageFling: false,
            onRender: (pages) {
              setState(() {
                this.pages = pages;
                isReady = true;
                isLastPage = pages == 1;
              });
            },
            onError: (error) {
              print(error.toString());
            },
            onPageError: (page, error) {
              print('$page: ${error.toString()}');
            },
            onPageChanged: (int? page, int? total) {
              print('page change: $page/$total');
              setState(() {
                currentPage = page;
                isLastPage = page == ((total ?? 1) - 1);
              });
            },
            onViewCreated: (PDFViewController pdfViewController) {
              _controller.complete(pdfViewController);
            },
          ).fromAsset(widget.index.toString()),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: EdgeInsets.only(top: 15, right: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFF00619A),
              ),
              padding: EdgeInsets.all(10),
              child: Text(
                '$currentPage/$pages',
                style: TextStyle(fontFamily: 'Avnier', fontSize: 17,color: Color(
                    0xffffffff), ),
              ),
            ),
          ),
          errorMessage.isEmpty
              ? !isReady
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container()
              : Center(
                  child: Text(errorMessage),
                ),
        ],
      ),
      floatingActionButton: FutureBuilder<PDFViewController>(
        future: _controller.future,
        builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
          debugPrint('Rebuild float button');
          if (snapshot.hasData && !isLastPage) {
            // int total =
            //     snapshot.data!.getPageCount().then((value) => value) ;
            return ButtonBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.first_page),
                  onPressed: () async {
                    await snapshot.data!.setPage(1);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () async {
                    await snapshot.data!.setPage(currentPage! - 1);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () async {
                    await snapshot.data!.setPage(currentPage! + 1);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.last_page),
                  onPressed: () async {
                    await snapshot.data!.setPage(pages!);
                  },
                ),
              ],
            );

            // return FloatingActionButton.extended(
            //   label: const Text('Go to next page'),
            //   onPressed: () async {
            //     await snapshot.data!.setPage(currentPage! + 1);
            //   },
            // );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
