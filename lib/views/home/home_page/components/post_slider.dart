import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../core/components/app_shimmer.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/models/article.dart';
import '../../../../core/routes/app_routes.dart';
import 'active_indicator_feature_post.dart';
import 'feature_post_article.dart';

class PostSlider extends StatefulWidget {
  const PostSlider({
    Key? key,
    required this.articles,
  }) : super(key: key);

  final List<ArticleModel> articles;

  @override
  State<PostSlider> createState() => _PostSliderState();
}

class _PostSliderState extends State<PostSlider> {
  late PageController _controller;

  int _currentIndex = 0;

  _onPageChange(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      viewportFraction: 0.9,
      initialPage: _currentIndex,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: AnimationLimiter(
            child: PageView.builder(
              controller: _controller,
              itemCount: widget.articles.length,
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: FadeInAnimation(
                    child: FeaturedPostArticle(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.post,
                            arguments: widget.articles[index]);
                      },
                      isActive: _currentIndex == index,
                      article: widget.articles[index],
                    ),
                  ),
                );
              },
              onPageChanged: _onPageChange,
            ),
          ),
        ),

        /// Active Indicators
        Padding(
          padding: const EdgeInsets.all(AppDefaults.margin / 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.articles.length,
              (index) => ActiveIndicatorRect(
                isActive: _currentIndex == index,
              ),
            ).toList(),
          ),
        ),
      ],
    );
  }
}

/// Used for loading
class DummyPostSlider extends StatefulWidget {
  const DummyPostSlider({
    Key? key,
    this.totalPages = 4,
  }) : super(key: key);

  final int totalPages;

  @override
  State<DummyPostSlider> createState() => _DummyPostSliderState();
}

class _DummyPostSliderState extends State<DummyPostSlider> {
  late PageController _controller;

  int _currentIndex = 1;

  _onPageChange(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      viewportFraction: 0.9,
      initialPage: _currentIndex,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.totalPages,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: FadeInAnimation(
                  child: AppShimmer(
                    child: AnimatedContainer(
                      duration: AppDefaults.duration,
                      margin: EdgeInsets.symmetric(
                        horizontal: AppDefaults.padding / 2,
                        vertical: index == _currentIndex ? 8.0 : 16,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: AppDefaults.borderRadius,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            },
            onPageChanged: _onPageChange,
          ),
        ),

        /// Active Indicators
        Padding(
          padding: const EdgeInsets.all(AppDefaults.margin / 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.totalPages,
              (index) => ActiveIndicatorRect(
                isActive: _currentIndex == index,
              ),
            ).toList(),
          ),
        ),
      ],
    );
  }
}
