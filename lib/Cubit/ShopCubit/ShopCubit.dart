import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/ClassModel/CategoriesModel.dart';
import 'package:shop_app/ClassModel/ChangeFavoritesModel.dart';
import 'package:shop_app/ClassModel/GetFavoritesModel.dart';
import 'package:shop_app/ClassModel/HomeModel.dart';
import 'package:shop_app/ClassModel/LogInModel.dart';
import 'package:shop_app/Components/Constants.dart';
import 'package:shop_app/Cubit/ShopCubit/States.dart';
import 'package:shop_app/DioHelper.dart';
import 'package:shop_app/Networks/EndPoints.dart';
import 'package:shop_app/Screens/Categories/Categories.dart';
import 'package:shop_app/Screens/Favorates/FavoratesScreen.dart';
import 'package:shop_app/Screens/Products/ProductsScreen.dart';
import 'package:shop_app/Screens/Settings/Settings.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit getCubit(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoratesScreen(),
    SettingsScreen(),
  ];
  void changeIndex(int index) {
    currentIndex = index;
    emit(ShopChangeButtomNavState());
  }

  HomeModel? homeModel;

  Map<int, bool> favorites = {};
  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      // print(homeModel!.data.banners[11].image);
      // print(homeModel!);
      homeModel!.data.products.forEach((element) {
        favorites.addAll({element['id']: element['in_favorites']});
      });
      // print(favorites);
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState(error.toString()));
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    emit(ShopLoadingCategoryState());

    DioHelper.getData(
      url: GET_CATEGORIES,
      lang: 'en',
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      // print(categoriesModel!.data!.data[0].image);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState(error.toString()));
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void ChangeFavorites(int productId) {
    favorites[productId] = !(favorites[productId]!);
    emit(ShopSuccessChangeFavoritesState());
    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      // if (changeFavoritesModel!.status == false) {
      //   favorites[productId] = !(favorites[productId]!);
      // }
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      emit(ShopSuccessChangeFavoritesState());
      getFavorites();
    }).catchError((error) {
      // favorites[productId] = !(favorites[productId]!);

      emit(ShopErrorChangeFavoritesState(error.toString()));
    });
  }

  GetFavoritesModel? getFavoritesModel;

  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      getFavoritesModel = GetFavoritesModel.fromJson(value.data);
      print(getFavoritesModel!.data!.data[0]['product']['id']);

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesState(error.toString()));
    });
  }

  ShopLogInModel? userModel;
  void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      lang: 'en',
      token: token,
    ).then((value) {
      userModel = ShopLogInModel.fromJson(value.data);
      // print(userModel!.data!.name);

      emit(ShopSuccessUserDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState(error.toString()));
    });
  }

  void UpdateData({
    @required String? name,
    @required String? email,
    @required String? phone,
  }) {
    emit(ShopLoadingUpdatingDataState());
    DioHelper.putData(url: UPDATE_PROFILE, lang: 'en', token: token, data: {
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value) {
      userModel = ShopLogInModel.fromJson(value.data);
      // print(UpdatingModel!.data!.name);

      emit(ShopSuccessUpdatingDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdatingDataState(error.toString()));
    });
  }
}
