import 'package:ankigpt/src/providers/package_info_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'version_provider.g.dart';

@Riverpod(dependencies: [])
Future<String> version(VersionRef ref) async {
  final packageInfo = await ref.watch(packageInfoProvider.future);
  return packageInfo.version;
}
