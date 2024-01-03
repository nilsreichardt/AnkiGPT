import 'package:ankigpt/src/pages/widgets/ankigpt_card.dart';
import 'package:flutter/material.dart';

const _disabledForegroundColorFallback = Color(0xFF696969);

class AnkiGptElevatedButton extends StatelessWidget {
  const AnkiGptElevatedButton({
    super.key,
    required this.child,
    this.onPressed,
    this.tooltip,
    this.isEnabled,
    this.color,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.border,
  });

  factory AnkiGptElevatedButton.icon({
    Key? key,
    VoidCallback? onPressed,
    Widget? icon,
    Widget? label,
    String? tooltip,
    bool? isEnabled,
    Color? color,
    Color? disabledBackgroundColor,
    Color? disabledForegroundColor,
    BoxBorder? border,
    bool center,
    MainAxisSize mainAxisSize,
  }) = _AnkiGptElevatedButtonWithIcon;

  final VoidCallback? onPressed;
  final Widget child;
  final String? tooltip;
  final bool? isEnabled;
  final Color? color;
  final Color? disabledBackgroundColor;
  final Color? disabledForegroundColor;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    final isEnabled = this.isEnabled ?? true;
    final disabledBackgroundColor =
        this.disabledBackgroundColor ?? const Color(0xFFD0D0D0);
    final color = this.color ?? Theme.of(context).colorScheme.inversePrimary;
    final disabledForegroundColor =
        this.disabledForegroundColor ?? _disabledForegroundColorFallback;
    final borderRadius = BorderRadius.circular(10.0);

    return Semantics(
      button: true,
      enabled: isEnabled,
      container: true,
      child: Tooltip(
        message: tooltip ?? '',
        child: AnkiGptCard(
          borderRadius: borderRadius,
          onPressed: isEnabled ? onPressed : null,
          hoverColor: color.withOpacity(0.1),
          splashColor: color.withOpacity(0.1),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          color: isEnabled ? color : disabledBackgroundColor,
          border: border,
          child: DefaultTextStyle.merge(
            style: TextStyle(
              color: isEnabled ? null : disabledForegroundColor,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class _AnkiGptElevatedButtonWithIcon extends AnkiGptElevatedButton {
  _AnkiGptElevatedButtonWithIcon({
    super.key,
    super.onPressed,
    super.tooltip,
    super.isEnabled,
    super.color,
    super.disabledBackgroundColor,
    super.disabledForegroundColor,
    super.border,
    Widget? icon,
    Widget? label,
    bool center = false,
    MainAxisSize mainAxisSize = MainAxisSize.max,
  }) : super(
          child: _AnkiGptElevatedButtonWithIconChild(
            isEnabled: isEnabled,
            icon: icon,
            label: label,
            disableForegroundColor: disabledForegroundColor,
            center: center,
            mainAxisSize: mainAxisSize,
          ),
        );
}

class _AnkiGptElevatedButtonWithIconChild extends StatelessWidget {
  const _AnkiGptElevatedButtonWithIconChild({
    this.icon,
    this.label,
    this.isEnabled,
    this.disableForegroundColor,
    this.center = false,
    this.mainAxisSize = MainAxisSize.max,
  });

  final Widget? icon;
  final Widget? label;
  final bool? isEnabled;
  final Color? disableForegroundColor;
  final bool center;
  final MainAxisSize mainAxisSize;

  @override
  Widget build(BuildContext context) {
    final isEnabled = this.isEnabled ?? true;
    final disableForegroundColor =
        this.disableForegroundColor ?? _disabledForegroundColorFallback;
    return IconTheme(
      data: IconTheme.of(context).copyWith(
        color: isEnabled
            ? DefaultTextStyle.of(context).style.color
            : disableForegroundColor,
      ),
      child: Row(
        mainAxisSize: mainAxisSize,
        mainAxisAlignment:
            center ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          if (icon != null) icon!,
          if (icon != null && label != null) const SizedBox(width: 8),
          if (label != null) label!,
        ],
      ),
    );
  }
}
