import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

copyClipboard(BuildContext context, String? value) {
  var snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    content: SingleChildScrollView(
      child: Text('Copy success to clipboard\n\n$value'),
    ),
    margin: const EdgeInsets.fromLTRB(16, 96, 16, 16),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
  Clipboard.setData(ClipboardData(text: value ?? 'null'));
}
