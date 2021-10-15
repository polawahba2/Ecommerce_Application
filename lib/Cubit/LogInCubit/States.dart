import 'package:shop_app/ClassModel/LogInModel.dart';

abstract class ShopLogInStates {}

class ShopLogInInitialState extends ShopLogInStates {}

class ShopLogInLoadingState extends ShopLogInStates {}

class ShopLogInSuccessState extends ShopLogInStates {
  final ShopLogInModel logInModel;
  ShopLogInSuccessState(this.logInModel);
}

class ShopLogInErrorState extends ShopLogInStates {
  final String error;
  ShopLogInErrorState(this.error);
}
