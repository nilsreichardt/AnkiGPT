import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'version_provider.g.dart';

@Riverpod(dependencies: [])
String version(VersionRef ref) {
  return const String.fromEnvironment(
    'RELEASE_DATE',
    defaultValue: 'Jan 1 2023',
  );
}
