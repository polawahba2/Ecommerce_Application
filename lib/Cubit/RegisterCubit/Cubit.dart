import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/ClassModel/RegesterModel.dart';
import 'package:shop_app/DioHelper.dart';
import 'package:shop_app/Networks/EndPoints.dart';

import 'States.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit getCubit(context) => BlocProvider.of(context);

  ShopRegisterModel? RegisterModel;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(url: REGISTER, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {
      RegisterModel = ShopRegisterModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(RegisterModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }
}
