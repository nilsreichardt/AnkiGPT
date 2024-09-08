import 'package:ankigpt/src/providers/generate_provider.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

@freezed
class AppUser with _$AppUser {
  const AppUser._();

  const factory AppUser({
    @Default(false) bool hasPlus,
    @Default(Usage(
      generatedCardsCurrentMonth: 0,
      generatedMnemonicsCurrentMonth: 0,
      generatedCardsCurrentMonthByModel: UsagePerMonthPerModel(),
    ))
    Usage usage,
  }) = _AppUser;

  /// Defines if the reached the maximum number of mnemonics a free user can
  /// generate per month.
  bool get hasReachedMnemonicsLimit {
    if (hasPlus) {
      // Plus users have unlimited mnemonics
      return false;
    }

    return usage.generatedMnemonicsCurrentMonth >= freeMnemonicsUsagePerMonth;
  }

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}

@freezed
class Usage with _$Usage {
  const factory Usage({
    @Default(0) int generatedCardsCurrentMonth,
    @Default(0) int generatedMnemonicsCurrentMonth,
    @Default(UsagePerMonthPerModel())
    UsagePerMonthPerModel generatedCardsCurrentMonthByModel,
  }) = _Usage;

  factory Usage.fromJson(Map<String, dynamic> json) => _$UsageFromJson(json);
}

@freezed
class UsagePerMonthPerModel with _$UsagePerMonthPerModel {
  const factory UsagePerMonthPerModel({
    @JsonKey(name: 'gpt-4o') @Default(0) int gpt4,
  }) = _UsagePerMonthPerModel;

  factory UsagePerMonthPerModel.fromJson(Map<String, dynamic> json) =>
      _$UsagePerMonthPerModelFromJson(json);
}
