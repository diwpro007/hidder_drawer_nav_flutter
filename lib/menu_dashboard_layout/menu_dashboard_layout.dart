import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navbar_corner_flutter/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:navbar_corner_flutter/menu_dashboard_layout/dashboard.dart';
import 'package:navbar_corner_flutter/menu_dashboard_layout/menu.dart';
import 'package:navbar_corner_flutter/menu_dashboard_layout/ui/pages/messages_page.dart';
import 'package:navbar_corner_flutter/menu_dashboard_layout/ui/pages/my_cards_page.dart';
import 'package:navbar_corner_flutter/menu_dashboard_layout/ui/pages/utility_page.dart';

final Color backgroundColor = Color(0xFF4A4a58);

class MenuDashBoardLayout extends StatefulWidget {
  @override
  _MenuDashBoardLayoutState createState() => _MenuDashBoardLayoutState();
}

class _MenuDashBoardLayoutState extends State<MenuDashBoardLayout>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 250);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
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

  void onMenuTap() {
    setState(() {
      if (isCollapsed)
        _controller.forward();
      else
        _controller.reverse();
      isCollapsed = !isCollapsed;
    });
  }

  void onMenuItemClicked() {
    setState(() {
      _controller.reverse();
    });
    isCollapsed = !isCollapsed;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: BlocProvider<NavigationBloc>(
        create: (context) => NavigationBloc(
            MyCardsPage(
              onMenuTap: onMenuTap,
            ),
            onMenuTap),
        child: Stack(
          children: [
            BlocBuilder<NavigationBloc, NavigationStates>(
                builder: (context, NavigationStates navigationState) {
              return Menu(
                slideAnimation: _slideAnimation,
                menuScaleAnimation: _menuScaleAnimation,
                selectedIndex: findSelectedIndex(navigationState),
                onMenuItemClicked: onMenuItemClicked,
              );
            }),
            Dashboard(
                duration: duration,
                onMenuTap: onMenuTap,
                scaleAnimation: _scaleAnimation,
                isCollapsed: isCollapsed,
                screenWidth: screenWidth,
                child: BlocBuilder<NavigationBloc, NavigationStates>(
                  builder: (context, NavigationStates navigationState) {
                    return navigationState as Widget;
                  },
                )),
          ],
        ),
      ),
    );
  }
}

int findSelectedIndex(NavigationStates navigationStates) {
  if (navigationStates is MyCardsPage) {
    return 0;
  } else if (navigationStates is MessagesPage) {
    return 1;
  } else if (navigationStates is UtilityPage) {
    return 2;
  } else {
    return 0;
  }
}
