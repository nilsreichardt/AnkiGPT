import 'package:ankigpt/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cardGenrationSizeProvider =
    StateProvider<CardGenrationSize>((ref) => CardGenrationSize.five);
