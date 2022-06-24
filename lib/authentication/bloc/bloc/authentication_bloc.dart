import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  late StreamSubscription<AuthenticationStatus> _authStatusStreamSubscription;
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AuthenticationState.unknown()) {
    on<AuthenticationStatusChange>(_authenticationStatusChanage);
    on<AuthenticationLogoutRequested>(_authenticationLogoutRequested);
    _authStatusStreamSubscription =
        _authenticationRepository.status.listen((status) {
      return add(AuthenticationStatusChange(status));
    });
  }

  void _authenticationStatusChanage(
      AuthenticationEvent event, Emitter<AuthenticationState> emmit) async {
    switch (state.status) {
      case AuthenticationStatus.unAuthenticated:
        return emit(AuthenticationState.unAuthenticated());
      case AuthenticationStatus.authenticated:
        final _user = await tryGetUser();
        return emit(_user != null
            ? AuthenticationState.authenticated(_user)
            : AuthenticationState.unAuthenticated());
      default:
        return emit(AuthenticationState.unknown());
    }
  }

  void _authenticationLogoutRequested(
      AuthenticationEvent event, Emitter<AuthenticationState> emit) {
    _authenticationRepository.logout();
    // emit(AuthenticationState.unAuthenticated());
  }

  @override
  Future<void> close() {
    _authStatusStreamSubscription.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  Future<User?> tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user;
    } catch (e) {
      return null;
    }
  }
}
