


import 'package:flutter/material.dart';

class EmptyDataWidget extends StatelessWidget {
  const EmptyDataWidget({
    super.key,
    required this.theme,
    required this.message,
    required this.iconValue,
  });

  final ThemeData theme;
  final String message;
  final IconData iconValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Icon(
                iconValue,
                size: 64,
                color: Colors.grey[400],
              ),
            ),
            const SizedBox(height: 8),
            Flexible(
              child: Text(message,
                  style: theme.textTheme.displaySmall!
                      .copyWith(color: Colors.grey[400], fontSize: 18)),
            )
          ],
        ),
      ),
    );
  }
}
