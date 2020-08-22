import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navbar_corner_flutter/menu_dashboard_layout/ui/pages/messages_page.dart';
import 'package:navbar_corner_flutter/menu_dashboard_layout/ui/pages/my_cards_page.dart';
import 'package:navbar_corner_flutter/menu_dashboard_layout/ui/pages/utility_page.dart';

enum NavigationEvents {
  DashboardClickedEvent,
  MessagesClickedEvent,
  UtilityClickedEvent
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  final Function onMenuTap;

  NavigationBloc(NavigationStates initialState, this.onMenuTap)
      : super(initialState);

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.DashboardClickedEvent:
        yield MyCardsPage(
          onMenuTap: onMenuTap,
        );
        break;
      case NavigationEvents.MessagesClickedEvent:
        yield MessagesPage(
          onMenuTap: onMenuTap,
        );
        break;
      case NavigationEvents.UtilityClickedEvent:
        yield UtilityPage(
          onMenuTap: onMenuTap,
        );
        break;
    }
  }
}
