// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:otlab_controller/pages/auth/auth_page/auth_page.dart';

import '../my_library.dart';
import '../pages/auth/auth_page/controller/auth_page_controller.dart';
import '../utils/helpers.dart';
import '../value/constant.dart';
import 'firebase_store.dart';

class FirebaseAuthController with Helpers {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User get user => _firebaseAuth.currentUser!;

  bool get isLoggedIn => _firebaseAuth.currentUser != null;

  Future<User?> createAccount(BuildContext context,
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await _controlEmailValidation(context, credential: userCredential);
      return userCredential.user;
    } on FirebaseException catch (e) {
      _controllerErrorCode(context, e);
      getSheetError(e.toString());
      AuthPageController.isLoading.value = false;
    } catch (e) {
      log(e.toString());
      getSheetError(e.toString());
      AuthPageController.isLoading.value = false;

      return null;
    }
    return null;
  }

  Future<bool> forgetPassword(BuildContext context,
      {required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      //
      _controllerErrorCode(context, e);
      AuthPageController.isLoading.value = false;
    } catch (e) {
      log('exception is =>$e');
      AuthPageController.isLoading.value = false;

      return false;
    }
    return false;
  }

  Future<void> signOut() async {
    log('sign out done');
    await _firebaseAuth.signOut();
    AuthPageController.isLoading.value = false;
  }

  Future<bool> signIn(BuildContext context,
      {required String email, required String password}) async {
    try {
      log('i am in try');

      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return await _controlEmailValidation(context, credential: userCredential);
    } on FirebaseAuthException catch (e) {
      _controllerErrorCode(context, e);
      getSheetError(e.toString());
      AuthPageController.isLoading.value = false;
      return false;
    } catch (e) {
      log('i am in catch $e');
      getSheetError(e.toString());
      AuthPageController.isLoading.value = false;
    }
    return false;
  }

  Future<bool> _controlEmailValidation(BuildContext context,
      {required UserCredential credential}) async {
    if (!credential.user!.emailVerified) {
      AuthPageController.isLoading.value = false;

      await credential.user!.sendEmailVerification();
      await FirebaseAuthController().signOut();
      AuthPageController.isLoading.value = false;

      getSheetError('تم إرسال رابط لتفعيل حسابك على البريد الإلكتروني');
      return false;
    }
    return true;
  }

  void _controllerErrorCode(
      BuildContext context, FirebaseException authException) {
    String message = '';

    switch (authException.code) {
      case 'email-already-in-use':
        message = 'عذرًا البريد الإلكتروني موجود مسبقًا';

        break;
      case 'invalid-email':
        message = 'عذرًا  خطأ في البريد الإلكتروني';

        break;
      case 'operation-not-allowed':
        message = 'عذرًا  العملية غير مسموح بها';

        break;
      case 'weak-password':
        message = 'عذرًا  كلمة المرور ضعيفة';

        break;
      case 'user-not-found':
        message = 'عذرًا  المستخدم غير موجود';

        break;
      case 'requires-recent-login':
        message = 'عذرًا يرجى إعادة تسجيل الدخول';

        break;

      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
        // case "email-already-in-use":
        message = 'عذرًا البريد الإلكتروني موجود مسبقًا';
        break;

      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        message = "عذرًا خطأ في كلمة المرور/ البريد الإلكتروني";
        break;
      case "ERROR_USER_NOT_FOUND":
        // case "user-not-found":
        message = 'عذرًا  المستخدم غير موجود';
        break;
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        message = "عذرًا الحساب معطل";
        break;
      case "ERROR_TOO_MANY_REQUESTS":
        // case "operation-not-allowed":
        message = 'عذرًا  العملية غير مسموح بها';
        break;
      // case "ERROR_OPERATION_NOT_ALLOWED":
      // case "operation-not-allowed":
      //   message = "Server error, please try again later.";
      //   break;
      case "ERROR_INVALID_EMAIL":
        // case "invalid-email":
        message = 'عذرًا  خطأ في البريد الإلكتروني';
        break;

      default:
        message = "مشكلة في تسجيل الدخول الرجاء المحاولة مرة أخرى";
        break;
    }
    AuthPageController.isLoading.value = false;

    getSheetError(message);
  }

  Future<bool> updateEmailAuth(BuildContext context,
      {required String email}) async {
    try {
      if (email != user.email) {
        await _firebaseAuth.currentUser!.verifyBeforeUpdateEmail(email);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log('error${e.toString()}');
      getSheetError('عذرًا البريد موجود مسبقًا');
      return false;
    }
  }

  Future<bool> updatePassword(
      {required BuildContext context,
      required String? password,
      required String collectionName}) async {
    if (password != null && password.isNotEmpty) {
      if (password.length >= 6) {
        await _firebaseAuth.currentUser!
            .updatePassword(password)
            .then((value) async {
          bool status = await FirebaseFirestoreController().updatePassword(
              collectionName: collectionName,
              password: password,
              uid: _firebaseAuth.currentUser!.uid);
          if (status) {
            AuthPageController.isLoading.value = false;
            getSheetSucsses('تمت العملية بنجاح');
            AppPreferences().logOutUser();
            Get.off(const AuthPage());
          }
          return status;
        }).catchError((value) {
          debugPrint('updatePassword error is $value');
          getSheetError(value.toString());
          AuthPageController.isLoading.value = false;

          return false;
        });
      }
      return false;
    } else {
      AuthPageController.isLoading.value = false;

      getSheetError('يجب ان تحتوي كلمة المرور على 6 ارقام او احرف');
      return false;
    }
  }
}
