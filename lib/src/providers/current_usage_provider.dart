import 'package:ankigpt/src/providers/app_user_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_usage_provider.g.dart';

@Riverpod()
int currentMonthUsage(CurrentMonthUsageRef ref) {
  final appUser = ref.watch(appUserProvider);
  return appUser.value?.usage.generatedCardsCurrentMonth ?? 0;
}

@Riverpod()
int currentGpt4Usage(CurrentGpt4UsageRef ref) {
  final appUser = ref.watch(appUserProvider);
  return appUser
          .value?.usage.generatedCardsCurrentMonthByModel.gpt4_1106Preview ??
      0;
}
