import 'package:firebase_integrations/todo/bloc/tabs/tabs_barrel.dart';
import 'package:firebase_integrations/todo/modal/add_modal.dart';
import 'package:firebase_integrations/todo/model/models.dart';
import 'package:firebase_integrations/todo/screens/profile_screen.dart';
import 'package:firebase_integrations/todo/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activeTab) {
        return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                Color(0xFF1b1e44),
                Color(0xFF2d3447),
              ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  tileMode: TileMode.clamp)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              title: Text('Firestore Todos'),
              actions: [
                FilterButton(visible: activeTab == AppTab.todos),
                ExtraActions(),
              ],
            ),
            body: activeTab == AppTab.todos
                ? FilteredTodos()
                : activeTab == AppTab.stats ? Stats() : Profile(),
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
                        AddModal().mainBottomSheet(context);
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
