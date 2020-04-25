import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:eatory_v1/views/app.dart';
import 'package:eatory_v1/views/restaurants/restaurant_listing.dart';
import 'package:eatory_v1/shared/styleguide/responsive_ui/size_config.dart';
import 'package:eatory_v1/shared/widgets/strings.dart';
import 'package:flutter/material.dart';
import 'core/bloc/cart_list_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
    blocs: [
      Bloc((i)=>CartListBloc())
    ],
      child: LayoutBuilder(builder: (context, constraints) {
        return OrientationBuilder(builder: (context, orientation) {
          SizeConfig().init(constraints, orientation);
          return MaterialApp(
            builder: (BuildContext context, Widget child) {
              var textScaleFactor = 0.82;
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: textScaleFactor),
                child: AppRoot(),
              );
            },
            debugShowCheckedModeBanner: false,
            title: Strings.appTitle,
          );
        });
      }),
    );
  }
}