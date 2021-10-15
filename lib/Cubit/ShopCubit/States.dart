abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeButtomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {
  String error;
  ShopErrorHomeDataState(this.error);
}

class ShopLoadingCategoryState extends ShopStates {}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {
  String error;
  ShopErrorCategoriesState(this.error);
}

class ShopSuccessChangeFavoritesState extends ShopStates {}

class ShopErrorChangeFavoritesState extends ShopStates {
  String error;
  ShopErrorChangeFavoritesState(this.error);
}

class ShopLoadingGetFavoritesState extends ShopStates {}

class ShopSuccessGetFavoritesState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates {
  String error;
  ShopErrorGetFavoritesState(this.error);
}

class ShopLoadingUserDataState extends ShopStates {}

class ShopSuccessUserDataState extends ShopStates {}

class ShopErrorUserDataState extends ShopStates {
  String error;
  ShopErrorUserDataState(this.error);
}

class ShopLoadingUpdatingDataState extends ShopStates {}

class ShopSuccessUpdatingDataState extends ShopStates {}

class ShopErrorUpdatingDataState extends ShopStates {
  String error;
  ShopErrorUpdatingDataState(this.error);
}
