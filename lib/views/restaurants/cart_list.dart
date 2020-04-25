import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:eatory_v1/core/bloc/cart_list_bloc.dart';
import 'package:eatory_v1/core/models/food_item.dart';
import 'package:eatory_v1/shared/styleguide/responsive_ui/size_config.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_emoji/flutter_emoji.dart';

class CartList extends StatelessWidget {
  var parser = EmojiParser();
  var sunGlasses = Emoji('sunglasses', '😎');

  @override
  Widget build(BuildContext context) {
    final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();
    List<FoodItem> foodItems;
    return StreamBuilder(
      stream: bloc.listStream,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          foodItems = snapshot.data;
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: CartBody(foodItems),
            ),
            bottomNavigationBar: BottomBar(foodItems),
          );
        } else {
          return Container(
            child: Text("Something returned null"),
          );
        }
      },
    );
  }
}

class BottomBar extends StatelessWidget {
  final List<FoodItem> foodItems;

  BottomBar(this.foodItems);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 6.09 * SizeConfig.widthMultiplier,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          totalAmount(foodItems),
          Divider(
            height: 1,
            color: Colors.grey[700],
          ),
          checkOutButton()
        ],
      ),
    );
  }

  Container checkOutButton() {
    return Container(
      margin: EdgeInsets.only(
          top: 2.94 * SizeConfig.heightMultiplier,
          bottom: 2.94 * SizeConfig.heightMultiplier,
          left: 38.1679 * SizeConfig.widthMultiplier),
      padding: EdgeInsets.all(2.94 * SizeConfig.heightMultiplier),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(2.35 * SizeConfig.heightMultiplier),
            bottomLeft: Radius.circular(2.35 * SizeConfig.heightMultiplier),
          ),
          gradient: LinearGradient(colors: [
            Color(0xffF8CA5B),
            Color(0xffF2B34F),
            Color(0xffEFA446)
          ])),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            "Checkout",
            style: TextStyle(
                fontSize: 2.23 * SizeConfig.textMultiplier,
                fontFamily: "poppins",
                color: Color(0xff351F0C),
                fontWeight: FontWeight.w600),
          ),
          Icon(
            Icons.arrow_forward,
            size: 2 * SizeConfig.textMultiplier,
          )
        ],
      ),
    );
  }

  Container totalAmount(List<FoodItem> foodItems) {
    return Container(
      margin: EdgeInsets.only(right: 6.09 * SizeConfig.widthMultiplier),
      padding: EdgeInsets.symmetric(vertical: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Total",
            style: TextStyle(
              fontSize: 2.94 * SizeConfig.textMultiplier,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            "₦ ${returnTotalAmount(foodItems)}",
            style: TextStyle(
                fontSize: 3.29 * SizeConfig.textMultiplier,
                fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }

  String returnTotalAmount(List<FoodItem> foodItems) {
    double totalAmount = 0.0;
    for (int i = 0; i < foodItems.length; i++) {
      totalAmount = totalAmount + foodItems[i].price * foodItems[i].quantity;
    }
    return totalAmount.toStringAsFixed(2);
  }
}

class CartBody extends StatelessWidget {
  final List<FoodItem> foodItems;

  CartBody(this.foodItems);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          customAppBar(context),
          title(context),
          Container(
            height: 17.65 * SizeConfig.heightMultiplier,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(3.76 * SizeConfig.heightMultiplier),
            margin: EdgeInsets.only(
              left: 6.09 * SizeConfig.widthMultiplier,
              right: 6.09 * SizeConfig.widthMultiplier,
            ),
            decoration: BoxDecoration(
                color: Color(0xff503E9D),
                borderRadius:
                    BorderRadius.circular(1.76 * SizeConfig.heightMultiplier)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "22 St Kuti Ave",
                      style: TextStyle(
                          color: Color(0xffffffff),
                          fontSize: 1.76 * SizeConfig.textMultiplier,
                          letterSpacing: 0.4,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "Edit",
                      style: TextStyle(
                          color: Color(0xffEDC866),
                          fontSize: 2.12 * SizeConfig.textMultiplier,
                          letterSpacing: 0.4,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          height: 4.59 * SizeConfig.heightMultiplier,
                          width: 9.92 * SizeConfig.widthMultiplier,
                          margin: EdgeInsets.only(
                              right: 2.5445 * SizeConfig.widthMultiplier),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xffEDC866).withOpacity(0.2),
                          ),
                          child: Icon(
                            FeatherIcons.clock,
                            color: Color(0xffEDC866),
                            size: 2.1176 * SizeConfig.textMultiplier,
                          ),
                        ),
                        Text(
                          "35 min",
                          style: TextStyle(
                              color: Color(0xffffffff),
                              fontSize: 1.76 * SizeConfig.textMultiplier,
                              letterSpacing: 0.4,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                    Text(
                      "Choose time",
                      style: TextStyle(
                          color: Color(0xffEDC866),
                          fontSize: 2.1176 * SizeConfig.textMultiplier,
                          letterSpacing: 0.4,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 4.05 * SizeConfig.heightMultiplier,
          ),
          Expanded(
              child: foodItems.length > 0
                  ? foodItemList()
                  : Center(child: noItemContainer()))
        ],
      ),
    );
  }

  ListView foodItemList() {
    return ListView(
      children: <Widget>[
        for (var index = 0; index < foodItems.length; index++)
          CartListItem(
            foodItem: foodItems[index],
          ),
        delivery(),
      ],
    );
//    return ListView.builder(
//        itemCount: foodItems.length,
//        itemBuilder: (builder, index) {
//          return CartListItem(foodItem: foodItems[index]);
//        });
  }

  Container delivery() {
    return Container(
      margin: EdgeInsets.only(
        top: 1.65 * SizeConfig.heightMultiplier,
        left: 6.09 * SizeConfig.widthMultiplier,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 6.47 * SizeConfig.heightMultiplier,
            width: 25.44 * SizeConfig.widthMultiplier,
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(1.17 * SizeConfig.heightMultiplier),
                color: Color(0xffFDD381).withOpacity(0.2)),
            child: Icon(
              CupertinoIcons.car,
              color: Color(0xffFDD381),
              size: 3.53 * SizeConfig.textMultiplier,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 5.089 * SizeConfig.widthMultiplier),
            child: Text(
              "Delivery",
              style: TextStyle(
                  fontSize: 2.117 * SizeConfig.textMultiplier,
                  fontFamily: "poppins",
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Spacer(),
          Container(
              margin: EdgeInsets.only(right: 6.09 * SizeConfig.widthMultiplier),
              child: Text(
                "₦ ${0.00}",
                style: TextStyle(
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w400,
                    fontSize: 1.88 * SizeConfig.textMultiplier),
              ))
        ],
      ),
    );
  }
  Container noItemContainer() {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(bottom: 2.35 * SizeConfig.heightMultiplier),
                child: Icon(FeatherIcons.shoppingCart, color: Colors.grey[300],)),
            Container(
              margin: EdgeInsets.only(bottom: 1.176 * SizeConfig.heightMultiplier),
              child: Text(
                "Cart is empty",
                style: TextStyle(
                    color: Colors.grey[900],
                    fontSize: 2.15 * SizeConfig.textMultiplier),
              ),
            ),
            Text(
              "You have to add something first",
              style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 1.65 * SizeConfig.textMultiplier),
            ),
          ],
        ),
      ),
    );
  }
}

