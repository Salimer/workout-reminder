import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius,
    this.gradient,
    this.color,
    this.boxShadow,
    this.border,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final BorderRadius? borderRadius;
  final Gradient? gradient;
  final Color? color;
  final List<BoxShadow>? boxShadow;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? scheme.surface,
        gradient: gradient,
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        boxShadow: boxShadow,
        border: border,
      ),
      child: child,
    );
  }
}
