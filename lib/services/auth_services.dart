import 'package:chatia/core/utils/cache_helper.dart';
import 'package:chatia/services/database_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../core/utils/constants.dart';

class AuthServices {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

// logiun
  Future loginUsingEmailAndPassword(String email, String password) async {
    User user = (await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password))
        .user!;
  }

// register
  Future registerUsingEmailAndPassword(
      String fullName, String email, String password) async {
    User user = (await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user!;
    await DatabaseServices(uid: user.uid).savingUserData(fullName, email);
  }

  // log out

  Future logout() async {
    CacheHelper.saveData(key: isLoginKey, value: false);
    CacheHelper.saveData(key: emailKey, value: "");
    CacheHelper.saveData(key: fullNameKey, value: "");
    return await firebaseAuth.signOut();
  }
}





// class AuthenticationService{
//   final FirebaseAuth _firebaseAuth;

//   AuthenticationService(this._firebaseAuth);

//   Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();


//   Future<void> signOut() async{
//     await _firebaseAuth.signOut();
//   }

//   Future<void> sendPasswordResetEmail(String email) async{
//     return _firebaseAuth.sendPasswordResetEmail(email: email);
//   }


//   Future<String> signIn({String email, String password}) async{
//     try{
//       await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
//       return "Signed in";

//     } on FirebaseAuthException catch (e){
//       var errorCode = e.code;
//       var errorMessage = e.message;
      

//       if(errorCode == 'auth/wrong-password'){
//         return ('Wrong Password.');
//       }
//       else{
//         return errorMessage;
//       }
//     }

//   }

//   Future<String> signUp({String email, String password}) async{
//     try{
//       await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
//       return "Signed up";
//     } on FirebaseAuthException catch(e){
//       return e.message;
//     }
//   }


// }
