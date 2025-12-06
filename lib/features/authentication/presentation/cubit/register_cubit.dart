import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:session5_task/main.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  void toggleObscure() {
    emit(RegisterInitial());
  }

  registerUser(String email, String password) async {
    emit(RegisterLoading());
    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        emit(RegisterFailure('The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        emit(RegisterFailure('The account already exists for that email.'));
      }
    } catch (e) {
      print(e);
      emit(RegisterFailure(e.toString()));
    }
  }
  //thanks for Flutter Root youtube channel for google sign in help

  Future<void> signInWithGoogle() async {
    emit(RegisterLoading());
    // Trigger the authentication flow
    try {
      if (!isInitialized) {
        await googleSignIn.initialize(
          serverClientId:
              '1062772872326-8csh306hepjf9tjltqe6g31lbmroe2r2.apps.googleusercontent.com',
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
      emit(RegisterSuccess());
      return;
    } catch (e) {
      print(e);
      emit(RegisterFailure(e.toString()));
      return;
    }
  }

  Future<void> signout() async {
    emit(RegisterLoading());
    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
    emit(RegisterInitial());
  }
}
