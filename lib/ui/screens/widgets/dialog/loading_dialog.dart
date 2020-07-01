import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  String text;

  LoadingDialog({
    @required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      title: Center(
        child: CircularProgressIndicator(),
      ),
      content: Text(
        text,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 16,
        )
      ),
    );
  }
}