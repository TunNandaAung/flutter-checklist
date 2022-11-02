import 'package:checklist/todo/bloc/tabs/tab_cubit.dart';
import 'package:checklist/utils/connectivity/bloc/connectivity_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:checklist/data/user_repository.dart';
import 'package:checklist/login/ui/login_page.dart';
import 'package:checklist/preferences/preferences.dart';
import 'package:checklist/profile_bloc/profile_bloc.dart';
import 'package:checklist/splash_screen.dart';
import 'package:checklist/theme/app_theme.dart';
import 'package:checklist/theme/cubit/theme_cubit.dart';
import 'package:checklist/todo/bloc/filtered_todos/filtered_todos_bloc.dart';
import 'package:checklist/todo/bloc/stats/stats_bloc.dart';
import 'package:checklist/todo/bloc/todos_bloc/todos_bloc.dart';
import 'package:checklist/todo/screens/screen.dart';
import 'package:checklist/todo/todos_repository/lib/todos_barrel.dart';
import 'package:checklist/utils/bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'authentication_bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await Firebase.initializeApp();
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

  Checklist({Key? key, required UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  _ChecklistState createState() => _ChecklistState();
}

class _ChecklistState extends State<Checklist> {
  late AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc =
        AuthenticationBloc(userRepository: widget._userRepository);
    _authenticationBloc.add(AppStarted());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
        BlocProvider<ConnectivityBloc>(
            create: (context) =>
                ConnectivityBloc(result: ConnectivityResult.none)),
        BlocProvider<TodosBloc>(
          create: (context) {
            return TodosBloc(
              widget._userRepository,
              todosRepository: FirebaseTodosRepository(),
            );
          },
        ),
      ],
      child: BlocBuilder<ThemeCubit, AppTheme>(builder: (context, appTheme) {
        return ScreenUtilInit(
            designSize: const Size(800, 1600),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Firestore Todos',
                theme: appThemeData[appTheme],
                routes: {
                  '/': (context) {
                    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
                      builder: (context, state) {
                        if (state is Authenticated) {
                          context.watch<TodosBloc>().add(LoadTodos());
                          return MultiBlocProvider(
                            providers: [
                              BlocProvider<TabCubit>(
                                create: (context) => TabCubit(),
                              ),
                              BlocProvider<FilteredTodosBloc>(
                                create: (context) => FilteredTodosBloc(
                                  todosBloc: context.read<TodosBloc>(),
                                ),
                              ),
                              BlocProvider<StatsBloc>(
                                create: (context) => StatsBloc(
                                  todosBloc: context.read<TodosBloc>(),
                                ),
                              ),
                              BlocProvider<ProfileBloc>(
                                create: (context) => ProfileBloc(
                                  userRepository: widget._userRepository,
                                )..add(LoadProfile()),
                              ),
                            ],
                            child: HomeScreen(user: state.displayUser),
                          );
                        }
                        if (state is Unauthenticated) {
                          return LoginPage(
                              userRepository: widget._userRepository);
                        }
                        return SplashScreen();
                      },
                    );
                  },
                  '/addTodo': (context) {
                    return AddEditScreen(
                      onSave: (task, note) {
                        context.read<TodosBloc>().add(
                              AddTodo(Todo(task, note: note)),
                            );
                      },
                      isEditing: false,
                    );
                  },
                },
              );
            });
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
