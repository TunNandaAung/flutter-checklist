import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:firebase_integrations/todo/model/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
      backgroundColor: Colors.transparent,
      opacity: 1,
      iconSize: 27.0,
      elevation: 0.0,
      currentIndex: AppTab.values.indexOf(activeTab),
      onTap: (index) => onTabSelected(AppTab.values[index]),
      items: AppTab.values.map((tab) {
        return BubbleBottomBarItem(
          backgroundColor: Theme.of(context).bottomAppBarTheme.color,
          icon: Icon(
            tab == AppTab.todos
                ? MdiIcons.formatListCheckbox
                : tab == AppTab.stats
                    ? MdiIcons.chartLineVariant
                    : MdiIcons.accountOutline,
            color: Theme.of(context).dividerColor,
          ),
          title: Text(
            tab == AppTab.stats
                ? 'Stats'
                : tab == AppTab.todos ? 'Todos' : 'Profile',
            style: Theme.of(context).textTheme.display2,
          ),
        );
      }).toList(),
    );
  }
}
