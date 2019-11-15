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
      elevation: 0.0,
      currentIndex: AppTab.values.indexOf(activeTab),
      onTap: (index) => onTabSelected(AppTab.values[index]),
      items: AppTab.values.map((tab) {
        return BubbleBottomBarItem(
          backgroundColor: Colors.black,
          icon: Icon(
            tab == AppTab.todos
                ? MdiIcons.formatListCheckbox
                : MdiIcons.chartLineVariant,
            color: Colors.white,
          ),
          title: Text(
            tab == AppTab.stats ? 'Stats' : 'Todos',
            style: TextStyle(fontFamily: 'Poppins-Medium', color: Colors.white),
          ),
        );
      }).toList(),
    );
  }
}
