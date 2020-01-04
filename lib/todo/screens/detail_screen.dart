import 'package:circular_check_box/circular_check_box.dart';
import 'package:firebase_integrations/todo/bloc/todos_bloc/todos_bloc_barrel.dart';
import 'package:firebase_integrations/todo/modal/edit_modal.dart';
import 'package:firebase_integrations/utils/custom_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsScreen extends StatelessWidget {
  final String id;

  DetailsScreen({Key key, @required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosBloc, TodosState>(
      builder: (context, state) {
        final todo = (state as TodosLoaded)
            .todos
            .firstWhere((todo) => todo.id == id, orElse: () => null);
        return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                Theme.of(context).backgroundColor,
                Theme.of(context).canvasColor,
              ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  tileMode: TileMode.clamp)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              title: Text(
                'Todo Details',
                style: Theme.of(context).textTheme.display1,
              ),
              leading: Container(
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios,
                      size: 28.0, color: Theme.of(context).dividerColor),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              actions: [
                IconButton(
                  tooltip: 'Delete Todo',
                  icon: Icon(
                    Icons.delete,
                    size: 30.0,
                    color: Theme.of(context).dividerColor,
                  ),
                  onPressed: () {
                    BlocProvider.of<TodosBloc>(context).add(DeleteTodo(todo));
                    Navigator.pop(context, todo);
                  },
                )
              ],
            ),
            body: todo == null
                ? Container()
                : Stack(children: <Widget>[
                    Hero(
                        tag: '${todo.id}__bgheroTag',
                        child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              //color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50.0),
                                  topRight: Radius.circular(50.0),
                                  bottomLeft: Radius.circular(50.0)),
                            ))),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: ListView(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ClipOval(
                                  child: SizedBox(
                                    width: Checkbox.width * 1.2,
                                    height: Checkbox.width * 1.2,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 2),
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: CircularCheckBox(
                                        value: todo.complete,
                                        onChanged: (_) {
                                          BlocProvider.of<TodosBloc>(context)
                                              .add(
                                            UpdateTodo(
                                              todo.copyWith(
                                                  complete: !todo.complete,
                                                  userId: todo.userId),
                                            ),
                                          );
                                        },
                                        activeColor: Color(0xFF17ead9),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 30.0,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Hero(
                                      tag: '${todo.id}__heroTag',
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.only(
                                          top: 8.0,
                                          bottom: 16.0,
                                        ),
                                        child: Text(
                                          todo.task,
                                          style: todo.complete
                                              ? TextStyle(
                                                  fontFamily: 'Poppins-Bold',
                                                  color: Colors.grey,
                                                  fontSize: 23.0,
                                                  decoration: TextDecoration
                                                      .lineThrough)
                                              : Theme.of(context)
                                                  .textTheme
                                                  .title,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Hero(
                                      tag: '${todo.id}__noteheroTag',
                                      child: Text(
                                        todo.note,
                                        style: todo.complete
                                            ? Theme.of(context).textTheme.body2
                                            : Theme.of(context).textTheme.body1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ]),
            floatingActionButton: Container(
              width: 65.0,
              height: 65.0,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF17ead9), Color(0xFF6078ea)],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFF6078ea).withOpacity(.3),
                        offset: Offset(0.0, 8.0),
                        blurRadius: 8.0)
                  ]),
              child: RawMaterialButton(
                shape: CircleBorder(),
                child: Icon(
                  Icons.edit,
                  size: 35.0,
                  color: Colors.white,
                ),
                onPressed: todo == null
                    ? null
                    : () {
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return AddEditScreen(
                        //         onSave: (task, note) {
                        //           BlocProvider.of<TodosBloc>(context).add(
                        //             UpdateTodo(
                        //               todo.copyWith(task: task, note: note),
                        //             ),
                        //           );
                        //         },
                        //         isEditing: true,
                        //         todo: todo,
                        //       );
                        //     },
                        //   ),
                        // );
                        EditModal().mainBottomSheet(context, todo);
                      },
              ),
            ),
          ),
        );
      },
    );
  }
}

class MClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height - 100);

    var controlpoint = Offset(35.0, size.height);
    var endpoint = Offset(size.width / 2, size.height);

    path.quadraticBezierTo(
        controlpoint.dx, controlpoint.dy, endpoint.dx, endpoint.dy);

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
