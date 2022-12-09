import 'package:flutter/material.dart';

import '../controllers/ad/ad_controller.dart';
import '../models/article.dart';
import '../utils/responsive.dart';

class ResponsiveListView extends StatelessWidget {
  const ResponsiveListView({
    Key? key,
    required this.data,
    required this.handleScrollWithIndex,
    this.isInSliver = true,
    this.shrinkWrap = false,
    this.isMainPage = false,
    this.isDisabledScroll = false,
    this.isSpecialSession = false,
  }) : super(key: key);

  final List<ArticleModel> data;
  final void Function(int) handleScrollWithIndex;
  final bool isInSliver;
  final bool shrinkWrap;
  final bool isMainPage;
  final bool isDisabledScroll;
  final bool isSpecialSession;

  @override
  Widget build(BuildContext context) {
    final List<Widget> items = AdController.getAdWithPosts(data,
        isMainPage: isMainPage, isSpecialSession: isSpecialSession);
    return Responsive(
      mobile: _MobileListView(
        handleScrollWithIndex: handleScrollWithIndex,
        data: items,
        isInSliver: isInSliver,
        shrinkWrap: shrinkWrap,
        disabledScroll: isDisabledScroll,
      ),
      tablet: _TabletListView(
        handleScrollWithIndex: handleScrollWithIndex,
        data: items,
        isInSliver: isInSliver,
        shrinkWrap: shrinkWrap,
      ),
      tabletPortrait: _TabletListViewPortrait(
        handleScrollWithIndex: handleScrollWithIndex,
        data: items,
        isInSliver: isInSliver,
        shrinkWrap: shrinkWrap,
      ),
    );
  }
}

class _MobileListView extends StatelessWidget {
  const _MobileListView({
    Key? key,
    required this.handleScrollWithIndex,
    required this.data,
    this.isInSliver = true,
    this.shrinkWrap = false,
    this.disabledScroll = false,
  }) : super(key: key);

  final void Function(int p1) handleScrollWithIndex;
  final List<Widget> data;
  final bool isInSliver;
  final bool shrinkWrap;
  final bool disabledScroll;

  @override
  Widget build(BuildContext context) {
    if (isInSliver) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            handleScrollWithIndex(index);
            return data[index];
          },
          childCount: data.length,
        ),
      );
    } else {
      return ListView.builder(
        shrinkWrap: shrinkWrap,
        itemBuilder: (context, index) {
          handleScrollWithIndex(index);
          return data[index];
        },
        itemCount: data.length,
        physics: disabledScroll ? const NeverScrollableScrollPhysics() : null,
      );
    }
  }
}

class _TabletListView extends StatelessWidget {
  const _TabletListView({
    Key? key,
    required this.handleScrollWithIndex,
    required this.data,
    this.isInSliver = true,
    this.shrinkWrap = false,
  }) : super(key: key);

  final void Function(int p1) handleScrollWithIndex;
  final List<Widget> data;
  final bool isInSliver;
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    if (isInSliver) {
      return SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2.2,
          crossAxisSpacing: 16,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            handleScrollWithIndex(index);
            final item = data[index];
            return item;
          },
          childCount: data.length,
        ),
      );
    } else {
      return GridView.builder(
        shrinkWrap: shrinkWrap,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2.2,
          crossAxisSpacing: 16,
        ),
        itemBuilder: (context, index) {
          handleScrollWithIndex(index);
          final item = data[index];
          return item;
        },
        itemCount: data.length,
      );
    }
  }
}

class _TabletListViewPortrait extends StatelessWidget {
  const _TabletListViewPortrait({
    Key? key,
    required this.handleScrollWithIndex,
    required this.data,
    this.isInSliver = true,
    this.shrinkWrap = false,
  }) : super(key: key);
  final bool isInSliver;
  final bool shrinkWrap;

  final void Function(int p1) handleScrollWithIndex;
  final List<Widget> data;

  @override
  Widget build(BuildContext context) {
    if (isInSliver) {
      return SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2.2,
          crossAxisSpacing: 16,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            handleScrollWithIndex(index);
            final item = data[index];
            return item;
          },
          childCount: data.length,
        ),
      );
    } else {
      return GridView.builder(
        shrinkWrap: shrinkWrap,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2.2,
          crossAxisSpacing: 16,
        ),
        itemBuilder: (context, index) {
          handleScrollWithIndex(index);
          final item = data[index];
          return item;
        },
        itemCount: data.length,
      );
    }
  }
}
