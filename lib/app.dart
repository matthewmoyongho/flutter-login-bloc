import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc/authentication/bloc/bloc/authentication_bloc.dart';
import 'package:login_bloc/slpash/view/splsh_page.dart';
import 'package:user_repository/user_repository.dart';

import 'home/view/home_page.dart';
import 'login/view/login_page.dart';

class App extends StatelessWidget {
  App(
      {Key? key,
      required this.authenticationRepository,
      required this.userRepository})
      : super(key: key);
  final UserRepository userRepository;
  final AuthenticationRepository authenticationRepository;
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (context) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
          userRepository: userRepository,
        ),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //key: _navKey,
      builder: (context, child) =>
          BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          switch (state.status) {
            case AuthenticationStatus.authenticated:
              _navKey.currentState!.pushAndRemoveUntil<void>(
                HomePage.route(),
                (route) => false,
              );
              break;
            case AuthenticationStatus.unAuthenticated:
              _navKey.currentState!.pushAndRemoveUntil<void>(
                LoginPage.route(),
                (route) => false,
              );
              break;
            default:
              break;
          }
        },
        child: child,
      ),
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
