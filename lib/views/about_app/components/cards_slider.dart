import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class CardsSlider extends StatefulWidget {
  const CardsSlider({
    Key? key,
    required this.cards,
  }) : super(key: key);

  final List<CardModel> cards;

  @override
  State<CardsSlider> createState() => _OnePackagePhotosCarouselState();
}

class _OnePackagePhotosCarouselState extends State<CardsSlider> {
  ScrollController controller = ScrollController();
  int current = 0;
  double? height;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback(
      (_) {
        Future.delayed(const Duration(milliseconds: 150));
        setState(() {
          height = context.size?.height != null
              ? (context.size?.height)! * 1.5
              : 0.0;
          debugPrint('Height: $height');
        });
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    controller.addListener(
      () {
        final result = controller.position.pixels /
            (MediaQuery.of(context).size.width * 0.5);

        debugPrint('result: $result');
        debugPrint('all: ${widget.cards.length}');

        if (result.toInt() <= widget.cards.length) {
          setState(() {
            current = result.toInt();
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SingleChildScrollView(
          controller: controller,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: widget.cards
                .map((e) => SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: 600,
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
                        elevation: 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(e.image,
                              fit: BoxFit.fitHeight,
                            ),
                          ],
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),

        // CarouselSlider.builder(
        //   carouselController: controller,
        //   options: CarouselOptions(
        //     viewportFraction: 0.8,
        //     autoPlay: true,
        //     enlargeCenterPage: true,
        //     height: height,
        //     enlargeStrategy: CenterPageEnlargeStrategy.height,
        //     autoPlayAnimationDuration: const Duration(milliseconds: 2000),
        //     onPageChanged: (index, reason) {
        //       setState(() {
        //         current = index;
        //       });
        //     },
        //   ),
        //   itemCount: widget.cards.length,
        //   itemBuilder: (context, index, pageViewIndex) {
        //     return Card(
        //       margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        //       color: Colors.white,
        //       elevation: 5,
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(15),
        //       ),
        //       child: Padding(
        //         padding: const EdgeInsets.all(20),
        //         child: Column(
        //           children: [
        //             Text(
        //               widget.cards[index].title,
        //               style:
        //                   headerTextStyle.copyWith(fontWeight: FontWeight.bold),
        //             ),
        //             const SizedBox(height: 16),
        //             Text(
        //               widget.cards[index].body,
        //               style:
        //                   headerTextStyle.copyWith(fontWeight: FontWeight.w500),
        //             ),
        //           ],
        //         ),
        //       ),
        //     );
        //   },
        // ),

        const SizedBox(height: 20),
        DotsIndicator(
          position: current.toDouble(),
          dotsCount: widget.cards.length,
          decorator: DotsDecorator(
            activeColor: const Color(0xFFe8ddc5),
            color: Colors.grey.shade100,
            size: const Size.square(15),
            activeSize: const Size.square(15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: const BorderSide(
                color: Color(0xFFe8ddc5),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CardModel {
  CardModel({
    required this.image,
  });

  final String image;
}
