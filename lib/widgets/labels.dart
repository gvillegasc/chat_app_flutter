import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String question;
  final String route;
  final String textButton;

  const Labels(
      {Key key,
      @required this.question,
      @required this.route,
      @required this.textButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(this.question,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
                  fontWeight: FontWeight.w200)),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              // FocusScope.of(context).requestFocus(new FocusNode());
              Navigator.pushReplacementNamed(context, this.route);
            },
            child: Text(this.textButton,
                style: TextStyle(
                    color: Colors.blue[600],
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
