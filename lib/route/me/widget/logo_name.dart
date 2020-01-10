import 'package:flutter/material.dart';
import 'package:musket_app/assets/resources.dart';

class LogoName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 32, bottom: R.dimen.commonMargin),
          width: 80,
          height: 80,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Image.asset(R.image.appLogo, width: 80, height: 80),
        ),
        Text(R.string.appName, style: R.style.boldText.copyWith(fontSize: 20)),
      ],
    );
  }
}
