import 'package:ankigpt/src/models/auth_provider.dart';
import 'package:ankigpt/src/providers/app_user_provider.dart';
import 'package:ankigpt/src/providers/auth_user_provider.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'account_view_provider.freezed.dart';
part 'account_view_provider.g.dart';

@riverpod
AccountView accountView(AccountViewRef ref) {
  final authUser = ref.watch(authUserProvider).value;
  if (authUser == null || authUser.isAnonymous) {
    return const AccountView.signedOut();
  }

  final appUser = ref.watch(appUserProvider).value;
  return AccountView.signedIn(
    email: authUser.email,
    authProvider: AuthProvider.fromFirebaseAuthUser(authUser),
    generatedCardsCurrentMonth: appUser?.usage.generatedCardsCurrentMonth ?? 0,
    generatedMnemonicsCurrentMonth:
        appUser?.usage.generatedMnemonicsCurrentMonth ?? 0,
    hasPlus: appUser?.hasPlus ?? false,
    hasDeleteUserSchedule: appUser?.deleteUserSchedule != null,
  );
}

@freezed
class AccountView with _$AccountView {
  const factory AccountView.signedIn({
    String? email,
    required AuthProvider authProvider,
    required int generatedCardsCurrentMonth,
    required int generatedMnemonicsCurrentMonth,
    required bool hasPlus,
    required bool hasDeleteUserSchedule,
  }) = AccountViewSignedIn;

  const factory AccountView.signedOut() = AccountViewSignedOut;
}
