import 'package:firebase_integrations/todo/bloc/stats/stats_barrel.dart';
import 'package:firebase_integrations/todo/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10.0,
                              offset: Offset(0, 10),
                            )
                          ],
                          gradient: LinearGradient(
                              colors: [Color(0xFF4B79A1), Color(0xFF283E51)])),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 12.0, bottom: 30.0),
                            child: Text(
                              'Completed Todos',
                              style: TextStyle(
                                  fontFamily: 'Poppins-Medium',
                                  color: Colors.white,
                                  fontSize: 18.0),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 0.0),
                            child: Text(
                              '${state.numCompleted}',
                              style: TextStyle(
                                  fontFamily: 'Poppins-Medium',
                                  color: Colors.white,
                                  fontSize: 30.0),
                            ),
                          ),
                        ],
                      )),
                ),
                SizedBox(height: 50.0),
                Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.white),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'Active Todos',
                            style: TextStyle(
                                fontFamily: 'Poppins-Bold',
                                color: Colors.white,
                                fontSize: 25.0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 24.0),
                          child: Text(
                            "${state.numActive}",
                            style: TextStyle(
                                fontFamily: 'Poppins-Bold',
                                color: Colors.white,
                                fontSize: 20.0),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
