import 'package:flutter/material.dart';

class ElevatedButtonView extends StatelessWidget {
  const ElevatedButtonView({
    Key? key,
    required this.onPressed,
    this.enable = true,
    this.style,
    required this.child,
    this.isLoading = false,
    this.loadingIndicator,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final bool enable;
  final ButtonStyle? style;
  final Widget child;
  final bool isLoading;
  final Widget? loadingIndicator;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: enable && !isLoading ? onPressed : null,
      child: isLoading ? _getLoadingIndicator : child,
      style: style,
    );
  }

  Widget get _getLoadingIndicator => SizedBox(
        child:
            loadingIndicator ?? const CircularProgressIndicator(strokeWidth: 2),
        width: 15,
        height: 15,
      );
}
