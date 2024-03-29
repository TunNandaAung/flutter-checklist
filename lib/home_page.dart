import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'authentication_bloc/bloc.dart';

class HomePage extends StatelessWidget {
  final String name;

  const HomePage({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              context.read<AuthenticationBloc>().add(
                    LoggedOut(),
                  );
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(child: Text('Welcome $name!')),
        ],
      ),
    );
  }
}
