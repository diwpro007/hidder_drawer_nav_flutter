import 'package:flutter/material.dart';
import 'package:navbar_corner_flutter/bloc/navigation_bloc/navigation_bloc.dart';

class MessagesPage extends StatelessWidget with NavigationStates {
  final Function onMenuTap;

  MessagesPage({Key key, this.onMenuTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              InkWell(
                child: Icon(Icons.menu, color: Colors.white),
                onTap: onMenuTap,
              ),
              Text("Messages",
                  style: TextStyle(fontSize: 24, color: Colors.white)),
              Icon(Icons.settings, color: Colors.white)
            ],
          )
        ],
      ),
    );
  }
}
