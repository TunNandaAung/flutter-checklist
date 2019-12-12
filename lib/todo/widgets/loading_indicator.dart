import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: SpinKitDoubleBounce(
      //color: Color(0xFF17ead9),
      color: Theme.of(context).cardColor,
    ));
  }
}
