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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Completed Todos',
                    style: TextStyle(
                        fontFamily: 'Poppins-Bold',
                        color: Colors.white,
                        fontSize: 25.0),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 24.0),
                  child: Text(
                    '${state.numCompleted}',
                    style: TextStyle(
                        fontFamily: 'Poppins-Medium',
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                ),
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
                )
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
