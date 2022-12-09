import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../config/app_images_config.dart';
import '../../../core/components/app_shimmer.dart';
import '../../../core/constants/constants.dart';
import '../../../core/models/category.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    Key? key,
    required this.categoryModel,
    this.backgroundImage,
    required this.onTap,
  }) : super(key: key);

  final CategoryModel categoryModel;
  final String? backgroundImage;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppDefaults.margin / 2,
        horizontal: AppDefaults.margin,
      ),
      child: ClipRRect(
        borderRadius: AppDefaults.borderRadius,
        child: CachedNetworkImage(
          imageUrl: backgroundImage ?? AppImagesConfig.defaultCategoryImage,
          imageBuilder: (context, imageProvider) => _CategoryImageWrapper(
            backgroundImage: imageProvider,
            onTap: onTap,
            categoryModel: categoryModel,
          ),
          placeholder: (context, url) => AppShimmer(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.16,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}

class _CategoryImageWrapper extends StatelessWidget {
  const _CategoryImageWrapper({
    Key? key,
    required this.backgroundImage,
    required this.onTap,
    required this.categoryModel,
  }) : super(key: key);

  final ImageProvider backgroundImage;
  final void Function()? onTap;
  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        image: DecorationImage(
          image: backgroundImage,
          fit: BoxFit.cover,
          colorFilter: const ColorFilter.mode(
            Colors.black54,
            BlendMode.darken,
          ),
        ),
        borderRadius: AppDefaults.borderRadius,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: AppDefaults.borderRadius,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppDefaults.borderRadius,
          child: Container(
            padding: const EdgeInsets.all(AppDefaults.padding),
            height: MediaQuery.of(context).size.height * 0.16,
            width: double.maxFinite,
            alignment: Alignment.center,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Html(
                data: categoryModel.name,
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
          ),
        ),
      ),
    );
  }
}
