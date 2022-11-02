import 'package:checklist/todo/bloc/tabs/tab_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:checklist/todo/modal/add_modal.dart';
import 'package:checklist/todo/model/models.dart';
import 'package:checklist/todo/screens/profile_screen.dart';
import 'package:checklist/todo/widgets/widgets.dart';
import 'package:checklist/utils/connectivity/bloc/connectivity_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  final User user;

  HomeScreen({Key? key, required this.user}) : super(key: key);

  final _scaffoldMessengerKey = new GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityBloc, ConnectivityState>(
      listener: (context, state) {
        if (state is Offline) {
          _scaffoldMessengerKey.currentState!
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                duration: Duration(minutes: 2),
                elevation: 6.0,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.error),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      'No Internet connection',
                      style: TextStyle(fontFamily: 'Poppins-Bold'),
                    ),
                  ],
                ),
                backgroundColor: Colors.red,
                action: SnackBarAction(
                  label: 'Dismiss',
                  textColor: Colors.white,
                  onPressed: () =>
                      _scaffoldMessengerKey.currentState!.hideCurrentSnackBar(),
                ),
              ),
            );
        } else {
          _scaffoldMessengerKey.currentState!.hideCurrentSnackBar();
        }
      },
      child: BlocBuilder<ConnectivityBloc, ConnectivityState>(
          builder: (context, state) {
        return BlocBuilder<TabCubit, AppTab>(
          builder: (context, activeTab) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Theme.of(context).backgroundColor,
                      Theme.of(context).canvasColor
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    tileMode: TileMode.clamp),
              ),
              child: Scaffold(
                key: _scaffoldMessengerKey,
                appBar: activeTab == AppTab.profile
                    ? null
                    : activeTab == AppTab.stats
                        ? PreferredSize(
                            preferredSize: Size.fromHeight(90.0),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Container(
                                height: null,
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .appBarTheme
                                      .backgroundColor,
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(30.0),
                                    bottomLeft: Radius.circular(30.0),
                                  ),
                                ),
                                child: AppBar(
                                  backgroundColor: Colors.transparent,
                                  elevation: 0.0,
                                  // title: Text(
                                  //   'Hello \n${user.displayName}',
                                  //   style: Theme.of(context).textTheme.display1,
                                  // ),
                                  actions: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        FilterButton(
                                            visible: activeTab == AppTab.todos),
                                        ExtraActions(
                                          user: user,
                                        )
                                      ],
                                    )
                                  ],
                                  bottom: PreferredSize(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          8.0, 0.0, 150.0, 0.0),
                                      child: Text(
                                        'Current Status',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                      ),
                                    ),
                                    preferredSize: Size(0.0, 0.0),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : PreferredSize(
                            preferredSize: Size.fromHeight(90.0),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Container(
                                height: null,
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .appBarTheme
                                      .backgroundColor,
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(20.0),
                                    bottomLeft: Radius.circular(20.0),
                                  ),
                                ),
                                child: AppBar(
                                  backgroundColor: Colors.transparent,
                                  elevation: 0.0,
                                  // title: Text(
                                  //   'Hello \n${user.displayName}',
                                  //   style: Theme.of(context).textTheme.display1,
                                  // ),
                                  actions: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        FilterButton(
                                            visible: activeTab == AppTab.todos),
                                        ExtraActions(
                                          user: user,
                                        )
                                      ],
                                    )
                                  ],
                                  bottom: PreferredSize(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 18.0),
                                        child: Text(
                                          'Checklist',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                        ),
                                      ),
                                    ),
                                    preferredSize: Size(0.0, 0.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                body: activeTab == AppTab.todos
                    ? FilteredTodos(userId: user.uid)
                    : activeTab == AppTab.stats
                        ? Stats()
                        : Profile(
                            user: user,
                          ),
                // floatingActionButton: FloatingActionButton(
                //   onPressed: () {
                //     Navigator.pushNamed(context, '/addTodo');
                //   },
                //   child: Icon(Icons.add),
                //   tooltip: 'Add Todo',
                // ),
                floatingActionButton: activeTab == AppTab.todos
                    ? Container(
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
                            Icons.add,
                            size: 35.0,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            AddModal().mainBottomSheet(context, user.uid);
                          },
                        ),
                      )
                    : Container(),
                bottomNavigationBar: TabSelector(
                  activeTab: activeTab,
                  onTabSelected: (tab) =>
                      context.read<TabCubit>().updateTab(tab),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
