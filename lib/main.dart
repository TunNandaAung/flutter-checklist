import 'package:firebase_integrations/data/user_repository.dart';
import 'package:firebase_integrations/login/ui/login_page.dart';
import 'package:firebase_integrations/profile_bloc/profile_barrel.dart';
import 'package:firebase_integrations/splash_screen.dart';
import 'package:firebase_integrations/todo/bloc/filtered_todos/filtered_todos_barrel.dart';
import 'package:firebase_integrations/todo/bloc/stats/stats_barrel.dart';
import 'package:firebase_integrations/todo/bloc/tabs/tabs_barrel.dart';
import 'package:firebase_integrations/todo/bloc/todos_bloc/todos_bloc_barrel.dart';
import 'package:firebase_integrations/todo/modal/add_modal.dart';
import 'package:firebase_integrations/todo/screens/screen.dart';
import 'package:firebase_integrations/todo/todos_repository/lib/todos_barrel.dart';
import 'package:firebase_integrations/utils/bloc_delegate.dart';
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
        BlocProvider<TodosBloc>(
          builder: (context) {
            return TodosBloc(
              _userRepository,
              todosRepository: FirebaseTodosRepository(),
            )..add(LoadTodos());
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Firestore Todos',
        theme: ThemeData(primaryColor: Color(0xFF5d74e3)),
        routes: {
          '/': (context) {
            return BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (state is Authenticated) {
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider<TabBloc>(
                        builder: (context) => TabBloc(),
                      ),
                      BlocProvider<FilteredTodosBloc>(
                        builder: (context) => FilteredTodosBloc(
                          todosBloc: BlocProvider.of<TodosBloc>(context),
                        ),
                      ),
                      BlocProvider<StatsBloc>(
                        builder: (context) => StatsBloc(
                          todosBloc: BlocProvider.of<TodosBloc>(context),
                        ),
                      ),
                      BlocProvider<ProfileBloc>(
                        builder: (context) => ProfileBloc(
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
      ),
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
