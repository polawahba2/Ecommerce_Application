abstract class ShopSearchStates {}

class ShopSearchInitialState extends ShopSearchStates {}

class ShopSearchLoadingState extends ShopSearchStates {}

class ShopSearchSuccessState extends ShopSearchStates {
  // final ShopSearchModel SearchModel;
  // ShopSearchSuccessState(this.SearchModel);
}

class ShopSearchErrorState extends ShopSearchStates {
  final String error;
  ShopSearchErrorState(this.error);
}
