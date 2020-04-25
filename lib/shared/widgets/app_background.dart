import 'package:flutter/material.dart';
import 'package:eatory_v1/shared/styleguide/colors.dart';

class AppBackground extends StatelessWidget {
  final Color firstColor, secondColor, thirdColor;

  AppBackground({this.firstColor, this.secondColor, this.thirdColor});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        final height = constraint.maxHeight;
        final width = constraint.maxWidth;

        return Stack(
          children: <Widget>[
            Container(
              color: menuColor,
            ),
          ],
        );
      }
    );
  }
}
