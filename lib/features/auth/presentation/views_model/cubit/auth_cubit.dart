import 'package:chatia/features/auth/data/user_model.dart';
import 'package:chatia/services/auth_services.dart';
import 'package:chatia/services/database_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  AuthServices authServices = AuthServices();
  DatabaseServices dbServices = DatabaseServices();
  UserModel? userModel;

  static AuthCubit get(context) => BlocProvider.of(context);
  Future<void> login(String email, String password) async {
    emit(LoginLoadingState());
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      QuerySnapshot snapshot =
          await DatabaseServices(uid: FirebaseAuth.instance.currentUser!.uid)
              .gettingUserData(email);
      userModel = UserModel(
        uid: FirebaseAuth.instance.currentUser!.uid,
        fullName: snapshot.docs[0]["fullName"],
        email: email,
        password: password,
      );
      print(userModel);
      emit(LoginSucessState(userModel!));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginErrorState('No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(LoginErrorState('Wrong password provided for that user.'));
      }
    }
  }

  Future<void> register(String fullName, String email, String password) async {
    emit(RegisterLoadingState());
    try {
      User user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user!;
      await DatabaseServices(uid: user.uid).savingUserData(fullName, email);

      userModel = UserModel(
        uid: user.uid,
        fullName: fullName,
        email: email,
        password: password,
      );
      print(userModel);
      emit(RegisterSucessState(userModel!));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterErrorState('The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterErrorState('The account already exists for that email.'));
      }
    } catch (e) {
      emit(RegisterErrorState(e.toString()));
    }
  }

  bool obscureText = true;
  IconData suffix = Icons.visibility_rounded;
  void changeEyeIcon() {
    obscureText = !obscureText;
    suffix =
        obscureText ? Icons.visibility_rounded : Icons.visibility_off_rounded;
    emit(ChangePassIcon());
  }
}
