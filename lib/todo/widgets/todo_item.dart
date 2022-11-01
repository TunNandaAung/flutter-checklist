import 'package:checklist/todo/todos_repository/lib/todos_barrel.dart';
import 'package:checklist/todo/widgets/circular_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TodoItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final ValueChanged<bool> onCheckboxChanged;
  final Todo todo;

  TodoItem({
    Key key,
    @required this.onDismissed,
    @required this.onTap,
    @required this.onCheckboxChanged,
    @required this.todo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        alignment: AlignmentDirectional.centerStart,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.transparent),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 36.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Icon(
                MdiIcons.deleteOutline,
                color: Colors.red,
                size: 30.0,
              ),
            ],
          ),
        ),
      ),
      key: Key('__todo_item_${todo.id}'),
      onDismissed: onDismissed,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Stack(
          children: <Widget>[
            Hero(
              tag: '${todo.id}__bgheroTag',
              child: Container(
                width: double.infinity,
                height: 80.0,
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12.withOpacity(0.01),
                          offset: Offset(0, 10),
                          blurRadius: 10.0)
                    ]),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ListTile(
                    onTap: onTap,
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipOval(
                        child: SizedBox(
                          width: Checkbox.width * 1.2,
                          height: Checkbox.width * 1.2,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(width: 2),
                                borderRadius: BorderRadius.circular(100)),
                            child: CircularCheckbox(
                              value: todo.complete,
                              onChanged: onCheckboxChanged,
                              activeColor: Color(0xFF17ead9),
                            ),
                          ),
                        ),
                      ),
                    ),
                    title: Hero(
                      tag: '${todo.id}__heroTag',
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Text(todo.task,
                            style: todo.complete
                                ? TextStyle(
                                    fontFamily: 'Poppins-Bold',
                                    color: Colors.grey,
                                    fontSize: 23.0,
                                    decoration: TextDecoration.lineThrough)
                                : Theme.of(context).textTheme.headline6),
                      ),
                    ),
                    subtitle: todo.note.isNotEmpty
                        ? Hero(
                            tag: '${todo.id}__noteheroTag',
                            child: Text(
                              todo.note,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: todo.complete
                                  ? Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                          decoration:
                                              TextDecoration.lineThrough)
                                  : Theme.of(context).textTheme.bodyText1,
                            ))
                        : null,
                    trailing: todo.time != 0 || todo.time != null
                        ? dateTime()
                        : Text(""),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dateTime() {
    return todo.time + 60 > DateTime.now().millisecondsSinceEpoch
        ? Text(
            convertEpochtoDateString(todo.time),
            style: TextStyle(
              fontSize: 14.0,
              color: todo.complete ? Colors.grey : Color(0xFF1dc3f5),
              decoration: TextDecoration.none,
            ),
          )
        : Text(
            convertEpochtoDateString(todo.time),
            style: TextStyle(
              fontSize: 14.0,
              color: todo.complete ? Colors.grey : Colors.red.withOpacity(.8),
              decoration: TextDecoration.none,
            ),
          );
  }

  String convertEpochtoDateString(int epoch) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(epoch);
    String dateString =
        DateFormat('EEE, d MMM\nhh:mm a').format(dateTime.toLocal());

    return epoch == 0 ? "" : dateString;
  }
}
