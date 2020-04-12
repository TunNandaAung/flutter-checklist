import 'package:checklist/data/user_repository.dart';
import 'package:checklist/home_page.dart';
import 'package:checklist/login/bloc/login_barrel.dart';
import 'package:checklist/login/ui/login_page.dart';
import 'package:checklist/splash_screen.dart';
import 'package:checklist/utils/bloc_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'authentication_bloc/bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();
  runApp(
    BlocProvider(
      builder: (context) =>
          AuthenticationBloc(userRepository: userRepository)..add(AppStarted()),
      child: MyApp(userRepository: userRepository),
    ),
  );
}

class MyApp extends StatefulWidget {
  final UserRepository _userRepository;

  MyApp({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final UserRepository _userRepository = UserRepository();
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = AuthenticationBloc(userRepository: _userRepository);
    _authenticationBloc.add(AppStarted());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          builder: (context) => LoginBloc(userRepository: _userRepository),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Firebase',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
          if (state is Unauthenticated) {
            return LoginPage(userRepository: _userRepository);
          }
          if (state is Authenticated) {
            return HomePage(name: state.displayName);
          }
          return SplashScreen();
          // if (state is Authenticated) {
          //   return HomeScreen(name: state.displayName);
          // }
        }),
      ),
    );
  }
}
