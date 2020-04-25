import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:eatory_v1/core/bloc/cart_list_bloc.dart';
import 'package:eatory_v1/core/models/food_item.dart';
import 'package:eatory_v1/views/restaurants/restaurant_details.dart';
import 'package:eatory_v1/shared/styleguide/container_styles.dart';
import 'package:eatory_v1/shared/styleguide/responsive_ui/size_config.dart';
import 'package:eatory_v1/shared/styleguide/text_styles.dart';
import 'package:eatory_v1/shared/widgets/app_background.dart';
import 'package:eatory_v1/shared/widgets/category_filter.dart';
import 'package:eatory_v1/shared/widgets/nav_items.dart';
import 'package:eatory_v1/shared/widgets/page_transitions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter_emoji/flutter_emoji.dart';

import 'cart_list.dart';

class RestaurantListing extends StatefulWidget {
  @override
  _RestaurantListingState createState() => _RestaurantListingState();
}

class _RestaurantListingState extends State<RestaurantListing>
    with SingleTickerProviderStateMixin {
  var parser = EmojiParser();
  var coffee = Emoji('hamburger', '🍔');
  var confetti = Emoji('confetti_ball', '🎊');
  bool isCollapsed = true;
  double screenHeight, screenWidth;
  final Duration duration = const Duration(milliseconds: 250);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;
  int selectedTabIndex = 0;
  int selectedFilterIndex = 0;
  TextEditingController searchField = TextEditingController();
  bool _visibleDeal = false;
  Container deals;
  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();
  Image dealsImage = Image.asset(
    "assets/images/sig.png",
    height: 22.35 * SizeConfig.heightMultiplier,
    fit: BoxFit.contain,
  );
  InkWell buildGestureDetector(int length, BuildContext context, List<FoodItem> foodItems){
    return InkWell(
      onTap: () {
        Navigator.push(
            context, FadeRoute(page: CartList()));
      },
      child: Container(
          margin: EdgeInsets.only(
              right: 3.12 * SizeConfig.widthMultiplier),
          color: Colors.transparent,
          constraints: BoxConstraints(
              maxHeight: 4.70 * SizeConfig.heightMultiplier,
              minHeight: 4.12 * SizeConfig.heightMultiplier,
              maxWidth: 10.18 * SizeConfig.widthMultiplier,
              minWidth: 8.90 * SizeConfig.widthMultiplier),
          child: Stack(
            children: <Widget>[
              Positioned(
                  right: 2.79 * SizeConfig.widthMultiplier,
                  top: 1.06 * SizeConfig.heightMultiplier,
                  child: Icon(
                    FeatherIcons.shoppingCart,
                    size: 2 * SizeConfig.textMultiplier,
                  )),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
//                  padding: EdgeInsets.symmetric(vertical: 1, horizontal: 2),
                  width: 3.82 * SizeConfig.widthMultiplier,
                  height: 2.12 * SizeConfig.heightMultiplier,
                  decoration: BoxDecoration(
                      color: Color(0xFFFB713E),
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        length.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }

  @override
  void initState() {
    super.initState();
    deals = Container(
      child: Container(
        height: 24.7 * SizeConfig.heightMultiplier,
        margin: EdgeInsets.only(
            top: 10.06 * SizeConfig.heightMultiplier,
            left: 5.08 * SizeConfig.widthMultiplier,
            right: 5.08 * SizeConfig.widthMultiplier),
        decoration: BoxDecoration(
            color: Color(0XFFFB6D3A).withOpacity(0.1),
            borderRadius: BorderRadius.circular(30)),
        child: Stack(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Positioned(
                  left: -5.85 * SizeConfig.widthMultiplier,
                  top: 2,
                  child: dealsImage,
                ),
              ],
            ),
            Positioned(
              right: 7.93 * SizeConfig.widthMultiplier,
              top: 8.23 * SizeConfig.heightMultiplier,
              child: FittedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          '\u{20A6}',
                          style: TextStyle(
                              color: Color(0XFFFB6D3A),
                              fontSize: 2.32 * SizeConfig.textMultiplier,
                              letterSpacing: 0.35 * SizeConfig.textMultiplier,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "0 delivery for",
                          style: TextStyle(
                              color: Color(0XFFFB6D3A),
                              fontWeight: FontWeight.w700,
                              fontSize: 2.67 * SizeConfig.textMultiplier,
                              fontFamily: "poppins"),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "30 days 🎊",
                            style: TextStyle(
                                color: Color(0XFFFB6D3A),
                                fontWeight: FontWeight.w700,
                                fontSize: 2.67 * SizeConfig.textMultiplier,
                                fontFamily: "poppins"),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 20,
              right: 20,
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      deals = Container(
                        height: 0,
                      );
                      _visibleDeal = true;
                    });
                  },
                  child: Icon(
                    Icons.close,
                    color: Colors.deepOrangeAccent.withOpacity(0.7),
                  )),
            )
          ],
        ),
      ),
    );
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

    return Scaffold(
      body: Stack(
        children: <Widget>[AppBackground(), menu(context), dashboard(context)],
      ),
    );
  }

  Widget menu(context) {
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

  Widget dashboard(context) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.6 * screenWidth,
      right: isCollapsed ? 0 : -0.5 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          elevation: 8.0,
          borderRadius: BorderRadius.circular(isCollapsed ? 0 : 70.0),
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xfff1f2f6),
                          Color(0xfff8f8f8),
                          Color(0xffF7F7F7)
                        ]),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(isCollapsed ? 0.0 : 20.0),
                        bottomRight:
                            Radius.circular(isCollapsed ? 0.0 : 20.0))),
                margin:
                    EdgeInsets.only(top: 13.95 * SizeConfig.heightMultiplier),
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: ListView(
                    children: <Widget>[
                      deals,
                      Container(
                        margin: EdgeInsets.only(
                            top: _visibleDeal
                                ? 10.06 * SizeConfig.heightMultiplier
                                : 4.30 * SizeConfig.heightMultiplier,
                            left: 5.08 * SizeConfig.widthMultiplier,
                            right: 5.08 * SizeConfig.widthMultiplier,
                            bottom: 3.30 * SizeConfig.heightMultiplier),
                        child: Text(
                          "Restaurants 🍔",
                          style: TextStyle(
                              fontSize: 3.29 * SizeConfig.textMultiplier,
                              fontWeight: FontWeight.bold,
                              fontFamily: "poppins",
                              color: Color(0xff0E0A07)),
                        ),
                      ),
                      filter(),
                      SizedBox(
                        height: 4.12 * SizeConfig.heightMultiplier,
                      ),
                      for (var foodItem in fooditemList.foodItems)
                        ItemContainer(foodItem: foodItem)
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(isCollapsed ? 0.0 : 20.0),
                      topLeft: Radius.circular(isCollapsed ? 0.0 : 20.0)),
                ),
                padding: EdgeInsets.only(
                    left: 5.09 * SizeConfig.widthMultiplier,
                    right: 5.09 * SizeConfig.widthMultiplier,
                    top: 7.65 * SizeConfig.heightMultiplier,
                    bottom: 2.35 * SizeConfig.heightMultiplier),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        setState(() {
                          isCollapsed
                              ? _controller.forward()
                              : _controller.reverse();
                          isCollapsed = !isCollapsed;
                        });
                      },
                      child: Image.asset(
                        "assets/images/hammenu.png",
                        height: 5.29 * SizeConfig.heightMultiplier,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 0.71 * SizeConfig.heightMultiplier,
                          horizontal: 3.82 * SizeConfig.widthMultiplier),
                      decoration: BoxDecoration(
                          color: Color(0XFFF8F8F7),
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "22 St Kuti Ave",
                        style: menuCenterStyle,
                      ),
                    ),
                    StreamBuilder(
                        stream: bloc.listStream,
                        builder: (context, snapshot) {
                          List<FoodItem> foodItems = snapshot.data;
                          int length = foodItems.length != null ? foodItems.length : 0;
                          return buildGestureDetector(length, context, foodItems);
                        })
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: 1.18 * SizeConfig.heightMultiplier,
                    bottom: 1.18 * SizeConfig.heightMultiplier,
                    right: 2.54 * SizeConfig.widthMultiplier,
                    left: 5.09 * SizeConfig.widthMultiplier),
                margin: EdgeInsets.only(
                    left: 3.82 * SizeConfig.widthMultiplier,
                    right: 3.82 * SizeConfig.widthMultiplier,
                    top: 17.15 * SizeConfig.heightMultiplier,
                    bottom: 2.35 * SizeConfig.heightMultiplier),
                height: 5.88 * SizeConfig.heightMultiplier,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Color(0xfff1f2f6),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xffdadff0),
                          offset: Offset(8, 6),
                          blurRadius: 12),
                      BoxShadow(
                          color: Colors.white,
                          offset: Offset(-8, -6),
                          blurRadius: 12)
                    ]),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: searchField,
                        decoration: InputDecoration(
                            hintText: "Search for a vendor or product",
                            hintStyle: TextStyle(
                                height: 0.15 * SizeConfig.heightMultiplier,
                                fontFamily: "poppins",
                                color: Colors.grey,
                                fontSize: 1.65 * SizeConfig.textMultiplier),
                            //add icon outside input field
                            icon: Icon(
                              FeatherIcons.search,
                              size: 2.3529 * SizeConfig.textMultiplier,
                            ),
                            border: InputBorder.none
                            //add icon to the beginning of text field
                            //prefixIcon: Icon(Icons.person),
                            //can also add icon to the end of the textfiled
                            //suffixIcon: Icon(Icons.remove_red_eye),
                            ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: 5.09 * SizeConfig.widthMultiplier,
                          top: 1.176 * SizeConfig.heightMultiplier,
                          bottom: 0.59 * SizeConfig.heightMultiplier),
                      margin: EdgeInsets.only(right: 17, bottom: 4),
                      child: Transform.rotate(
                          angle: 4.75,
                          child: Icon(
                            Icons.tune,
                            size: 2.35 * SizeConfig.textMultiplier,
                          )),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget filter() {
    return Container(
      height: 17.65 * SizeConfig.heightMultiplier,
      margin: EdgeInsets.only(left: 5.08 * SizeConfig.widthMultiplier),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          CategoryFilter(
            filterName: "All",
            filterIcon: FeatherIcons.filter,
            isSelected: selectedFilterIndex == 0,
            onFilterTap: () {
              onFilterTap(0);
            },
          ),
          CategoryFilter(
            filterName: "Pizza",
            filterIcon: FeatherIcons.filter,
            isSelected: selectedFilterIndex == 1,
            onFilterTap: () {
              onFilterTap(1);
            },
          ),
          CategoryFilter(
            filterName: "Noodle",
            filterIcon: FeatherIcons.filter,
            isSelected: selectedFilterIndex == 2,
            onFilterTap: () {
              onFilterTap(2);
            },
          ),
          CategoryFilter(
            filterName: "Swallow",
            filterIcon: FeatherIcons.filter,
            isSelected: selectedFilterIndex == 3,
            onFilterTap: () {
              onFilterTap(3);
            },
          ),
        ],
      ),
    );
  }

  onTabTap(int index) {
    setState(() {
      selectedTabIndex = index;
    });
  }

  onFilterTap(int index) {
    setState(() {
      selectedFilterIndex = index;
    });
  }
}

