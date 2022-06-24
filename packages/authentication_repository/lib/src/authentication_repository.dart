import 'dart:async';

import 'dart:ffi';

enum AuthenticationStatus { unknown, authenticated, unAuthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future.delayed(Duration(seconds: 1));
    yield AuthenticationStatus.unAuthenticated;
    yield* _controller.stream;
  }

  Future<void> LogIn({
    required String username,
    required String password,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthenticationStatus.authenticated),
    );
  }

  void logout() => _controller.add(AuthenticationStatus.unAuthenticated);

  void dispose() => _controller.close();
}















// import 'dart:async';

// enum AuthenticationStatus { unknown, authenticated, unauthenticated }

// class AuthenticationRepository {
//   final _controller = StreamController<AuthenticationStatus>();

//   Stream<AuthenticationStatus> get status async* {
//     await Future<void>.delayed(const Duration(seconds: 1));
//     yield AuthenticationStatus.unauthenticated;
//     yield* _controller.stream;
//   }

//   Future<void> logIn({
//     required String username,
//     required String password,
//   }) async {
//     await Future.delayed(
//       const Duration(milliseconds: 300),
//       () => _controller.add(AuthenticationStatus.authenticated),
//     );
//   }

//   void logOut() {
//     _controller.add(AuthenticationStatus.unauthenticated);
//   }

//   void dispose() => _controller.close();
// }
