import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../main.dart';
import 'package:google_sign_in/google_sign_in.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  void toggleObscure() {
    emit(LoginInitial());
  }

  loginUser(String email, String password) async {
    emit(LoginLoading());
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        emit(LoginFailure('No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        emit(LoginFailure('Wrong password provided for that user.'));
      }
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
//thanks for Flutter Root youtube channel for google sign in help
  Future<void> signInWithGoogle() async {
    emit(LoginLoading());
    // Trigger the authentication flow
    try {
      if (!isInitialized) {
        await googleSignIn.initialize(
          serverClientId:
               'here is the firebase google sign in server client id from google sign in method of authentication',
        );
        isInitialized = true;
      }
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn
          .authenticate();
      // Obtain the auth details from the request
      if (googleSignInAccount == null) {
        throw FirebaseAuthException(
          code: 'SIGNIN ABORTED BY USER',
          message: 'Sign in incomplete because user Exited.',
        );
      }

      final idToken = googleSignInAccount.authentication.idToken;
      final accessClient = googleSignInAccount.authorizationClient;

      GoogleSignInClientAuthorization? googleSignInAuthentication =
          await accessClient.authorizationForScopes(['email', 'profile']);
      final accessToken = googleSignInAuthentication?.accessToken;
      if (accessToken == null) {
        final auth2 = await accessClient.authorizationForScopes([
          'email',
          'profile',
        ]);
        if (auth2 == null || auth2.accessToken == null) {
          throw FirebaseAuthException(
            code: 'NO ACCESS TOKEN',
            message: 'Failed to retrieve access token.',
          );
        }
        googleSignInAuthentication = auth2;
      }
      final credential = GoogleAuthProvider.credential(
        accessToken: accessToken,
        idToken: idToken,
      );
      userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
      emit(LoginSuccess());
      return;
    } catch (e) {
      print(e);
      emit(LoginFailure(e.toString()));
      return;
    }
  }

  Future<void> signout() async {
    emit(LoginLoading());
    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
    emit(LoginInitial());
  }
}
