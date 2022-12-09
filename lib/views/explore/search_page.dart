import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import '../../core/ads/ad_state_provider.dart';
import '../../core/components/banner_ad.dart';
import '../../core/constants/constants.dart';
import '../../core/controllers/posts/search_post_controller.dart';
import '../../core/models/article.dart';
import '../../core/repositories/posts/post_repository.dart';
import '../../core/utils/app_utils.dart';
import 'components/search_history_list.dart';
import 'components/search_text_field.dart';
import 'components/searched_article_list.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  late TextEditingController _query;

  bool _isSearching = false;
  bool _isOnHistory = true;
  List<ArticleModel> _searchedList = [];

  final _formKey = GlobalKey<FormState>();

  _search() async {
    // print(dateRange?.start);
    // print(dateRange?.end);

    bool isValid = _formKey.currentState?.validate() ?? false;
    if (isValid || (dateRange?.start != null && dateRange?.end != null)) {
      AppUtil.dismissKeyboard(context: context);
      _isSearching = true;
      _isOnHistory = false;
      if (mounted) setState(() {});
      final repo = ref.read(postRepoProvider);
      _searchedList = await repo.searchPost(
          keyword: _query.text, start: dateRange?.start, end: dateRange?.end);
      ref.read(searchHistoryController.notifier).addEntry(_query.text);
      _isSearching = false;
      if (mounted) setState(() {});
    }
  }

  final GlobalKey<AnimatedListState> _animatedListKey =
      GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    _query = TextEditingController();
  }

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  DateTimeRange? dateRange;

  String getFrom() {
    if (dateRange == null) {
      return 'From';
    } else {
      return DateFormat('yMd').format(dateRange!.start);
    }
  }

  String getUntil() {
    if (dateRange == null) {
      return 'Until';
    } else {
      return DateFormat('yMd').format(dateRange!.end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF006199),
        title: const Text(
          'Filter',
          style: TextStyle(
            fontFamily: 'Avenir',
            color: Colors.white,
            fontSize: 17,
          ),
        ),
        actions: [
          _isOnHistory
              ? const SizedBox()
              : IconButton(
                  onPressed: () => setState(() {
                    _isOnHistory = true;
                    ref.read(loadInterstitalAd);
                  }),
                  icon: const Icon(IconlyLight.timeSquare,
                      color: Color(0xFF006199)),
                )
        ],
      ),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: AnimationConfiguration.toStaggeredList(
              childAnimationBuilder: (widget) => SlideAnimation(
                duration: AppDefaults.duration,
                verticalOffset: 50,
                child: widget,
              ),
              children: [
                const SizedBox(
                  height: 16,
                ),
                // const Padding(
                //   padding: EdgeInsets.only(left: 10.0),
                //   child: Text(
                //     'Popular Tags',
                //     style: TextStyle(
                //         color: AppColors.primary,
                //         fontSize: 18,
                //         fontWeight: FontWeight.w500,
                //         fontFamily: 'Freight'),
                //   ),
                // ),
                // const SizedBox(
                //   height: 8,
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Wrap(
                //     children: [
                //       for (var i = 1; i < 12; i++)
                //         Container(
                //           margin: const EdgeInsets.only(right: 8.0, bottom: 8),
                //           height: 42,
                //           width: 80,
                //           decoration: BoxDecoration(
                //             color: i % 3 == 0
                //                 ? const Color(0xFFF7F8FA)
                //                 : const Color(0xFFF5E6C9),
                //             borderRadius: BorderRadius.circular(8),
                //           ),
                //           child: const Center(
                //             child: Text(
                //               'Tag',
                //             ),
                //           ),
                //         ),
                //     ],
                //   ),
                // ),

                const Padding(
                  padding: EdgeInsets.only(left: 12.0, top: 12),
                  child: Text(
                    'Filter By Date',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Freight',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    width: 375,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF1F7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 8,
                          ),
                          GestureDetector(
                            onTap: () => pickDateRange(context),
                            child: Text(
                              getFrom(),
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          const Icon(
                            IconlyLight.arrowRight,
                            color: AppColors.primary,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          GestureDetector(
                            onTap: () => pickDateRange(context),
                            child: Text(
                              getUntil(),
                            ),
                          ),
                          const Spacer(),
                          // const SizedBox(
                          //   width: 100,
                          // ),
                          GestureDetector(
                            onTap: () => pickDateRange(context),
                            child: const Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: Icon(
                                IconlyLight.calendar,
                                color: AppColors.primary,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(left: 12.0, top: 12),
                  child: Text(
                    'Search',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Freight',
                    ),
                  ),
                ),
                SearchTextFieldWithButton(
                  formKey: _formKey,
                  onSubmit: () => _search(),
                  controller: _query,
                  dateChosen: (dateRange == null) ? false : true,
                ),
                const Divider(),
                const BannerAdWidget(paddingVertical: 0),

                /// Page Swtich Animation
                PageTransitionSwitcher(
                  duration: AppDefaults.duration,
                  transitionBuilder: ((child, primaryAnimation,
                          secondaryAnimation) =>
                      SharedAxisTransition(
                        animation: primaryAnimation,
                        secondaryAnimation: secondaryAnimation,
                        transitionType: SharedAxisTransitionType.vertical,
                        fillColor: Theme.of(context).scaffoldBackgroundColor,
                        child: child,
                      )),
                  child: _isOnHistory
                      ? SearchHistoryList(
                          animatedListKey: _animatedListKey,
                          onTap: (v) {
                            _query.text = v;
                            _search();
                          },
                        )
                      : SearchedArticleList(
                          searchedList: _searchedList,
                          isSearching: _isSearching),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future pickDateRange(BuildContext context) async {
    final initialDateRange = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now().add(const Duration(hours: 24 * 3)),
    );
    final newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDateRange: dateRange ?? initialDateRange,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (newDateRange == null) return;

    setState(
      () => dateRange = newDateRange,
    );
  }
}
