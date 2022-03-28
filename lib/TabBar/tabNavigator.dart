import 'package:example/classes/classes.dart';
import 'package:example/views/excercise.dart';
import 'package:example/views/home.dart';
import 'package:example/views/profile.dart';
import 'package:flutter/material.dart';

//
class TabNavigatorRoutes {
  static const String root = "/";
}

// Custom Navigator for TabBar
class TabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;
  TabNavigator({required this.navigatorKey, required this.tabItem});
  // const TabNavigator({ Key? key }) : super(key: key);

  // Router for routing
  Map<String, WidgetBuilder> _router(BuildContext context) {
    return {
      TabNavigatorRoutes.root: (context) {
        switch (tabItem) {
          // case TabItem.home:
          //   return Home();
          case TabItem.excercise:
            return const Excercise();
          case TabItem.profile:
            return const Profile();
          default:
            return const Home();
        }
      },
    };
  }

  @override
  Widget build(BuildContext context) {
    final routes = _router(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: TabNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
            builder: (context) => routes[routeSettings.name]!(context));
      },
    );
  }
}
