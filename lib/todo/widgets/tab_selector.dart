import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:checklist/todo/model/models.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TabSelector extends StatelessWidget {
  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  const TabSelector({
    Key? key,
    required this.activeTab,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BubbleBottomBar(
      backgroundColor: Theme.of(context).cardColor,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
      opacity: .3,
      iconSize: 27.0,
      elevation: 0.0,
      currentIndex: AppTab.values.indexOf(activeTab),
      onTap: (index) => onTabSelected(AppTab.values[index!]),
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
          activeIcon: Icon(
            tab == AppTab.todos
                ? MdiIcons.formatListCheckbox
                : tab == AppTab.stats
                    ? MdiIcons.chartLineVariant
                    : MdiIcons.accountOutline,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(
            tab == AppTab.stats
                ? 'Stats'
                : tab == AppTab.todos
                    ? 'Todos'
                    : 'Profile',
            style: Theme.of(context).textTheme.headline3!.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
          ),
        );
      }).toList(),
    );
  }
}