class ItemContainer extends StatelessWidget {
  final FoodItem foodItem;

  const ItemContainer({@required this.foodItem});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, FadeRoute(page: RestaurantDetails(foodItem: foodItem)));
      },
      child: RestaurantList(
          id: foodItem.id,
          restaurant: foodItem.restaurant,
          deliveryTime: foodItem.deliveryDuration,
          rating: foodItem.rating,
          restaurantLocation: foodItem.restaurantLocation,
          restaurantImage: foodItem.imgUrl),
    );
  }
}

class RestaurantList extends StatelessWidget {
  final int id;
  final String restaurant;
  final String deliveryTime;
  final String rating;
  final String restaurantLocation;
  final String restaurantImage;

  const RestaurantList(
      {this.id,
      this.restaurant,
      this.deliveryTime,
      this.rating,
      this.restaurantLocation,
      this.restaurantImage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
              top: 4.30 * SizeConfig.heightMultiplier,
              left: 5.08 * SizeConfig.widthMultiplier,
              right: 5.08 * SizeConfig.widthMultiplier,
              bottom: 1.30 * SizeConfig.heightMultiplier),
          child: Column(
            children: <Widget>[
              Hero(
                tag: id,
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            restaurantImage,
                            fit: BoxFit.cover,
                          )),
                      Positioned(
                        width: 100,
                        height: 45,
                        bottom: 0,
                        left: 0,
                        child: Container(
                          child: Center(
                              child: RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "poppins",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                                children: [
                                  TextSpan(text: deliveryTime),
                                  TextSpan(
                                      text: " mins",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13))
                                ]),
                          )),
                          decoration: BoxDecoration(
                              color: Color(0xffF8F8F7),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          restaurant,
                          style: TextStyle(
                              fontFamily: "poppins",
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff111111)),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          FeatherIcons.star,
                          color: Colors.black,
                          size: 17,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          rating,
                          style: TextStyle(
                            fontSize: 17,
                            fontFamily: "poppins",
//                          color: Color(0xff9A9A9A)
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          restaurantLocation,
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: "poppins",
                              color: Color(0xff9A9A9A)),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
