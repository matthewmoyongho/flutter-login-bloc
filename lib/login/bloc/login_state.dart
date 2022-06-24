part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.username = const Username.pure(),
  });

  final FormzStatus status;
  final Username username;
  final Password password;

  LoginState copyWith({
    FormzStatus? status,
    Username? username,
    Password? password,
  }) {
    return LoginState(
      status: status ?? this.status,
      password: password ?? this.password,
      username: username ?? this.username,
    );
  }

  @override
  List<Object> get props => [status, username, password];
}

//class LoginInitial extends LoginState {}
