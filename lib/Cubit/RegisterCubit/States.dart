import 'package:shop_app/ClassModel/RegesterModel.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitialState extends ShopRegisterStates {}

class ShopRegisterLoadingState extends ShopRegisterStates {}

class ShopRegisterSuccessState extends ShopRegisterStates {
  final ShopRegisterModel RegisterModel;
  ShopRegisterSuccessState(this.RegisterModel);
}

class ShopRegisterErrorState extends ShopRegisterStates {
  final String error;
  ShopRegisterErrorState(this.error);
}

class ShopUpdateProfileLoadingState extends ShopRegisterStates {}

class ShopUpdateProfileSuccessState extends ShopRegisterStates {
  final ShopRegisterModel UpdateProfileModel;
  ShopUpdateProfileSuccessState(this.UpdateProfileModel);
}

class ShopUpdateProfileErrorState extends ShopRegisterStates {
  final String error;
  ShopUpdateProfileErrorState(this.error);
}
