import 'package:firebase_integrations/todo/bloc/stats/stats_barrel.dart';
import 'package:firebase_integrations/todo/widgets/loading_indicator.dart';
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
                      height: 108,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Color(0xFF4293f5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
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
                                      color: Colors.grey[200],
                                      fontSize: 18.0),
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
                                      fontSize: 36.0),
                                ),
                                SizedBox(width: 8.0),
                                Text(
                                  'Done',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15.0),
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
                        height: 108,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Color(0xFFd43759),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black54,
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
                                        color: Colors.grey[200],
                                        fontSize: 18.0),
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
                                        fontSize: 36.0),
                                  ),
                                  SizedBox(width: 8.0),
                                  Text(
                                    'Left',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15.0),
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
