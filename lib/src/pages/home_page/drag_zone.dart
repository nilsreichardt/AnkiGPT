import 'package:ankigpt/src/providers/generate_provider.dart';
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
        });
      },
      child: Stack(
        children: [
          widget.child,
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: isDragging
                ? const _DropIndicator()
                : const SizedBox.shrink(
                    key: ValueKey(false),
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
    return Positioned.fill(
      key: const ValueKey(true),
      child: Container(
        color: Colors.black.withOpacity(0.5),
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
      ),
    );
  }
}
