import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:firebase_integrations/todo/model/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TabSelector extends StatelessWidget {
  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  TabSelector({
    Key key,
    @required this.activeTab,
    @required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BubbleBottomBar(
      opacity: 1,
      elevation: 6.0,
      currentIndex: AppTab.values.indexOf(activeTab),
      onTap: (index) => onTabSelected(AppTab.values[index]),
      items: AppTab.values.map((tab) {
        return BubbleBottomBarItem(
          icon: Icon(
            tab == AppTab.todos ? Icons.list : Icons.show_chart,
          ),
          title: Text(
            tab == AppTab.stats ? 'Stats' : 'Todos',
          ),
        );
      }).toList(),
    );
  }
}
