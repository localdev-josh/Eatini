import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:eatory_v1/shared/styleguide/container_styles.dart';
import 'package:eatory_v1/shared/styleguide/text_styles.dart';
import 'package:eatory_v1/shared/styleguide/responsive_ui/size_config.dart';

class CategoryFilter extends StatelessWidget {
  final bool isSelected;
  final String filterName;
  final IconData filterIcon;
  final Function onFilterTap;

  CategoryFilter(
      {this.isSelected, this.filterName, this.onFilterTap, this.filterIcon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onFilterTap,
      child: AnimatedContainer(
          padding: EdgeInsets.fromLTRB(
              2.54 * SizeConfig.widthMultiplier,
              0,
              2.54 * SizeConfig.widthMultiplier,
              2.35 * SizeConfig.heightMultiplier),
          margin: EdgeInsets.only(right: 5.089 * SizeConfig.widthMultiplier),
          decoration: isSelected ? selectedFilterStyle : defaultFilterStyle,
          duration: const Duration(milliseconds: 300),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color:
                            isSelected ? Colors.transparent : Color(0xFFF3F1EF),
                        width: 1.5)),
                child: Icon(filterIcon),
              ),
              AnimatedDefaultTextStyle(
                child: Text(filterName),
                duration: const Duration(milliseconds: 300),
                style: filterTextStyle,
              )
            ],
          )),
    );
  }
}
