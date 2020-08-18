import 'package:checklist/todo/bloc/stats/stats_barrel.dart';
import 'package:checklist/todo/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Stats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatsBloc, StatsState>(
      builder: (context, state) {
        if (state is StatsLoading) {
          return LoadingIndicator();
        } else if (state is StatsLoaded) {
          return Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                      height: 115,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        //color: Color(0xFF4293f5),
                        gradient: LinearGradient(
                            colors: [Color(0xff00C9FF), Color(0xff78fa85)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            tileMode: TileMode.clamp),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).highlightColor,
                            blurRadius: 10.0,
                            offset: Offset(0, 10),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                left: 15.0, top: 12.0, bottom: 5.0),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  MdiIcons.checkAll,
                                  color: Colors.grey[200],
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Text(
                                  'Completed Todos',
                                  style: TextStyle(
                                      fontFamily: 'Poppins-Medium',
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      decoration: TextDecoration.none),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 21.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: <Widget>[
                                Text(
                                  '${state.numCompleted}',
                                  style: TextStyle(
                                      fontFamily: 'Poppins-Bold',
                                      color: Colors.white,
                                      fontSize: 39.0,
                                      decoration: TextDecoration.none),
                                ),
                                SizedBox(width: 8.0),
                                Text(
                                  'Done',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      decoration: TextDecoration.none),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
                Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                        height: 115,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Color(0xffE55D87), Color(0xff5FC3E4)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                tileMode: TileMode.clamp),
                            borderRadius: BorderRadius.circular(20.0),
                            //    color: Color(0xFFd43759),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).highlightColor,
                                blurRadius: 10.0,
                                offset: Offset(0, 10),
                              )
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 15.0, top: 12.0, bottom: 5.0),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    MdiIcons.bellRing,
                                    color: Colors.grey[200],
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Text(
                                    'Active Todos',
                                    style: TextStyle(
                                        fontFamily: 'Poppins-Medium',
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        decoration: TextDecoration.none),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 21.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: <Widget>[
                                  Text(
                                    '${state.numActive}',
                                    style: TextStyle(
                                        fontFamily: 'Poppins-Bold',
                                        color: Colors.white,
                                        fontSize: 39.0,
                                        decoration: TextDecoration.none),
                                  ),
                                  SizedBox(width: 8.0),
                                  Text(
                                    'Left',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        decoration: TextDecoration.none),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ))),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
