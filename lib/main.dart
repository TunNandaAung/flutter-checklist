import 'package:connectivity/connectivity.dart';
import 'package:checklist/data/user_repository.dart';
import 'package:checklist/login/ui/login_page.dart';
import 'package:checklist/preferences/preferences.dart';
import 'package:checklist/profile_bloc/profile_barrel.dart';
import 'package:checklist/splash_screen.dart';
import 'package:checklist/theme/app_theme.dart';
import 'package:checklist/theme/bloc/theme_barrel.dart';
import 'package:checklist/todo/bloc/filtered_todos/filtered_todos_barrel.dart';
import 'package:checklist/todo/bloc/stats/stats_barrel.dart';
import 'package:checklist/todo/bloc/tabs/tabs_barrel.dart';
import 'package:checklist/todo/bloc/todos_bloc/todos_bloc_barrel.dart';
import 'package:checklist/todo/screens/screen.dart';
import 'package:checklist/todo/todos_repository/lib/todos_barrel.dart';
import 'package:checklist/utils/bloc_observer.dart';
import 'package:checklist/utils/connectivity/bloc/connectivity_barrel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'authentication_bloc/bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  final UserRepository userRepository = UserRepository();
  Prefer.prefs = await SharedPreferences.getInstance();
  Prefer.themeIndexPref = Prefer.prefs.getInt('theme') ?? 1;

  runApp(
    BlocProvider(
      create: (context) =>
          AuthenticationBloc(userRepository: userRepository)..add(AppStarted()),
      child: Checklist(userRepository: userRepository),
    ),
  );
}

class Checklist extends StatefulWidget {
  final UserRepository _userRepository;

  Checklist({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  _ChecklistState createState() => _ChecklistState();
}

class _ChecklistState extends State<Checklist> {
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
        BlocProvider<ThemeBloc>(create: (context) => ThemeBloc()),
        BlocProvider<ConnectivityBloc>(
          create: (context) => ConnectivityBloc(result: ConnectivityResult.none)
            ..add(CheckConnectivity()),
        ),
        BlocProvider<TodosBloc>(
          create: (context) {
            return TodosBloc(
              _userRepository,
              todosRepository: FirebaseTodosRepository(),
            );
          },
        ),
      ],
      child: BlocBuilder<ThemeBloc, AppTheme>(builder: (context, appTheme) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Firestore Todos',
          theme: appThemeData[appTheme],
          routes: {
            '/': (context) {
              return BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  if (state is Authenticated) {
                    BlocProvider.of<TodosBloc>(context).add(LoadTodos());
                    return MultiBlocProvider(
                      providers: [
                        BlocProvider<TabBloc>(
                          create: (context) => TabBloc(),
                        ),
                        BlocProvider<FilteredTodosBloc>(
                          create: (context) => FilteredTodosBloc(
                            todosBloc: BlocProvider.of<TodosBloc>(context),
                          ),
                        ),
                        BlocProvider<StatsBloc>(
                          create: (context) => StatsBloc(
                            todosBloc: BlocProvider.of<TodosBloc>(context),
                          ),
                        ),
                        BlocProvider<ProfileBloc>(
                          create: (context) => ProfileBloc(
                            userRepository: _userRepository,
                          )..add(LoadProfile()),
                        ),
                      ],
                      child: HomeScreen(user: state.displayUser),
                    );
                  }
                  if (state is Unauthenticated) {
                    return LoginPage(userRepository: _userRepository);
                  }
                  return SplashScreen();
                },
              );
            },
            '/addTodo': (context) {
              return AddEditScreen(
                onSave: (task, note) {
                  BlocProvider.of<TodosBloc>(context).add(
                    AddTodo(Todo(task, note: note)),
                  );
                },
                isEditing: false,
              );
            },
          },
        );
      }),
    );
  }
}

// BlocBuilder<AuthenticationBloc, AuthenticationState>(
//           builder: (context, state) {
//         if (state is Unauthenticated) {
//           return LoginPage(userRepository: _userRepository);
//         }
//         if (state is Authenticated) {
//           return HomePage(name: state.displayName);
//         }
//         return SplashScreen();
//         // if (state is Authenticated) {
//         //   return HomeScreen(name: state.displayName);
//         // }
//       })