class CartListItem extends StatelessWidget {
  final FoodItem foodItem;

  const CartListItem({this.foodItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.94 * SizeConfig.heightMultiplier),
      child: itemContent(foodItem: foodItem),
    );
  }
}

class itemContent extends StatelessWidget {
  final FoodItem foodItem;

  const itemContent({this.foodItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 1.65 * SizeConfig.heightMultiplier,
        left: 6.09 * SizeConfig.widthMultiplier,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ClipRRect(
            borderRadius:
                BorderRadius.circular(1.176 * SizeConfig.heightMultiplier),
            child: Image.asset(
              foodItem.foodUrl,
              fit: BoxFit.cover,
              height: 6.47 * SizeConfig.heightMultiplier,
              width: 25.44 * SizeConfig.widthMultiplier,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 5.089 * SizeConfig.widthMultiplier),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  foodItem.quantity.toString(),
                  style: TextStyle(
                      fontSize: 2.35 * SizeConfig.textMultiplier,
                      fontFamily: "poppins",
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: 3.82 * SizeConfig.widthMultiplier,
                ),
                Text(
                  "x",
                  style: TextStyle(
                      fontSize: 2.18 * SizeConfig.textMultiplier,
                      fontFamily: "poppins",
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: 3.82 * SizeConfig.widthMultiplier,
                ),
                Container(
                  width: 22.90 * SizeConfig.widthMultiplier,
                  child: Text(
                    foodItem.title,
                    softWrap: true,
                    style: TextStyle(
                        fontSize: 2.12 * SizeConfig.textMultiplier,
                        fontFamily: "poppins",
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
              margin: EdgeInsets.only(right: 6.09 * SizeConfig.widthMultiplier),
              child: Text(
                "₦ ${foodItem.quantity * foodItem.price}",
                style: TextStyle(
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w400,
                    fontSize: 1.88 * SizeConfig.textMultiplier),
              ))
        ],
      ),
    );
  }
}

Widget customAppBar(context) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
    ),
    padding: EdgeInsets.only(
        left: 6.09 * SizeConfig.widthMultiplier,
        right: 6.09 * SizeConfig.widthMultiplier,
        top: 4.65 * SizeConfig.heightMultiplier,
        bottom: 2.35 * SizeConfig.heightMultiplier),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              CupertinoIcons.back,
              color: Colors.black,
            )),
        GestureDetector(
            onTap: () {},
            child: Icon(
              CupertinoIcons.delete,
              color: Colors.black,
            )),
      ],
    ),
  );
}

Widget title(context) {
  return Padding(
    padding: EdgeInsets.symmetric(
        horizontal: 6.09 * SizeConfig.widthMultiplier,
        vertical: 4.12 * SizeConfig.heightMultiplier),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              "My",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFamily: "poppins",
                  fontSize: 4.12 * SizeConfig.textMultiplier),
            ),
            SizedBox(
              width: 2.03 * SizeConfig.widthMultiplier,
            ),
            Text(
              "😎",
              style: TextStyle(fontFamily: "poppins", fontSize: 4.12 * SizeConfig.textMultiplier),
            )
          ],
        ),
        SizedBox(
          height: 0.47 * SizeConfig.heightMultiplier,
        ),
        Text(
          "Order",
          style: TextStyle(
              fontWeight: FontWeight.w700, fontFamily: "poppins", fontSize: 4.12 * SizeConfig.textMultiplier),
        ),
      ],
    ),
  );
}
