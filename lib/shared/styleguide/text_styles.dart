import 'package:flutter/material.dart';
import 'package:eatory_v1/shared/styleguide/colors.dart';
import 'package:eatory_v1/shared/styleguide/responsive_ui/size_config.dart';


final TextStyle filterTextStyle = TextStyle(
    color: Colors.black,
//  fontSize: 1.64 * SizeConfig.textMultiplier,
//    fontFamily: "poppins",
    fontWeight: FontWeight.w700
);


final TextStyle menuTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 1.64 * SizeConfig.textMultiplier,
    fontFamily: "poppins"
);

final TextStyle selectedMenuTextStyle = TextStyle(
  color: Color(0XFFC4727E),
  fontSize: 1.64 * SizeConfig.textMultiplier,
  fontFamily: "poppins"
);

final Color selectedIconStyle = Color(0XFFF76C4B);

final Color iconStyle = Color(0XFFFFFFFF);

final TextStyle menuCenterStyle = TextStyle(
  color: Color(0XFFCBCBCD),
  fontSize: 1.7 * SizeConfig.textMultiplier,
  fontFamily: 'Poppins',
  letterSpacing: 2.0
);