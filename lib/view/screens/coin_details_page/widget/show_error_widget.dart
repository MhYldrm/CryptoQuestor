import 'package:crypto_questor/core/extension/my_extensions.dart';
import 'package:flutter/material.dart';

/// A widget that displays an error message when an API request fails.
/// It shows a centered message indicating that there was an issue with the request.
/// [isApiRequestFailed] Text to be displayed when an error is returned as a result of many requests in the free API
///
class ShowErrorWidget extends StatefulWidget {
  const ShowErrorWidget({super.key});

  @override
  State<ShowErrorWidget> createState() => _ShowErrorWidgetState();
}

class _ShowErrorWidgetState extends State<ShowErrorWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Text(context.mLocalizations.isApiRequestFailed),
          ),
        ),
      ),
    );
  }
}
