import 'package:ankigpt/src/models/auth_provider.dart';
import 'package:ankigpt/src/providers/auth_user_provider.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'account_view_provider.freezed.dart';
part 'account_view_provider.g.dart';

@riverpod
AccountView accountView(AccountViewRef ref) {
  final authUser = ref.watch(authUserProvider).value;
  if (authUser == null) {
    return const AccountView.signedOut();
  }

  return AccountView.signedIn(
    email: authUser.email,
    authProvider: AuthProvider.fromFirebaseAuthUser(authUser),
  );
}

@freezed
class AccountView with _$AccountView {
  const factory AccountView.signedIn({
    String? email,
    required AuthProvider authProvider,
  }) = AccountViewSignedIn;

  const factory AccountView.signedOut() = AccountViewSignedOut;
}
