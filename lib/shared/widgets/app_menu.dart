import 'package:eatory_v1/shared/styleguide/container_styles.dart';
import 'package:eatory_v1/shared/styleguide/responsive_ui/size_config.dart';
import 'package:eatory_v1/shared/styleguide/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'nav_items.dart';

class AppMenu extends StatefulWidget {
  @override
  _AppMenuState createState() => _AppMenuState();
}

class _AppMenuState extends State<AppMenu> with SingleTickerProviderStateMixin {
  final Duration duration = const Duration(milliseconds: 250);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;
  double screenHeight, screenWidth;
  int selectedTabIndex = 0;
  int selectedFilterIndex = 0;
  bool isCollapsed = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.65).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 9.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  height: screenHeight,
                  child: Stack(
                    children: <Widget>[
                      ListView(
                        children: <Widget>[
                          Container(
                            margin:
                                const EdgeInsets.only(left: 20.0, top: 70.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Stack(
                                  children: <Widget>[
                                    Container(
                                      height: 100.0,
                                      decoration: BoxDecoration(),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            height: 80,
                                            width: 80,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        "assets/images/profilepic2.jpg"),
                                                    fit: BoxFit.contain),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  "Hey",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 2.5 * SizeConfig.textMultiplier,
                                      fontFamily: "poppins"),
                                ),
                                SizedBox(
                                  height: 2 * SizeConfig.heightMultiplier,
                                ),
                                Text(
                                  "Ajiboye Joshua",
                                  style: TextStyle(
                                      fontFamily: "poppins",
                                      color: Colors.white,
                                      fontSize:
                                          2.47 * SizeConfig.textMultiplier,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: screenHeight / 18),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              NavTabItems(
                                isSelected: selectedTabIndex == 0,
                                onTabTap: () {
                                  onTabTap(0);
                                },
                                iconName: CupertinoIcons.profile_circled,
                                text: "Profile",
                              ),
                              SizedBox(
                                height: 1.3 * SizeConfig.heightMultiplier,
                              ),
                              NavTabItems(
                                isSelected: selectedTabIndex == 1,
                                onTabTap: () {
                                  onTabTap(1);
                                },
                                iconName: CupertinoIcons.home,
                                text: "Home Page",
                              ),
                              SizedBox(
                                height: 1.3 * SizeConfig.heightMultiplier,
                              ),
                              NavTabItems(
                                isSelected: selectedTabIndex == 2,
                                onTabTap: () {
                                  onTabTap(2);
                                },
                                iconName: CupertinoIcons.shopping_cart,
                                text: "My Cart",
                              ),
                              SizedBox(
                                height: 1.3 * SizeConfig.heightMultiplier,
                              ),
                              NavTabItems(
                                isSelected: selectedTabIndex == 3,
                                onTabTap: () {
                                  onTabTap(3);
                                },
                                iconName: CupertinoIcons.heart,
                                text: "Favorite",
                              ),
                              SizedBox(
                                height: 1.3 * SizeConfig.heightMultiplier,
                              ),
                              NavTabItems(
                                isSelected: selectedTabIndex == 4,
                                onTabTap: () {
                                  onTabTap(4);
                                },
                                iconName: CupertinoIcons.share_solid,
                                text: "Orders",
                              ),
                              SizedBox(
                                height: 1.3 * SizeConfig.heightMultiplier,
                              ),
                              NavTabItems(
                                isSelected: selectedTabIndex == 5,
                                onTabTap: () {
                                  onTabTap(5);
                                },
                                iconName: CupertinoIcons.bell,
                                text: "Notifications",
                              ),
                            ],
                          ),
                          Container(
                            width: 20,
                            height: 10,
                            margin: const EdgeInsets.only(
                                left: 22, top: 20, bottom: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Expanded(
                                    flex: 3,
                                    child: Divider(
                                      color: Colors.white,
                                    )),
                                Expanded(
                                  flex: 4,
                                  child: Divider(),
                                )
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  width: 180.0,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0, vertical: 15.0),
                                  decoration: defaultTabStyle,
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                          child: Icon(
                                        Icons.exit_to_app,
                                        color: iconStyle,
                                      )),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(top: 4.0),
                                          child: Text(
                                            "Sign Out",
                                            style: menuTextStyle,
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                            ],
                          )
                        ],
                      ),
                      Positioned(
                        width: 12.72 * SizeConfig.widthMultiplier,
                        height: 5.88 * SizeConfig.heightMultiplier,
                        right: 2.54 * SizeConfig.widthMultiplier,
                        top: 9.41 * SizeConfig.heightMultiplier,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isCollapsed
                                  ? _controller.forward()
                                  : _controller.reverse();
                              isCollapsed = !isCollapsed;
                            });
                          },
                          child: Container(
                            height: 20,
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xff37305A)),
                                borderRadius: BorderRadius.circular(10)),
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }

  onTabTap(int index) {
    setState(() {
      selectedTabIndex = index;
    });
  }
}
