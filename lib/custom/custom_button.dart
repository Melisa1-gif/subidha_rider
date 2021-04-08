import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final bool padded;
  CustomButton({
    @required this.title,
    @required this.onPressed,
    @required this.padded,
});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: MaterialButton(
        padding: EdgeInsets.all(10.0),
        color: Theme.of(context).buttonColor,
          child: Text(title),
          onPressed: onPressed,
      ),
    );
  }
}
