import 'package:ankigpt/src/pages/widgets/extensions.dart';
import 'package:ankigpt/src/providers/generate_provider.dart';
import 'package:ankigpt/src/providers/logger/logger_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_drag_and_drop/super_drag_and_drop.dart';

class DragZone extends ConsumerStatefulWidget {
  const DragZone({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  ConsumerState<DragZone> createState() => _DragZoneState();
}

class _DragZoneState extends ConsumerState<DragZone> {
  bool isDragging = false;

  void maybeShowWarningForMultipleFiles(PerformDropEvent event) {
    final hasMultipleFiles = event.session.items.length > 1;
    if (hasMultipleFiles) {
      context.showTextSnackBar(
          'Multiples files are not supported. Using the first file');
    }
  }

  void logError(Object e) {
    final logger = ref.read(loggerProvider);
    logger.e('Could not read file from drag zone', error: e);
  }

  void displayErrorMessage() {
    context.showTextSnackBar(
      'Could not read file. Please try again or use the file picker.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return DropRegion(
      formats: Formats.standardFormats,
      onDropEnter: (event) {
        setState(() {
          isDragging = true;
        });
      },
      onDropEnded: (event) {
        setState(() {
          isDragging = false;
        });
      },
      onDropLeave: (event) {
        setState(() {
          isDragging = false;
        });
      },
      onDropOver: (event) {
        return DropOperation.copy;
      },
      onPerformDrop: (event) async {
        maybeShowWarningForMultipleFiles(event);

        final item = event.session.items.first;

        item.dataReader!.getFile(Formats.pdf, (file) async {
          final bytes = await file.readAll();
          final data = {
            'name': file.fileName,
            'size': file.fileSize,
            'bytes': bytes,
          };
          final platform = PlatformFile.fromMap(data);
          ref.read(generateNotifierProvider.notifier).setPickedFile(
                platform,
              );
        }, onError: (e) {
          logError(e);
          displayErrorMessage();
        });
      },
      child: Stack(
        children: [
          widget.child,
          Positioned.fill(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: isDragging
                  ? const _DropIndicator()
                  : const SizedBox.shrink(
                      key: ValueKey(false),
                    ),
            ),
          )
        ],
      ),
    );
  }
}

class _DropIndicator extends StatelessWidget {
  const _DropIndicator();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.5),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(20),
          child: const Text(
            'Drop PDF file here',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
