import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../../../../core/constants/constants.dart';
import 'app_shimmer.dart';

class DummyArticleTileLarge extends StatelessWidget {
  const DummyArticleTileLarge({
    Key? key,
    this.isEnabled = true,
  }) : super(key: key);

  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDefaults.margin / 2),
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: AppDefaults.borderRadius,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: AppDefaults.boxShadow,
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(AppDefaults.radius),
                      topRight: Radius.circular(AppDefaults.radius),
                    ),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: AppShimmer(
                        enabled: isEnabled,
                        child: Container(
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                      ),
                    ),
                  ),
                  AppSizedBox.h10,
                  AppShimmer(
                    enabled: isEnabled,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      margin: const EdgeInsets.symmetric(
                          horizontal: AppDefaults.margin,
                          vertical: AppDefaults.margin / 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: AppDefaults.borderRadius,
                      ),
                      child: Text(
                        'A Very Simple Title and Effective one with',
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 1,
                      ),
                    ),
                  ),
                  AppSizedBox.h5,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            AppShimmer(
                              enabled: isEnabled,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: AppDefaults.borderRadius,
                                ),
                                child: const Icon(
                                  IconlyLight.timeCircle,
                                  color: AppColors.placeholder,
                                  size: 18,
                                ),
                              ),
                            ),
                            AppSizedBox.w5,
                            AppShimmer(
                              enabled: isEnabled,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: AppDefaults.borderRadius,
                                ),
                                child: Text(
                                  '0 Minute Read',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ),
                            ),
                          ],
                        ),
                        AppSizedBox.w16,
                        Row(
                          children: [
                            AppShimmer(
                              enabled: isEnabled,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: AppDefaults.borderRadius,
                                ),
                                child: const Icon(
                                  IconlyLight.timeCircle,
                                  color: AppColors.placeholder,
                                  size: 18,
                                ),
                              ),
                            ),
                            AppSizedBox.w10,
                            AppShimmer(
                              enabled: isEnabled,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: AppDefaults.borderRadius,
                                ),
                                child: Text(
                                  '0 Minute Read',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  AppSizedBox.h16,
                ],
              ),
              Positioned(
                right: 10,
                top: 0,
                child: /* <---- Category List -----> */
                    SingleChildScrollView(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      3,
                      (index) => AppShimmer(
                        enabled: isEnabled,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          margin: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: AppDefaults.borderRadius,
                          ),
                          child: const Text('Level'),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: AppShimmer(
                  enabled: isEnabled,
                  child: const Icon(IconlyLight.heart),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
