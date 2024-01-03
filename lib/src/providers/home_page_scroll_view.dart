import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_page_scroll_view.freezed.dart';
part 'home_page_scroll_view.g.dart';

@Riverpod(keepAlive: true)
HomePageScrollViewData homePageScrollView(HomePageScrollViewRef ref) {
  return HomePageScrollViewData(
    inputSectionKey: GlobalKey(),
    demoSectionKey: GlobalKey(),
    aboutSectionKey: GlobalKey(),
    pricingSectionKey: GlobalKey(),
    faqSectionKey: GlobalKey(),
    myDecksSectionKey: GlobalKey(),
    loadMoreDecksButton: GlobalKey(),
  );
}

@freezed
class HomePageScrollViewData with _$HomePageScrollViewData {
  const factory HomePageScrollViewData({
    required GlobalKey inputSectionKey,
    required GlobalKey demoSectionKey,
    required GlobalKey aboutSectionKey,
    required GlobalKey pricingSectionKey,
    required GlobalKey faqSectionKey,
    required GlobalKey myDecksSectionKey,
    required GlobalKey loadMoreDecksButton,
  }) = _HomePageScrollViewData;
}
