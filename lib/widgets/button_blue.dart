import 'package:flutter/material.dart';

class ButtonBlue extends StatelessWidget {
  final String textButton;
  final Function onPressedButton;

  const ButtonBlue(
      {Key key, @required this.textButton, @required this.onPressedButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 2,
      highlightElevation: 5,
      color: Colors.blue,
      shape: StadiumBorder(),
      onPressed: this.onPressedButton,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 50,
        child: Text(
          this.textButton,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
