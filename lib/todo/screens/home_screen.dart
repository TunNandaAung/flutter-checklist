import 'package:checklist/todo/bloc/tabs/tab_cubit.dart';
import 'package:checklist/todo/widgets/custom_snack_bar.dart';
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

  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityBloc, ConnectivityState>(
      listenWhen: (previousState, currentState) {
        if (previousState is Offline &&
            (currentState is WiFi || currentState is Mobile)) {
          print(currentState);

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              CustomSnackBar.showActionSnackBar(
                title: 'Connection Restored!',
                icon: Icons.done,
                backgroundColor: Colors.green,
                actionLabel: 'Dismiss',
                onActionPressed: () =>
                    ScaffoldMessenger.of(context).hideCurrentSnackBar(),
              ),
            );
        } else {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        }
        return true;
      },
      listener: (context, state) {
        if (state is Offline) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              CustomSnackBar.showActionSnackBar(
                title: 'No Internet connection',
                icon: Icons.error,
                backgroundColor: Colors.red,
                actionLabel: 'Dismiss',
                duration: const Duration(minutes: 1),
                onActionPressed: () =>
                    ScaffoldMessenger.of(context).hideCurrentSnackBar(),
              ),
            );
        } else {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
                            preferredSize: const Size.fromHeight(90.0),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Container(
                                height: null,
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .appBarTheme
                                      .backgroundColor,
                                  borderRadius: const BorderRadius.only(
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
                                    preferredSize: const Size(0.0, 0.0),
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
                                  ),
                                ),
                              ),
                            ),
                          )
                        : PreferredSize(
                            preferredSize: const Size.fromHeight(90.0),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Container(
                                height: null,
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .appBarTheme
                                      .backgroundColor,
                                  borderRadius: const BorderRadius.only(
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
                                    preferredSize: const Size(0.0, 0.0),
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
                                  ),
                                ),
                              ),
                            ),
                          ),
                body: activeTab == AppTab.todos
                    ? FilteredTodos(userId: user.uid)
                    : activeTab == AppTab.stats
                        ? const Stats()
                        : ProfileScreen(
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
                            gradient: const LinearGradient(
                              colors: [Color(0xFF17ead9), Color(0xFF6078ea)],
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      const Color(0xFF6078ea).withOpacity(.3),
                                  offset: const Offset(0.0, 8.0),
                                  blurRadius: 8.0)
                            ]),
                        child: RawMaterialButton(
                          shape: const CircleBorder(),
                          child: const Icon(
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
