import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:eatory_v1/shared/styleguide/container_styles.dart';
import 'package:eatory_v1/shared/styleguide/text_styles.dart';
import 'package:eatory_v1/shared/styleguide/responsive_ui/size_config.dart';

class NavTabItems extends StatelessWidget {
  final bool isSelected;
  final String text;
  final IconData iconName;
  final Function onTabTap;

  NavTabItems(
      {this.isSelected, this.text, this.onTabTap, this.iconName});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTabTap,
      child: AnimatedContainer(
          width: 45.9 * SizeConfig.widthMultiplier,
        padding: EdgeInsets.symmetric(horizontal: 1.27 * SizeConfig.widthMultiplier, vertical: 1.32 * SizeConfig.heightMultiplier),
          decoration: isSelected ? selectedTabStyle : defaultTabStyle,
          duration: const Duration(milliseconds: 300),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Icon(
                iconName,
                color: isSelected ? selectedIconStyle : iconStyle,
              )),
              Expanded(
                flex: 2,
                child: Container(
                  margin:
                      EdgeInsets.only(top: 0.47 * SizeConfig.heightMultiplier),
                  child: AnimatedDefaultTextStyle(
                    child: Text(text),
                    style: isSelected ? selectedMenuTextStyle : menuTextStyle,
                    duration: const Duration(milliseconds: 300),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
