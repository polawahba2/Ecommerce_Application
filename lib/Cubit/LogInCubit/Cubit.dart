import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/ClassModel/LogInModel.dart';
import 'package:shop_app/DioHelper.dart';
import 'package:shop_app/Networks/EndPoints.dart';

import 'States.dart';

class ShopLogInCubit extends Cubit<ShopLogInStates> {
  ShopLogInCubit() : super(ShopLogInInitialState());

  static ShopLogInCubit getCubit(context) => BlocProvider.of(context);

  ShopLogInModel? logInModel;

  void userLogin({required String email, required String password}) {
    emit(ShopLogInLoadingState());
    DioHelper.postData(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      logInModel = ShopLogInModel.fromJson(value.data);
      emit(ShopLogInSuccessState(logInModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLogInErrorState(error.toString()));
    });
  }
}
