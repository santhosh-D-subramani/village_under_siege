import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({super.key, required this.child, this.color});
  final Widget child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isLightMode = theme.brightness == Brightness.light;

    final double screenWidth = MediaQuery.of(context).size.width;

    // Calculate horizontal padding based on screen width
    double horizontalPadding;
    if (screenWidth < 600) {
      horizontalPadding = 8.0;
    } else if (screenWidth >= 600 && screenWidth <= 1200) {
      // Interpolate between 8 and 64 based on screen width
      horizontalPadding = 8 + ((screenWidth - 600) / 600) * (64 - 8);
    } else {
      horizontalPadding = 64.0;
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          color: color ??
              (isLightMode
                  ? theme.colorScheme.primaryContainer
                  : theme.colorScheme.onSecondary),
          child: child,
        ),
      ),
    );
  }
}