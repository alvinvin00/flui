import 'package:flui/src/common/defines.dart';
import 'package:flutter/material.dart';

class FLRaisedButton extends StatelessWidget {
  FLRaisedButton({
    Key? key,
    required this.onPressed,
    this.clipBehavior,
    this.focusNode,
    this.expanded = false,
    this.buttonStyle,
    required this.child,
  }) : super(key: key);

  final VoidCallback onPressed;
  final bool expanded;
  final Clip? clipBehavior;
  final FocusNode? focusNode;
  final ButtonStyle? buttonStyle;
  final Widget? child;

  factory FLRaisedButton.icon({
    Key? key,
    required VoidCallback onPressed,
    Clip? clipBehavior,
    FocusNode? focusNode,
    FLPosition? iconPosition,
    ButtonStyle? buttonStyle,
    double? spacing,
    required Widget icon,
    required Widget label,
  }) = _FLRaisedButtonWithIcon;

  @override
  Widget build(BuildContext context) {
    Widget? buttonChild = expanded
        ? Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                child: child!,
              )
            ],
          )
        : child;

    return ElevatedButton(
      onPressed: onPressed,
      style: buttonStyle,
      clipBehavior: clipBehavior ?? Clip.none,
      focusNode: focusNode,
      child: buttonChild,
    );
  }
}

class _FLRaisedButtonWithIcon extends FLRaisedButton
    with MaterialButtonWithIconMixin {
  _FLRaisedButtonWithIcon({
    Key? key,
    required VoidCallback onPressed,
    required this.icon,
    required this.label,
    this.iconPosition = FLPosition.left,
    this.spacing = 8,
    this.clipBehavior,
    this.focusNode,
    this.buttonStyle,
  }) : super(
            key: key,
            buttonStyle: buttonStyle,
            onPressed: onPressed,
            clipBehavior: clipBehavior,
            focusNode: focusNode,
            child: null);

  final Widget icon;
  final Widget label;
  final Clip? clipBehavior;
  final FocusNode? focusNode;
  final FLPosition? iconPosition;
  final double? spacing;
  final ButtonStyle? buttonStyle;

  @override
  Widget build(BuildContext context) {
    bool isHorizontal =
        (iconPosition == FLPosition.left || iconPosition == FLPosition.right);
    SizedBox spaceBox =
        isHorizontal ? SizedBox(width: spacing) : SizedBox(height: spacing);
    List<Widget> children =
        (iconPosition == FLPosition.left || iconPosition == FLPosition.top)
            ? [icon, spaceBox, label]
            : [label, spaceBox, icon];

    Widget buttonChild = isHorizontal
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: children,
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: children,
          );

    return ElevatedButton(
      onPressed: onPressed,
      clipBehavior: clipBehavior ?? Clip.none,
      focusNode: focusNode,
      child: buttonChild,
    );
  }
}
