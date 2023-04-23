import 'package:flutter/material.dart';

/// Creates a simple flat 3d button with a click animation.
class FancyButton extends StatefulWidget {
  const FancyButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.color,
    this.padding = const EdgeInsets.symmetric(horizontal: 14.0, vertical: 7.0),
    this.elevation = 5.0,
    this.clickDuration = const Duration(milliseconds: 150),
    this.mouseCursor = SystemMouseCursors.click,
  });

  /// Callback to execute when the flat button is pressed.
  final void Function() onPressed;

  /// Padding elements inside the flat button.
  ///
  /// Defaults to 7.0 vertically and 14.0 horizontally
  final EdgeInsetsGeometry padding;

  /// Color of the flat button, bottom color is derived from the given color as the shade700
  ///
  /// Defaults to the current [Theme.of(context).colorScheme.primary] color.
  final MaterialColor? color;

  /// Elevation for the flat button.
  ///
  /// Defaults to 5.0
  final double elevation;

  /// The duration to animate the click.
  ///
  /// Defaults to 150 milliseconds.
  final Duration clickDuration;

  /// The cursor for a mouse pointer when it enters or is hovering over the flat button.
  ///
  /// Defaults to [SystemMouseCursors.click]
  final MouseCursor mouseCursor;

  /// The button's label.
  ///
  /// Often a [Text] widget or [Icon] widget.
  final Widget child;

  /// Flat 3D button with an [Icon] as it's label with the given [icon]
  ///
  /// The icon is padded by horizontally 2.5 logical pixels and vertically 5 logical pixels.
  /// The icon has a default color of white.
  factory FancyButton.icon({
    Key? key,
    required void Function() onPressed,
    required IconData icon,
    MaterialColor? color,
    EdgeInsets padding,
    double elevation,
    Duration clickDuration,
    MouseCursor mouseCursor,
    Color iconColor,
  }) = _Flat3dIconButton;

  /// Create a simple flat 3D button with a [Text] as it's label with the given [text] content.
  ///
  /// The text is padded by horizontally 14 logical pixels and vertically 7 logical pixels.
  /// The text has a default color of white.
  factory FancyButton.text({
    Key? key,
    required void Function() onPressed,
    required String text,
    MaterialColor? color,
    EdgeInsets padding,
    double elevation,
    Duration clickDuration,
    MouseCursor mouseCursor,
    Color textColor,
  }) = _Flat3dTextButton;

  @override
  State<FancyButton> createState() => _Flat3dButtonState();
}

class _Flat3dButtonState extends State<FancyButton> {
  late double _elevation;
  @override
  void initState() {
    _elevation = widget.elevation;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MaterialColor color = widget.color ??
        (Theme.of(context).colorScheme.primary as MaterialColor);
    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: (_) {
        setState(() {
          _elevation = 0;
        });
      },
      onTapUp: (_) {
        setState(() {
          _elevation = widget.elevation;
        });
      },
      child: MouseRegion(
        cursor: widget.mouseCursor,
        child: AnimatedContainer(
          margin: EdgeInsets.only(top: widget.elevation - _elevation),
          duration: widget.clickDuration,
          decoration: BoxDecoration(
            color: color,
            border: Border(
              bottom: BorderSide(
                color: color.shade700,
                width: _elevation,
              ),
            ),
          ),
          padding: widget.padding,
          child: widget.child,
        ),
      ),
    );
  }
}

class _Flat3dIconButton extends FancyButton {
  _Flat3dIconButton({
    super.key,
    required super.onPressed,
    required IconData icon,
    EdgeInsets super.padding =
        const EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
    super.color,
    super.elevation,
    super.clickDuration,
    super.mouseCursor,
    Color iconColor = Colors.white,
  }) : super(
          child: Icon(
            icon,
            color: iconColor,
          ),
        );
}

class _Flat3dTextButton extends FancyButton {
  _Flat3dTextButton({
    super.key,
    required super.onPressed,
    required String text,
    super.color,
    EdgeInsets super.padding,
    super.elevation,
    super.clickDuration,
    super.mouseCursor,
    Color textColor = Colors.white,
  }) : super(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontSize: 20,
            ),
          ),
        );
}
