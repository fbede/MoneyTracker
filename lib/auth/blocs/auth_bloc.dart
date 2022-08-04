import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum AuthEvent { loading, signedIn, signedOut }

enum AuthState { loading, signedIn, signedOut }

var authStream = FirebaseAuth.instance.authStateChanges();

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState.loading) {
    on<AuthEvent>((event, emit) {
      authStream.listen((event) {
        if (event is User) {
          add(AuthEvent.signedIn);
        } else {
          add(AuthEvent.signedOut);
        }
      });
      on<AuthEvent>((event, emit) {
        switch (event) {
          case AuthEvent.signedIn:
            emit(AuthState.signedIn);
            break;
          case AuthEvent.signedOut:
            emit(AuthState.signedOut);
            break;

          default:
            emit(AuthState.loading);
        }
      });
    });
  }
}
