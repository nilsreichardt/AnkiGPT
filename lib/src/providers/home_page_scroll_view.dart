import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_page_scroll_view.freezed.dart';
part 'home_page_scroll_view.g.dart';

@Riverpod(keepAlive: true)
HomePageScrollViewData homePageScollView(HomePageScollViewRef ref) {
  return HomePageScrollViewData(
    inputSectionKey: GlobalKey(),
    pricingSectionKey: GlobalKey(),
  );
}

@freezed
class HomePageScrollViewData with _$HomePageScrollViewData {
  const factory HomePageScrollViewData({
    required GlobalKey inputSectionKey,
    required GlobalKey pricingSectionKey,
  }) = _HomePageScrollViewData;
}
