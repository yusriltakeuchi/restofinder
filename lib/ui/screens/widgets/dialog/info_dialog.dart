import 'package:flutter/material.dart';
import 'package:resto/ui/constant/constant.dart';

class InfoDialog extends StatelessWidget {
  String text;
  String clickText;
  IconData icon;
  Function onClickOK;
  Function onClickCancel;

  InfoDialog({
    @required this.text,
    @required this.icon,
    @required this.onClickOK,
    this.onClickCancel, this.clickText = "OK"
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      title: Center(
        child: Icon(icon, color: primaryColor, size: 25,),
      ),
      content: Text(
        text,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 16,
        )
      ),
      actions: <Widget>[
        onClickCancel != null 
        ? OutlineButton(
          onPressed: () => onClickCancel(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5)
          ),
          borderSide: BorderSide(color: primaryColor),
          child: Text(
            "Batal",
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.w600
            ),
          ),
        )
        : SizedBox(),
        RaisedButton(
          color: primaryColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5)
          ),
          onPressed: () => onClickOK(),
          child: Text(
            clickText,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600
            ),
          ),
        ),
      ],
    );
  }
}