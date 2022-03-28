import 'package:example/TabBar/tabNavigator.dart';
import 'package:example/classes/classes.dart';
import 'package:example/services/services.dart';
import 'package:flutter/material.dart';

class TabController extends StatefulWidget {
  @override
  _TabControllerState createState() => _TabControllerState();
}

class _TabControllerState extends State<TabController> {
  var _currentTab = TabItem.home;
  final Map<TabItem, GlobalKey<NavigatorState>> _navigatorKeys = {
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.excercise: GlobalKey<NavigatorState>(),
    TabItem.profile: GlobalKey<NavigatorState>(),
  };

  void _disposeOnTabChange() {}

// Selects the current Tab
  void _selectTab(TabItem tabItem) {
    _disposeOnTabChange();

    if (tabItem == _currentTab) {
      // pop to first route
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      // Set new currentTab
      setState(() => _currentTab = tabItem);
    }
  }

  Widget _buildOffStageNavigator(TabItem tabItem) {
    return Offstage(
      offstage: _currentTab != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem]!,
        tabItem: tabItem,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar();
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentTab]!.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          // if not on the 'main' tab
          if (_currentTab != TabItem.home) {
            // select 'main' tab
            _selectTab(TabItem.home);
            // back button handled by app
            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            _buildOffStageNavigator(TabItem.home),
            _buildOffStageNavigator(TabItem.excercise),
            _buildOffStageNavigator(TabItem.profile),
          ],
        ),
        bottomNavigationBar: Container(
          // NOTE: You can add background Image here
          // decoration:
          //     MMDecorations.createBoxDecoration(Images.kMenue, BoxFit.cover),
          // height: scaleVertically(106),
          child: TabBar(currentTab: _currentTab, onSelectTab: _selectTab),
        ),
      ),
    );
  }
}

// Customized Botom Navigation
// TODO activate Null Safety
class TabBar extends StatelessWidget {
  /// current Tab currently showing
  final TabItem currentTab;

  /// onSelectTab : Function to handle changes in Tabs
  final ValueChanged<TabItem> onSelectTab;
  TabBar({required this.currentTab, required this.onSelectTab});
  //const TabBar({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //decoration: BoxDecoration(),
      child: BottomNavigationBar(
        onTap: (index) => onSelectTab(TabItem.values[index]),
        items: _buildTabItems(),
      ),
    );
  }

  // Build Item that will be shown inside the Tabbar
  List<BottomNavigationBarItem> _buildTabItems() {
    final tabStyle = Styler.createTextStyle(fontSize: 16);
    const tabitems = TabItem.values;
    List<BottomNavigationBarItem> items = [];
    for (var element in tabitems) {
      final label = kTabName[element]!.toUpperCase();
      var item = BottomNavigationBarItem(
          icon: Text(label, style: tabStyle), label: "");
      items.add(item);
    }
    return items;
  }
}

// Tab Names
const Map<TabItem, String> kTabName = {
  TabItem.home: "Home",
  TabItem.excercise: "Excercises",
  TabItem.profile: "Profile",
};
