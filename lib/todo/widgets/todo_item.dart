import 'package:firebase_integrations/todo/todos_repository/lib/todos_barrel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
      key: Key('__todo_item_${todo.id}'),
      onDismissed: onDismissed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(.12),
                    offset: Offset(0, 10),
                    blurRadius: 30)
              ]),
          child: ListTile(
            onTap: onTap,
            leading: Checkbox(
              value: todo.complete,
              onChanged: onCheckboxChanged,
            ),
            title: Hero(
              tag: '${todo.id}__heroTag',
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  todo.task,
                  style: Theme.of(context).textTheme.title,
                ),
              ),
            ),
            subtitle: todo.note.isNotEmpty
                ? Text(
                    todo.note,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.subhead,
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
