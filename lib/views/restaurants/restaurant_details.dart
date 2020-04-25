import 'dart:ui';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:eatory_v1/core/bloc/cart_list_bloc.dart';
import 'package:eatory_v1/shared/widgets/page_transitions.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eatory_v1/core/models/food_item.dart';
import 'package:eatory_v1/shared/styleguide/container_styles.dart';
import 'package:eatory_v1/shared/styleguide/responsive_ui/size_config.dart';
import 'package:eatory_v1/shared/styleguide/text_styles.dart';

import 'cart_list.dart';

class RestaurantDetails extends StatefulWidget {
  final FoodItem foodItem;

  const RestaurantDetails({@required this.foodItem});

  @override
  _RestaurantDetailsState createState() => _RestaurantDetailsState();
}

class _RestaurantDetailsState extends State<RestaurantDetails> {
  ScrollController _scrollController;
  List<String> storeDetail;
  bool lastStatus = true;

  _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;

      });
    }
  }

  bool get isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (200 - kToolbarHeight);
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
    storeDetail = [widget.foodItem.title, widget.foodItem.price.toString()];
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 4,
        child: NestedScrollView(
          controller: _scrollController,
          scrollDirection: Axis.vertical,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                child: new SliverAppBar(
                  expandedHeight: 23.53 * SizeConfig.heightMultiplier,
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding:
                      EdgeInsets.all(1.17 * SizeConfig.heightMultiplier),
                      color: Colors.transparent,
                      child: Container(
                          padding: EdgeInsets.only(
                              top: isShrink
                                  ? 0.47 * SizeConfig.heightMultiplier
                                  : 0,
                              right: 0.51 * SizeConfig.widthMultiplier),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                              isShrink ? Colors.transparent : Colors.white),
                          child: Icon(
                            CupertinoIcons.back,
                            color: isShrink ? Colors.white : Colors.black,
                            size: isShrink
                                ? 2.35 * SizeConfig.textMultiplier
                                : 2.18 * SizeConfig.textMultiplier,
                          )),
                    ),
                  ),
                  floating: false,
                  pinned: true,
                  backgroundColor: Color(0XFFFB6D3A),
                  forceElevated: innerBoxIsScrolled,
                  flexibleSpace: new FlexibleSpaceBar(
                    centerTitle: false,
                    title: AnimatedOpacity(
                      opacity: isShrink ? 1.0 : 0.0,
                      duration: new Duration(milliseconds: 100),
                      child: Text(
                        widget.foodItem.restaurant,
                        style: TextStyle(fontFamily: "poppins"),
                      ),
                    ),
                    background: Hero(
                      tag: widget.foodItem.id,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset(
                          widget.foodItem.imgUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                    AnimatedOpacity(
                      opacity: isShrink ? 0.0 : 1.0,
                      duration: new Duration(milliseconds: 100),
                      child: Container(
                        height: 10.64 * SizeConfig.heightMultiplier,
                        padding: EdgeInsets.only(
                            left: 7.63 * SizeConfig.widthMultiplier),
                        margin: EdgeInsets.only(top: 92,),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Color(0XFFe8e8e9),
                                    width: 2.54 * SizeConfig.widthMultiplier))),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                widget.foodItem.restaurant,
                                style: TextStyle(
                                  fontSize: 2.59 * SizeConfig.textMultiplier,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "poppins",
                                  color: isShrink ? Colors.white : Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 0.59 * SizeConfig.heightMultiplier,
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    FeatherIcons.star,
                                    color: Color(0xff838383),
                                    size: 1.29 * SizeConfig.textMultiplier,
                                  ),
                                  SizedBox(
                                    width: 1.78 * SizeConfig.widthMultiplier,
                                  ),
                                  Text(
                                    widget.foodItem.rating,
                                    style: TextStyle(
                                        fontSize: 1.88 * SizeConfig.textMultiplier,
                                        fontFamily: "poppins",
                                        color: Color(0xff838383)),
                                  ),
                                  SizedBox(
                                    width: 3.05 * SizeConfig.widthMultiplier,
                                    child: Center(child: Text(".")),
                                  ),
                                  Text(
                                    widget.foodItem.restaurantLocation,
                                    style: TextStyle(
                                        fontSize: 1.88 * SizeConfig.textMultiplier,
                                        fontFamily: "poppins",
                                        color: Color(0xff838383)),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ])),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  new TabBar(
                    indicatorColor: Color(0XFFFB6D3A),
                    indicatorWeight: 3.0,
                    unselectedLabelColor: Colors.black,
                    labelColor: Color(0XFFFB6D3A),
                    tabs: <Tab>[
                      Tab(
                        text: 'Meal',
                      ),
                      Tab(
                        text: 'Drinks',
                      ),
                      Tab(
                        text: 'Directions',
                      ),
                      Tab(
                        text: 'Reviews',
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 0),
                color: Colors.white,
                child: ListView(
                  padding:
                      EdgeInsets.only(top: 1.17 * SizeConfig.heightMultiplier),
                  children: <Widget>[
                    MealItem(
                      foodItem: widget.foodItem,
                    ),
                    MealItem(
                      foodItem: widget.foodItem,
                    ),
                    MealItem(
                      foodItem: widget.foodItem,
                    )
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  height: 300.0,
                  child: Text('Drinks',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 9.41 * SizeConfig.textMultiplier)),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  height: 300.0,
                  child: Text('Directions',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 9.41 * SizeConfig.textMultiplier)),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  height: 300.0,
                  child: Text('Reviews',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 9.41 * SizeConfig.textMultiplier)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class MealItem extends StatelessWidget {
  final FoodItem foodItem;

  MealItem({this.foodItem});

  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();
  SnackBar viewOrderSnackBar;

  void addToCart(FoodItem foodItem) {
    bloc.addToList(this.foodItem);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        addToCart(this.foodItem);

        viewOrderSnackBar = SnackBar(
          content: GestureDetector(
            onTap: () {
              Navigator.push(
                  context, FadeRoute(page: CartList()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("${foodItem.title}"),
                Container(
                  child: Text(
                    "VIEW ORDER",
                    style: TextStyle(
                        fontFamily: "poppins", fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          ),
          duration: Duration(days: 1),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Color(0xffEEA145),
        );

        Scaffold.of(context).showSnackBar(viewOrderSnackBar);
      },
      child: MealList(
        foodItem: this.foodItem,
      ),
    );
  }
}

class MealList extends StatelessWidget {
  final FoodItem foodItem;

  const MealList({this.foodItem});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.white,
          height: 9.41 * SizeConfig.heightMultiplier,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(
            left: 3.88 * SizeConfig.widthMultiplier,
            right: 3.88 * SizeConfig.widthMultiplier,
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 12.72 * SizeConfig.widthMultiplier,
                height: 5.88 * SizeConfig.heightMultiplier,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Color(0xffdadff0),
                      offset: Offset(2, 0),
                      blurRadius: 5),
                  BoxShadow(
                      color: Colors.white, offset: Offset(-2, 0), blurRadius: 5)
                ], borderRadius: BorderRadius.circular(0)),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(0),
                    child: Image.asset(
                      foodItem.foodUrl,
                      fit: BoxFit.cover,
                    )),
              ),
              SizedBox(
                width: 15,
              ),
              Container(
                height: 5.88 * SizeConfig.heightMultiplier,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      foodItem.title,
                      style: TextStyle(
                          fontFamily: "poppins",
                          fontSize: 2 * SizeConfig.textMultiplier,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff111111)),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "₦ " + foodItem.price.toString(),
                          style: TextStyle(
                              fontSize: 1.65 * SizeConfig.textMultiplier,
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
        ),
        Divider()
      ],
    );
  }
}
