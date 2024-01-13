// Importing the necessary Flutter material package.
import 'package:flutter/material.dart';

// A stateless widget for creating a customizable chart bar.
class ChartBar extends StatelessWidget {
  // Constructor with required fill parameter.
  const ChartBar({
    super.key,
    required this.fill,
  });

  // The fill ratio of the chart bar, determining its height relative to the container.
  final double fill;

  @override
  Widget build(BuildContext context) {
    // Determining if the dark mode is enabled in the device settings.
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    // Building the chart bar widget.
    return Expanded(
      child: Padding(
        // Adding symmetric horizontal padding.
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: FractionallySizedBox(
          // Setting the height of the box relative to the container's height.
          heightFactor: fill,
          child: DecoratedBox(
            decoration: BoxDecoration(
              // Defining the shape and style of the chart bar.
              shape: BoxShape.rectangle,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8)),
              // Conditional coloring based on the dark mode setting.
              color: isDarkMode
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.primary.withOpacity(0.65),
            ),
          ),
        ),
      ),
    );
  }
}
