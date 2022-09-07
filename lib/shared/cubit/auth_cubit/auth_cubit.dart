import 'package:ecommerce/models/user_model.dart';
import 'package:ecommerce/shared/network/remote/firebase_helper.dart';
import 'package:ecommerce/shared/widgets/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart';
import '../../network/local/cache_helper.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitState());

  static AuthCubit get(BuildContext context) => BlocProvider.of(context);

  bool _showPassword = false;
  bool get showPassword => _showPassword;

  bool _isLogin = true;
  bool get isLogin => _isLogin;

  //log user in
  Future<void> logUserIn(
      {required String email, required String password}) async {
    emit(AuthLoadingState());
    await FirebaseHelper().login(email: email, password: password).then(
      (uid) {
        Constants.userId = uid;
        debugPrint(uid);
        CacheHelper.save(key: 'uid', data: Constants.userId);
        //TODO: Customize this
        defaultToast(
            message: 'Logged in successfully!',
            bgColor: Colors.teal,
            txColor: Colors.white);
        emit(AuthLoginSuccessState());
      },
    ).catchError(
      (error) {
        //TODO: Customize this
        defaultToast(
            message: error.toString(),
            bgColor: Colors.red,
            txColor: Colors.black);
        emit(AuthLoginErrorState());
      },
    );
  }

  //create new user
  Future<void> createUser(
      {required String username,
      required String phoneNumber,
      required String email,
      required String password}) async {
    emit(AuthLoadingState());
    await FirebaseHelper()
        .register(username, phoneNumber, email, password)
        .then(
      (uid) async {
        Constants.userId = uid;
        debugPrint(uid);
        CacheHelper.save(key: 'uid', data: Constants.userId);

        UserModel _model = UserModel(
          uid: uid,
          username: username,
          email: email,
          phoneNumber: phoneNumber,
        );

        await FirebaseHelper()
            .save(collection: 'users', data: _model.toJson(), docId: uid);
        //TODO: Customize this
        defaultToast(
            message: 'User created successfully!',
            bgColor: Colors.teal,
            txColor: Colors.white);
        emit(AuthRegisterSuccessState());
      },
    ).catchError((error) {
      //TODO: Customize this
      defaultToast(
          message: error.toString(),
          bgColor: Colors.red,
          txColor: Colors.black);
      emit(AuthRegisterErrorState());
    });
  }

  //log user out
  Future<void> logUserOut() async {
    emit(AuthLoadingState());
    await FirebaseHelper().logOut().then(
      (_) {
        CacheHelper.remove(key: 'uid');
        defaultToast(
            message: 'Logged out successfully!',
            bgColor: Colors.teal,
            txColor: Colors.white);
        emit(AuthLogOutSuccessState());
      },
    ).catchError((error) {
      //TODO: Customize this
      defaultToast(
          message: error.toString(),
          bgColor: Colors.red,
          txColor: Colors.black);
      emit(AuthLogOutErrorState());
    });
  }

  void changePageState() {
    _isLogin = !_isLogin;
    emit(AuthChangePageState());
  }

  void changePasswordVisibility() {
    _showPassword = !_showPassword;
    emit(AuthChangePassVisibilityState());
  }
}
