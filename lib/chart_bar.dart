import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final double fill;
  const ChartBar({super.key, required this.fill});
  @override
  Widget build(context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: FractionallySizedBox(
          heightFactor: fill,
          child: DecoratedBox(
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(8)),
                  color: Theme.of(context).colorScheme.onPrimary)),
        ),
      ),
    );
  }
}
