import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_integrations/todo/bloc/tabs/tabs_barrel.dart';
import 'package:firebase_integrations/todo/modal/add_modal.dart';
import 'package:firebase_integrations/todo/model/models.dart';
import 'package:firebase_integrations/todo/screens/profile_screen.dart';
import 'package:firebase_integrations/todo/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseUser user;

  const HomeScreen({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, AppTab>(
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
                  tileMode: TileMode.clamp)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: activeTab == AppTab.profile
                ? null
                : PreferredSize(
                    preferredSize: Size.fromHeight(150.0),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        height: null,
                        decoration: BoxDecoration(
                            color: Color(0xfff7faff),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(30.0),
                                bottomLeft: Radius.circular(30.0))),
                        child: AppBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0.0,
                          // title: Text(
                          //   'Hello \n${user.displayName}',
                          //   style: Theme.of(context).textTheme.display1,
                          // ),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                  0, 12.0, 150.0, 0.0),
                              child: Text(
                                'Hello, \n${user.displayName}',
                                style: Theme.of(context).textTheme.display1,
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
                  BlocProvider.of<TabBloc>(context).add(UpdateTab(tab)),
            ),
          ),
        );
      },
    );
  }
}
